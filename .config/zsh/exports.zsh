#!/bin/zsh

# echo ">> $ZDOTDIR/exports.zsh"
# TODO: merge with .zshenv

HISTFILE="$XDG_DATA_HOME"/zsh/.zhistory
HISTSIZE=1000000
SAVEHIST=1000000
export PATH="$HOME/.local/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export EDITOR=$(which nvim)
export VISUAL=$EDITOR

eval "$(zoxide init zsh)"
# eval "`pip completion --zsh`"
