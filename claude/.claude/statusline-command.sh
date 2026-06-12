#!/bin/sh
# Claude Code statusLine — minimal/modern 3-line display
# Receives JSON on stdin from Claude Code
# Schema: https://code.claude.com/docs/en/statusline
#
# The whole render — parsing, math, date formatting, bars, colors — happens in
# one jq program, exec'd directly: a single process, no subshell forks, so
# shell startup time is irrelevant.

exec jq -r '
  # ---- palette --------------------------------------------------------------
  def rgb(r; g; b): "\u001b[38;2;\(r);\(g);\(b)m";
  def RESET: "\u001b[0m";
  def BOLD:  "\u001b[1m";
  def C_LABEL: rgb(140; 140; 160);   # muted lavender-gray for labels
  def C_SEP:   rgb(80; 80; 100);     # dim separator
  def C_MODEL: rgb(200; 160; 255);   # soft purple for model name
  def C_NUM:   rgb(220; 220; 230);   # near-white for numbers
  def C_COST:  rgb(180; 200; 140);   # muted green for cost
  def C_TIME:  rgb(160; 190; 220);   # pale blue for times
  def RED:   rgb(220; 80; 80);
  def AMBER: rgb(220; 180; 60);
  def GREEN: rgb(80; 200; 120);
  def SEP: C_SEP + " │ " + RESET;

  # high usage = bad
  def pct_color: if . >= 80 then RED elif . >= 50 then AMBER else GREEN end;
  # low remaining = bad
  def remaining_color: if . <= 20 then RED elif . <= 50 then AMBER else GREEN end;

  # ---- formatting helpers ----------------------------------------------------
  # 10-char block bar from an integer percentage
  def bar:
    ([(. * 10 + 50) / 100 | floor, 10] | min) as $f
    | (if $f > 0 then "█" * $f else "" end)
    + (if $f < 10 then "░" * (10 - $f) else "" end);

  # token counts as e.g. "124k" / "1.0m"
  def fmt_tokens:
    if . >= 1000000 then
      ((. / 100000 | round) as $d
       | if $d % 10 == 0 then "\($d / 10 | floor).0m" else "\($d / 10)m" end)
    elif . >= 1000 then "\(. / 1000 | round)k"
    else tostring end;

  # fixed two decimals, e.g. 4.5 -> "4.50"
  def fmt_cost:
    (. * 100 | round) as $c
    | "\($c / 100 | floor).\(100 + ($c % 100) | tostring | .[1:])";

  def countdown:
    (. - now | floor) as $d
    | if   $d <= 60   then "now"
      elif $d < 3600  then "in \($d / 60 | floor)m"
      elif $d < 86400 then "in \($d / 3600 | floor)h"
      else                 "in \($d / 86400 | floor)d"
      end;

  # "in 2h (6:47 PM)" — absolute time dropped when reset is imminent
  def reset_fmt(fmt):
    countdown as $cd
    | if $cd == "now" then "now" else "\($cd) (\(strflocaltime(fmt)))" end;

  # rate-limit row: label  N% left ██████░░░░ in 2h (6:47 PM)
  def rate_row(name; fmt):
    if .used_percentage == null then empty
    else
      ((100 - .used_percentage) | if . < 0 then 0 else . end | round) as $rem
      | C_LABEL + name + RESET
      + "  " + C_NUM + "\($rem)% left" + RESET
      + " " + ($rem | remaining_color) + ($rem | bar) + RESET
      + (if .resets_at then " " + C_TIME + (.resets_at | reset_fmt(fmt)) + RESET
         else "" end)
    end;

  # ---- render -----------------------------------------------------------------
  (.model.display_name // "claude") as $model
  | (if .effort.level then "\($model) (\(.effort.level))" else $model end) as $model
  | ((.context_window.total_input_tokens // 0)
     + (.context_window.total_output_tokens // 0)) as $used
  | (.context_window.context_window_size // 200000) as $total
  | (.context_window.used_percentage // 0 | round) as $pct
  | (.cost.total_cost_usd // 0) as $cost

  # Line 1: Model (effort) │ bar pct% │ used/total │ $cost
  | [ C_MODEL + BOLD + $model + RESET
      + SEP + ($pct | pct_color) + ($pct | bar) + RESET
      + " " + C_NUM + "\($pct)%" + RESET
      + SEP + C_NUM + ($used | fmt_tokens) + "/" + RESET
      + C_LABEL + ($total | fmt_tokens) + RESET
      + SEP + C_COST + "$" + ($cost | fmt_cost) + RESET

  # Lines 2 & 3: rate-limit rows (only if data is present)
    , (.rate_limits.five_hour // {} | rate_row("5-hour limit"; "%-I:%M %p"))
    , (.rate_limits.seven_day // {} | rate_row("Weekly"; "%b %-d, %-I:%M %p"))
    ]
  | join("\n")
'
