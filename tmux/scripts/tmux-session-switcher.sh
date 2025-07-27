#!/usr/bin/env bash

sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)
current_session=$(tmux display-message -p '#S')

sessions=$(echo "${sessions}" | grep -v "^${current_session}$")

if [ -z "$sessions" ]; then
    echo "No tmux sessions found."
    exit 1
fi

selected=$(echo "${sessions}" | fzf \
  --style full \
  --padding 1 \
  --height 100% \
  --border rounded \
  --border-label " Tmux - Session Switcher " \
  --list-label " Available Sessions " \
  --input-label " Search Sessions " \
  --preview-label " Session Preview " \
  --preview='tmux list-windows -F "#I - #W" -t {}' \
  --exit-0
)

if [ -n "$selected" ]; then
    tmux switch-client -t "$selected"
else
    echo "No session selected."
fi
