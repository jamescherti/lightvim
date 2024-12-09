# Minimal ~/.vimrc - Better Vim Defaults
![License](https://img.shields.io/github/license/jamescherti/minimal-vimrc)
![](https://raw.githubusercontent.com/jamescherti/minimal-vimrc/main/.images/made-for-gnu-emacs.svg)

The **minimal-vimrc** project is a customizable Vim base that provides **better Vim defaults**, intended to serve as a solid foundation for a Vim configuration.

Creating *minimal-vimrc* involved extensive research and testing to find the best parameters and optimizations for an vimrc file. The concept behind *minimal-vimrc* is to provide a clean, bloat-free base.

By default, only essential features are enabled, providing a minimal base that is optimized. From there, users are encouraged to consult this README.md to customize and extend the configuration based your their specific needs.

## Key bindings

- The default leader: `,`

Clipboard:
- Visual mode copy: C-c
- Visual mode cut: C-x
- Insert mode paste: C-v

Files:
- Edit the directory where the current file or directory is: `-` (normal mode)

Grep:
- Run grep (or rg, if available): `<leader>gr` (normal mode)

### Tabs

Normal mode:
- Create a tab: `<Leader>t`

Insert mode, visual mode, and normal mode:
- Previous tab: `C-k`
- Next tab: `C-j`
- Move tab to the left: `<C-S-K>`
- Move tab to the right: `<C-S-J>`

Visual and normal mode:
- Close split (or tab if there is one window in the current tab): `C-w c`

## Features

- Better defaults
- Useful keybindings (tabs, grep, etc.)
- Delete whitespace

## Links

- [minimal-vimrc @GitHub](https://github.com/jamescherti/minimal-vimrc)
