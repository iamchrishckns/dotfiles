### ################################# ###
###                                   ###
###   Christoph's ZSH Configuration   ###
###                                   ###
### ################################# ###

# ZSH configuration 
CASE_SENSITIVE=false

export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTTIMEFORMAT="[%F %T] "
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt EXTENDED_HISTORY # Write the history file in the ":start:elapsed;command" format.
setopt HIST_FIND_NO_DUPS # Do not display a line previously found.
setopt HIST_IGNORE_DUPS # Do not enter command lines into the history list if they are duplicates of the previous event.
setopt SHARE_HISTORY # Share history between all sessions.
setopt HIST_VERIFY # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY # Append to history file (Default)
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks from each command line being added to the history.
setopt HIST_IGNORE_SPACE # Do not record an event starting with a space.

# Allow more lines to be shown by autocomplete tab
export LISTMAX=200

# Set the default editor
export EDITOR=nvim

# Color man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Source custom aliases and functions
source $HOME/.zsh_aliases
source $HOME/.zsh_functions
source $HOME/.zsh_kubernetes

# Homebrew
if command -v brew >/dev/null 2>&1
then
  export HOMEBREW_NO_ANALYTICS=1

  eval "$(/opt/homebrew/bin/brew shellenv)"
  
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Oh My Posh
if command -v oh-my-posh >/dev/null 2>&1 
then
  eval "$(oh-my-posh init zsh --config ~/dotfiles/oh-my-posh/themes/iamchrishckns.omp.yaml)"
  enable_poshtransientprompt
fi

# FZF
if command -v fzf >/dev/null 2>&1
then
  source <(fzf --zsh)

  export FZF_DEFAULT_OPTS="--style full --border=rounded"
fi

# LMStudio
export PATH="$PATH:/Users/christoph/.lmstudio/bin"

# NPM
if command -v npm >/dev/null 2>&1
then
  source <(npm completion)
fi

# PNPM
if command -v pnpm >/dev/null 2>&1
then
  source <(pnpm completion zsh)

  export PNPM_HOME="/Users/christoph/Library/pnpm"

  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi  

# Zoxide
if command -v zoxide >/dev/null 2>&1
then
  eval "$(zoxide init zsh)"
fi

autoload -Uz compinit
compinit
