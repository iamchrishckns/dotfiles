### ################################# ###
###                                   ###
###   Christoph's ZSH Configuration   ###
###                                   ###
### ################################# ###

# ZSH configuration 
CASE_SENSITIVE=false

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

# Set the default editor
export EDITOR=nvim

# Source custom aliases and functions
source $HOME/.zsh_aliases
source $HOME/.zsh_functions

# Homebrew
if command -v brew >/dev/null 2>&1
then
  export HOMEBREW_NO_ANALYTICS=1

  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Oh My Posh
if command -v oh-my-posh >/dev/null 2>&1 
then
  eval "$(oh-my-posh init zsh --config ~/.theme.omp.yaml)"
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

autoload -Uz compinit
compinit
