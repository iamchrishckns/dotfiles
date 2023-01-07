#!/bin/bash

rm -f $HOME/.tmux.conf
rm -f $HOME/.tmux.conf.local
rm -f $HOME/.tmux.conf.remote

ln -s $HOME/dotfiles/tmux/config/tmux.conf $HOME/.tmux.conf
# ln -s $HOME/dotfiles/tmux/config/tmux.conf.local $HOME/.tmux.conf.local
ln -s $HOME/dotfiles/tmux/config/tmux.conf.remote $HOME/.tmux.conf.remote

echo "TMUX config installed."
