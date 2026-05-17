#!/usr/bin/env bash
# Claude Code statusLine — minimal/modern 3-line display
# Receives JSON on stdin from Claude Code

input=$(cat)

# ---------------------------------------------------------------------------
# Parse core fields from stdin JSON
# ---------------------------------------------------------------------------
model_name=$(printf '%s' "$input" | jq -r '.model.display_name // ""')
model_id=$(printf '%s' "$input"   | jq -r '.model.id // ""')
transcript_path=$(printf '%s' "$input" | jq -r '.transcript_path // ""')

# Determine context window size: 1M for [1m] model variant, else 200K
ctx_total=200000
if printf '%s' "$model_id" | grep -qi '\[1m\]' || printf '%s' "$model_name" | grep -qi '1m'; then
  ctx_total=1000000
fi

# ---------------------------------------------------------------------------
# Parse transcript for latest usage + cumulative cost
# ---------------------------------------------------------------------------
# Each line of the transcript is a JSON object.  We want:
#   - latest assistant message usage (for context window display)
#   - sum of all usage for cost calculation
# We use python3 for speed and to handle malformed lines gracefully.
# ---------------------------------------------------------------------------
TRANSCRIPT_STATS=$(python3 - "$transcript_path" "$ctx_total" <<'PYEOF'
import sys, json, math

transcript_path = sys.argv[1] if len(sys.argv) > 1 else ""
ctx_total = int(sys.argv[2]) if len(sys.argv) > 2 else 200000

# Pricing (Opus 4.x) per token
PRICE_INPUT        = 15.00   / 1_000_000
PRICE_CACHE_WRITE  = 18.75   / 1_000_000
PRICE_CACHE_READ   =  1.50   / 1_000_000
PRICE_OUTPUT       = 75.00   / 1_000_000

total_cost    = 0.0
latest_input  = 0
latest_output = 0
latest_cache_write = 0
latest_cache_read  = 0
found_any = False

if transcript_path and transcript_path != "/dev/null":
    try:
        with open(transcript_path, "r", errors="replace") as f:
            for raw in f:
                raw = raw.strip()
                if not raw:
                    continue
                try:
                    obj = json.loads(raw)
                except Exception:
                    continue
                # Usage can live at top level or nested under message
                usage = obj.get("usage") or (obj.get("message") or {}).get("usage") or {}
                if not usage:
                    continue
                inp   = usage.get("input_tokens", 0) or 0
                out   = usage.get("output_tokens", 0) or 0
                cw    = usage.get("cache_creation_input_tokens", 0) or 0
                cr    = usage.get("cache_read_input_tokens", 0) or 0
                # Only count entries that have real token data
                if inp == 0 and out == 0 and cw == 0 and cr == 0:
                    continue
                total_cost += inp * PRICE_INPUT + out * PRICE_OUTPUT + cw * PRICE_CACHE_WRITE + cr * PRICE_CACHE_READ
                # Track latest (last) assistant entry
                latest_input  = inp
                latest_output = out
                latest_cache_write = cw
                latest_cache_read  = cr
                found_any = True
    except Exception:
        pass

if found_any:
    # Context window usage = all input variants + output
    # (cache_read + cache_creation hold most of the prompt; input_tokens is just the uncached delta)
    ctx_used = latest_input + latest_cache_write + latest_cache_read + latest_output
    ctx_pct  = min(100.0, ctx_used / ctx_total * 100.0)
    print(f"CTX_USED={ctx_used}")
    print(f"CTX_PCT={ctx_pct:.1f}")
    print(f"COST={total_cost:.2f}")
else:
    print("CTX_USED=0")
    print("CTX_PCT=0")
    print("COST=0.00")
PYEOF
)

# Source the key=value pairs from python output
eval "$TRANSCRIPT_STATS" 2>/dev/null

CTX_USED=${CTX_USED:-0}
CTX_PCT=${CTX_PCT:-0}
COST=${COST:-0.00}

# ---------------------------------------------------------------------------
# Rate limit data — read from stdin JSON (Claude Code passes it in)
# ---------------------------------------------------------------------------
five_pct=$(printf '%s' "$input"       | jq -r '.rate_limits.five_hour.used_percentage // ""')
five_reset=$(printf '%s' "$input"     | jq -r '.rate_limits.five_hour.resets_at // ""')
weekly_pct=$(printf '%s' "$input"     | jq -r '.rate_limits.seven_day.used_percentage // ""')
weekly_reset=$(printf '%s' "$input"   | jq -r '.rate_limits.seven_day.resets_at // ""')

# Format unix epoch reset times to human-readable
format_time() {
  local epoch="$1"
  [ -z "$epoch" ] || [ "$epoch" = "null" ] && echo "" && return
  # macOS date syntax
  date -r "$epoch" "+%-I:%M %p" 2>/dev/null || date -d "@$epoch" "+%-I:%M %p" 2>/dev/null || echo ""
}

format_date_time() {
  local epoch="$1"
  [ -z "$epoch" ] || [ "$epoch" = "null" ] && echo "" && return
  date -r "$epoch" "+%b %-d, %-I:%M %p" 2>/dev/null || date -d "@$epoch" "+%b %-d, %-I:%M %p" 2>/dev/null || echo ""
}

five_reset_fmt=$(format_time "$five_reset")
weekly_reset_fmt=$(format_date_time "$weekly_reset")

