#!/usr/bin/env zsh

target=$1

if [[ -z "$target" ]]; then
    echo "Usage: $0 [window|session]"
    exit 1
fi

if [[ "$target" == "window" ]]; then
    current_name=$(tmux display-message -p "#W")
    header="Renaming window"
elif [[ "$target" == "session" ]]; then
    current_name=$(tmux display-message -p "#S")
    header="Renaming session"
else
    echo "Invalid target: $target"
    exit 1
fi

new_name=$current_name

print ""
print "$header"
print "Current name: $current_name"
print ""

bindkey -e
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

if vared -p "New name: " new_name; then
    if [[ -n "$new_name" && "$new_name" != "$current_name" ]]; then
        if [[ "$target" == "window" ]]; then
            tmux rename-window "$new_name"
        else
            tmux rename-session "$new_name"
        fi
    fi
else
    exit 1
fi
