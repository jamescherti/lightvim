#!/usr/bin/env bash

set -euf -o pipefail
set -o xtrace

# Neovim
mkdir -p ~/.config/nvim/
cp efficient-vim-config.vim ~/.config/nvim/init.vim

# Vim
cp efficient-vim-config.vim ~/.vimrc
