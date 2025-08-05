#!/usr/bin/env bash

while true; do
  read -rp "New Session: " new_session_name

  if [[ -z "$new_session_name" ]]; then
    echo "Session name cant be empty."

    continue
  fi

  if tmux has-session -t "$new_session_name" 2>/dev/null; then
    echo "Session already exists."
  else
    tmux new-session -d -s "$new_session_name"
    tmux switch-client -t "$new_session_name"
  fi
done
