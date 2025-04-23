#!/usr/bin/env bash

set -euf -o pipefail
set -o xtrace
mkdir -p ~/.config/nvim/
cp vimrc ~/.config/nvim/init.vim
cp vimrc ~/.vimrc
