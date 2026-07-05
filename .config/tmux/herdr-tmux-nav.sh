#!/usr/bin/env bash
# Seamless directional focus across herdr (inner mux) and tmux (outer mux).
#
# Bound to Opt+Shift+h/j/k/l in tmux's root key-table. When the active tmux pane
# runs herdr AND herdr has a pane in <dir>, move within herdr; otherwise move
# between tmux panes. This deliberately avoids forwarding modified keys through
# tmux into herdr (which needs a matching keyboard protocol at every hop) — tmux
# owns the key and drives herdr over its CLI socket instead.
#
# Usage: herdr-tmux-nav.sh <left|right|up|down> <L|R|U|D> <pane_current_command>
#   arg3 is tmux's #{pane_current_command}, expanded by tmux at bind time.
#
# herdr edges semantics: result.edges.<dir> == true means the focused herdr pane
# touches that edge (no herdr pane that way) -> fall through to tmux.
dir="$1"
flag="$2"
cmd="${3:-}"

if [ "$cmd" = "herdr" ]; then
    at_edge=$(herdr pane edges --current 2>/dev/null | jq -r ".result.edges.${dir}" 2>/dev/null)
    if [ "$at_edge" = "false" ]; then
        herdr pane focus --direction "$dir" --current >/dev/null 2>&1
        exit 0
    fi
fi

tmux select-pane -"$flag"
