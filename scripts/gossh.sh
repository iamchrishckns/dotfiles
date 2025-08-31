#!/usr/bin/env bash

sshconfig="${HOME}/.ssh/config"

function select_host() {
  local mode="$1"
  local matches="$2"
  local sshconfig="$3"

  local title=""
  local footer=""

  if [[ "$mode" == "ssh" ]]; then
    title="GoSSH - Connecting to Host"
    footer="Select a SSH host to connect"
  fi

  if [[ "$mode" == "code" ]]; then
    title="GoSSH - Open VSCode Remote"
    footer="Select a SSH host to open it in VSCode Remote"
  fi

  echo "$matches" | fzf \
    --style full \
    --padding 1 \
    --height 100% \
    --border rounded \
    --border-label " ${title} " \
    --list-label "SSH Hosts" \
    --preview-label " SSH Config " \
    --preview "sed -n '/^Host.*{}/,/^$/p' ${sshconfig}" \
    --prompt "Host: " \
    --exit-0
}

function select_path() {
  local server="$1"

  local paths=$(ssh "${server}" "find ~ -mindepth 1 -maxdepth 1 -type d" 2>/dev/null | sort)

  if [[ -z "$paths" ]]; then
    echo "No directories found on ${server}"
    return 1
  fi
  
  # -mindepth 1 = Exclude the current directory itself
  # -maxdepth 1 = Limit to one level deep
  # -type d = Only directories

  echo "$paths" | fzf \
    --style full \
    --padding 1 \
    --height 100% \
    --border rounded \
    --border-label " GoSSH - Select Path " \
    --list-label " Directories on ${server} " \
    --preview-label " Directory Preview " \
    --preview "ssh ${server} 'ls -lh --time-style=long-iso {}' | awk '{printf \"%s %s  %s\t%s\\n\", \$6, \$7, \$5, \$8}'" \
    --prompt "Path: " \
    --bind 'right:clear-query+reload(ssh '"${server}"' "find {} -mindepth 1 -maxdepth 1 -type d" 2>/dev/null | sort)' \
    --bind 'left:clear-query+reload(ssh '"${server}"' "find ~ -mindepth 1 -maxdepth 1 -type d" 2>/dev/null | sort)' \
    --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Directory Preview [%s] " {}' \
    --exit-0
}

if [[ ! -f "$sshconfig" ]]; then
  echo "SSH config file not found: $sshconfig"
  exit 1
fi

if [[ ! "$(which "fzf")" ]]; then
  echo "Requirement fzf not found, please install it"
  exit 1
fi

if [[ $# -eq 0 ]]; then
  matches=$(grep -h "^Host " "$sshconfig" | awk '{print $2}')
  if [[ -z "$matches" ]]; then
    echo "No hosts found"
    exit 1
  fi

  server=$(select_host "ssh" "$matches" "$sshconfig")

  echo "Selected host: ${server}"
  if [[ -z "${server}" ]]; then
    echo "No server selected"
    exit 1
  fi
  
  echo "Connecting to ${server}"
  
  ssh "${server}"
  
  exit 0
fi

if [[ "$1" == "code" ]]; then
  if [[ ! "$(which "code")" ]]; then
    echo "Requirement VS Code not found, please install it"
    exit 1
  fi

  matches=$(grep -h "^Host " "$sshconfig" | awk '{print $2}')
  if [[ -z "$matches" ]]; then
    echo "No hosts found"
    exit 1
  fi

  server=$(select_host "code" "$matches" "$sshconfig")

  echo "Selected host: ${server}"
  if [[ -z "${server}" ]]; then
    echo "No server selected"
    exit 1
  fi

  path=$(select_path "${server}")
  if [[ -z "${path}" ]]; then
    echo "No path selected"
    exit 1
  fi

  echo "Opening VS Code on ${server}:${path}"
  
  code --folder-uri="vscode-remote://ssh-remote+${server}${path}"
  
  exit 0
fi
