# lean-vimrc - Better Vim Defaults
![License](https://img.shields.io/github/license/jamescherti/lean-vimrc)

The **lean-vimrc** project is a customizable Vim base that provides **better Vim defaults**, intended to serve as a solid foundation for a Vim configuration.

Creating *lean-vimrc* involved extensive research and testing to find the best parameters and optimizations for an vimrc file. The concept behind *lean-vimrc* is to provide a clean, bloat-free base.

By default, only essential features are enabled, providing a minimal base that is optimized. From there, users are encouraged to consult this README.md to customize and extend the configuration based your their specific needs.

## Key bindings

- The default <Leader>: `,`

### Miscellaneous

Normal mode:
- Toggle wrap: `<Leader>wr`

### Clipboard:

Visual mode:
- Copy: `C-c`
- Cut: `C-x`

Insert mode:
- Paste: `C-v`

### Files:

Normal mode:
- Edit the directory where the current file or directory is: `-`

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
- Close window/split (or tab if there is one window in the current tab): `C-w c`

### External plugins

Normal mode:
- Run MRU (requires mru.vim): `<Leader>m` or `<Leader>b`
- Run fzf (requires fzf.vim): `C-p`

## Features

- Better defaults
- Useful keybindings (tabs, grep, etc.)
- Delete whitespace

## Links

- [lean-vimrc @GitHub](https://github.com/jamescherti/lean-vimrc)
