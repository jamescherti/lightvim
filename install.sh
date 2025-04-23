#!/usr/bin/env bash

# shellcheck disable=SC2269
EFFICIENT_VIM_CONFIG_UNATTENDED="$EFFICIENT_VIM_CONFIG_UNATTENDED"
if [[ $EFFICIENT_VIM_CONFIG_UNATTENDED = "" ]]; then
  EFFICIENT_VIM_CONFIG_UNATTENDED=0
fi

set -euf -o pipefail

if [[ $EFFICIENT_VIM_CONFIG_UNATTENDED -ne 0 ]]; then
  read -r -p "Replace ~/.vimrc and ~/.config/nvim/init.vim? [y,n] " ANSWER
  if [[ "$ANSWER" != "y" ]]; then
    echo "Interrupted." >&2
    exit 1
  fi
fi

# Neovim
set -x
mkdir -p ~/.config/nvim/
cp efficient-vim-config.vim ~/.config/nvim/init.vim

# Vim
cp efficient-vim-config.vim ~/.vimrc
