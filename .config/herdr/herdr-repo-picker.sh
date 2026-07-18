#!/bin/sh
# herdr-repo-picker.sh — fzf-pick a top-level git repo under ~/dev and launch a
# tool (default: lazygit) in it, in a NEW VERTICAL SPLIT (to the right) of the
# focused pane.
#
# Mirrors herdr-lazygit.sh: it resolves the focused pane over herdr's socket API,
# splits it to the right, then runs the picker INSIDE the new pane so fzf has a
# TTY. Cancelling fzf closes the empty split; selecting a repo runs $LAUNCH
# (default "lazygit") in that repo, and the split closes when the tool quits.
#
# Bound in ~/.config/herdr/config.toml as a custom command:
#   [[keys.command]]
#   key = "prefix+shift+g"
#   type = "shell"
#   command = "~/.config/herdr/herdr-repo-picker.sh"
#
# Scope: each directory directly under $HERDR_REPO_ROOT (default ~/dev) that is a
# git repo. POSIX sh (no bashisms) — startup cost is negligible next to fzf.
set -u

SCRIPT="$HOME/.config/herdr/herdr-repo-picker.sh"
ROOT="${HERDR_REPO_ROOT:-$HOME/dev}"
# The tool launched in the selected repo is the keybinding's first argument
# (default lazygit); the split closes when it exits. Bind one key with no arg
# (lazygit) and another with "hunk diff", etc. HERDR_REPO_LAUNCH overrides both.

# Extract the first "field":"value" string from a JSON blob on stdin.
json_field() { grep -oE "\"$1\":\"[^\"]*\"" | head -1 | cut -d'"' -f4; }

# --- Stage 2: runs INSIDE the new split pane, where fzf has a TTY ----------
if [ "${1:-}" = "--pick" ]; then
  LAUNCH="${2:-lazygit}"                         # tool forwarded from stage 1
  repos=$(for d in "$ROOT"/*/; do [ -e "${d}.git" ] && basename "$d"; done | sort)
  if [ -z "$repos" ]; then
    printf 'No git repos under %s\n' "$ROOT" >&2
    sleep 1
    exit 0            # exec'd into the pane shell → this closes the split
  fi
  sel=$(printf '%s\n' "$repos" | fzf \
    --prompt="repo> " \
    --height=100% --reverse --border \
    --preview="git -C $ROOT/{} log --oneline -15 2>/dev/null || ls -la $ROOT/{}") \
    || exit 0         # fzf cancelled (Esc/Ctrl-C) → close the split
  [ -n "$sel" ] || exit 0
  cd "$ROOT/$sel" || exit 0
  # Launch the tool in the repo. Its TUI covers the injected `exec ... --pick`
  # line, and `sh -c` exits when the tool quits, closing the split.
  exec sh -c "$LAUNCH"
fi

# --- Stage 1: split the focused pane to the right, run stage 2 in it -------
LAUNCH="${1:-${HERDR_REPO_LAUNCH:-lazygit}}"   # binding arg > env > default
src=$(herdr pane current | json_field pane_id)
[ -n "$src" ] || { echo "herdr-repo-picker: no focused pane" >&2; exit 1; }

# --env SHELL=/bin/sh so the split spawns a near-instant login sh instead of the
# default fish, whose startup would flash a prompt before fzf/the tool takes over.
new=$(herdr pane split --pane "$src" --direction right --focus \
        --env SHELL=/bin/sh | json_field pane_id)
[ -n "$new" ] || { echo "herdr-repo-picker: split failed" >&2; exit 1; }

# `exec` so the picker replaces the pane's primary shell: a cancel/exit then
# closes the pane, and a selection's launched tool takes over that pane.
herdr pane run "$new" "exec '$SCRIPT' --pick '$LAUNCH'"
