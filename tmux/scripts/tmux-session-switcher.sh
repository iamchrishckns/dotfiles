#!/usr/bin/env bash

sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)
current_session=$(tmux display-message -p '#S')

sessions=$(echo "${sessions}" | grep -v "^${current_session}$")

if [ -z "$sessions" ]; then
    echo "No tmux sessions found."
    exit 1
fi

preview_command='tmux list-windows -F "#I - #W" -t {}'

selected=$(echo "${sessions}" | fzf \
  --style full \
  --padding 1 \
  --height 100% \
  --border rounded \
  --border-label " Tmux - Session Switcher " \
  --list-label " Available Sessions (Currently on $current_session)" \
  --input-label " Search Sessions " \
  --preview-label " Session Preview " \
  --preview "$preview_command" \
  --bind "enter:accept-or-print-query" \
  --exit-0
)

#   --footer "Press F1 for help" \

#   --bind "F1:change-preview(echo \"Test\")+change-preview-label( Help )" \
#   --bind "change:refresh-preview"

#   --bind "F1:preview:echo Test" \

#   --bind "ctrl-d:execute(tmux kill-session -t {})+reload:$sessions {q}" \

if [ -n "$selected" ]; then
    if tmux has-session -t "$selected" 2>/dev/null; then
        tmux switch-client -t "$selected"
    else
        tmux new-session -d -s "$selected"
        tmux switch-client -t "$selected"
    fi
else
    echo "No session selected."
fi