# ---------------------------------------------------------------------------
# ANSI truecolor helpers
# ---------------------------------------------------------------------------
# Usage: rgb <r> <g> <b>  → sets foreground color
rgb() { printf '\033[38;2;%d;%d;%dm' "$1" "$2" "$3"; }
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'

# Palette
C_LABEL=$(rgb 140 140 160)     # muted lavender-gray for labels
C_SEP=$(rgb 80 80 100)         # dim separator
C_MODEL=$(rgb 200 160 255)     # soft purple for model name
C_NUM=$(rgb 220 220 230)       # near-white for numbers
C_COST=$(rgb 180 200 140)      # muted green for cost
C_TIME=$(rgb 160 190 220)      # pale blue for times

# Color a progress bar/percentage by fill level
pct_color() {
  local pct="$1"
  local int_pct
  int_pct=$(printf '%.0f' "$pct" 2>/dev/null || echo 0)
  if   [ "$int_pct" -ge 80 ]; then rgb 220 80  80   # red
  elif [ "$int_pct" -ge 50 ]; then rgb 220 180 60   # amber
  else                              rgb 80  200 120  # green
  fi
}

# ---------------------------------------------------------------------------
# Build a Unicode block progress bar
# Width = 10 chars, filled with █, remainder with ░
# ---------------------------------------------------------------------------
make_bar() {
  local pct="$1"
  local width=10
  local filled
  filled=$(python3 -c "import sys; p=float(sys.argv[1]); w=int(sys.argv[2]); print(round(p/100*w))" "$pct" "$width" 2>/dev/null || echo 0)
  local empty=$(( width - filled ))
  local bar=""
  local i
  for (( i=0; i<filled; i++ )); do bar="${bar}█"; done
  for (( i=0; i<empty;  i++ )); do bar="${bar}░"; done
  printf '%s' "$bar"
}

SEP="${C_SEP} │ ${RESET}"

# ---------------------------------------------------------------------------
# Line 1: Model │ bar pct% │ tokens_used/total │ $cost
# ---------------------------------------------------------------------------

# Format token counts: show as e.g. "124k" / "1.0m"
fmt_tokens() {
  local n="$1"
  if   [ "$n" -ge 1000000 ]; then python3 -c "print(f'{$n/1000000:.1f}m')" 2>/dev/null || echo "${n}"
  elif [ "$n" -ge 1000 ];    then python3 -c "print(f'{$n/1000:.0f}k')"    2>/dev/null || echo "${n}"
  else echo "$n"
  fi
}

fmt_ctx_total() {
  local n="$1"
  if   [ "$n" -ge 1000000 ]; then echo "1.0m"
  else echo "200k"
  fi
}

ctx_pct_int=$(printf '%.0f' "$CTX_PCT" 2>/dev/null || echo 0)
ctx_bar_color=$(pct_color "$CTX_PCT")
ctx_bar=$(make_bar "$CTX_PCT")
ctx_used_fmt=$(fmt_tokens "$CTX_USED")
ctx_total_fmt=$(fmt_ctx_total "$ctx_total")

model_display="${model_name:-claude}"
# Strip trailing whitespace
model_display="${model_display%"${model_display##*[![:space:]]}"}"

line1=""
line1+="$(printf '%b' "${C_MODEL}${BOLD}")${model_display}$(printf '%b' "${RESET}")"
line1+="$(printf '%b' "$SEP")"
line1+="$(printf '%b' "${ctx_bar_color}")${ctx_bar}$(printf '%b' "${RESET}")"
line1+=" $(printf '%b' "${C_NUM}")${ctx_pct_int}%$(printf '%b' "${RESET}")"
line1+="$(printf '%b' "$SEP")"
line1+="$(printf '%b' "${C_NUM}")${ctx_used_fmt}/$(printf '%b' "${RESET}")$(printf '%b' "${C_LABEL}")${ctx_total_fmt}$(printf '%b' "${RESET}")"
line1+="$(printf '%b' "$SEP")"
line1+="$(printf '%b' "${C_COST}")\$${COST}$(printf '%b' "${RESET}")"

printf '%b\n' "$line1"

# ---------------------------------------------------------------------------
# Lines 2 & 3: rate-limit rows (only if data is present)
# ---------------------------------------------------------------------------

render_rate_row() {
  local label="$1"
  local pct="$2"
  local reset_fmt="$3"

  [ -z "$pct" ] || [ "$pct" = "null" ] && return

  local pct_int
  pct_int=$(printf '%.0f' "$pct" 2>/dev/null || echo 0)
  local bar_color
  bar_color=$(pct_color "$pct")
  local bar
  bar=$(make_bar "$pct")

  local row=""
  row+="$(printf '%b' "${C_LABEL}")${label}$(printf '%b' "${RESET}")"
  row+="  "
  row+="$(printf '%b' "${C_NUM}")${pct_int}%$(printf '%b' "${RESET}")"
  row+=" "
  row+="$(printf '%b' "${bar_color}")${bar}$(printf '%b' "${RESET}")"
  if [ -n "$reset_fmt" ]; then
    row+=" $(printf '%b' "${C_TIME}")${reset_fmt}$(printf '%b' "${RESET}")"
  fi
  printf '%b\n' "$row"
}

render_rate_row "Current" "$five_pct"  "$five_reset_fmt"
render_rate_row "Weekly"  "$weekly_pct" "$weekly_reset_fmt"
