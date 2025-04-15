# jc-vimrc - Better Vim Defaults
![License](https://img.shields.io/github/license/jamescherti/jc-vimrc)

The **jc-vimrc** project is a customizable Vim base that provides **better Vim defaults**, intended to serve as a solid foundation for a Vim configuration.

Creating *jc-vimrc* involved extensive research and testing to find the best parameters and optimizations for an vimrc file. The concept behind *jc-vimrc* is to provide a clean, bloat-free base.

By default, only essential features are enabled, providing a minimal base that is optimized. From there, users are encouraged to consult this README.md to customize and extend the configuration based your their specific needs.

## Key bindings

- The default <Leader>: `,`

### Miscellaneous

Normal mode:
- Toggle wrap: `<Leader>wr`
- Previous buffer: `A-o`
- Next buffer: `A-i`
- Change the current working directory to the directory of the current buffer: `<Leader>cd`
- Open the directory of the current file: `-`
- Search forward using the current word: `*`
- Search backward using the current word: `#`

Visual mode:
- Search forward for the current selection: `//` or `*`
- Search backward for the current selection: `#`

Visual, normal, and insert mode:
- Redraw the screen and clears search highlights: `<C-l>`

### Clipboard:

Normal mode:
- Select pasted text: `gp`

Visual mode:
- Copy: `C-c`
- Cut: `C-x`

Insert mode:
- Paste: `C-v`

### Files:

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

### GUI

Normal and insert mode:
- Increase font size: `Ctrl` + `+` (or `Ctrl` + Mouse Wheel Up)
- Decrease font size: `Ctrl` + `-` (or `Ctrl` + Mouse Wheel Down)

### External plugins

Normal mode:
- Run MRU (requires mru.vim): `<Leader>m` or `<Leader>b`
- Run fzf (requires fzf.vim): `C-p`

## Features

This vimrc enhances defaults that improve the editing experience with Vim, based on extensive research and testing.

1. **Miscellaneous enhancements**:
- Automatically remove unnecessary whitespace before saving files.
- Disables compatibility with Vi and uses Vim-specific settings.
- Prevents loading the configuration multiple times.

2. **Encoding and File Handling**:
- Sets global encoding, file encodings, and script encoding to UTF-8.
- Allows loading an optional pre-configuration script (`~/.vim/before.vim`).
- Allows loading an optional post-configuration script (`~/.vim/after.vim`).

3. **Font Settings**:
- Configures default font and size (`DejaVu Sans Mono` at size 14).
- Offers a method to scale the GUI font size within a defined range (6-30).

4. **Session Management**:
- Defines options for Vim sessions and view settings (e.g., folds, current directory, cursor position).
- Restore the cursor position when editing a file, except for Git commit files such as `COMMIT_EDITMSG`.

5. **GUI and Console Configuration**:
- Customizes GUI-specific settings, including window size, font rendering, cursor behavior, and disabling unnecessary UI elements.
- Improves color handling and terminal display with 256-color support and true color.

6. **Syntax, Indentation, and Formatting**:
- Enables syntax highlighting and filetype-based indentation plugins.
- Configures indentation style (spaces instead of tabs, 4 spaces per indentation level).
- Automatically wraps comments and disables smart indenting features for better manual control.

7. **Status Line**:
- Customizes the status line to show relevant information such as paste mode, wrap status, filename, line/column number, and current Git branch.

8. **Window and Layout Settings**:
- Sets split window behavior (e.g., splits right and below).
- Configures window size and scrolling behavior.

9. **Backup and Undo Settings**:
- Disables backup files and sets undo options (e.g., persistent undo with undo files).

10. **Key Mappings and Shortcuts**:
- Assigns useful key mappings (e.g., tabs, grep, for writing files, changing directories, adjusting font size).
- Custom leader key (`,`), allowing for personalized shortcuts.

11. **Search Settings**:
- Configures incremental search, case-sensitive search (`smartcase`), and disables search wrapping.

12. **Language and Spell Check**:
- Configures spell checking and defines custom dictionary and thesaurus files.

13. **Clipboard Integration**:
- Supports clipboard integration (copy/paste between Vim and external applications) when available.

14. **File Type Specific Settings**:
- Defines custom settings for specific file types (e.g., Dockerfile, YAML, Python, Shell, Vim).

15. **Autocommands**:
- Uses autocommands to automate behaviors like adjusting settings when a file type is detected or resizing windows on Vim resize events.

16. **Mouse Configuration**:
- Configures mouse support in various modes, including the ability to drag and select text within Vim without switching to visual mode.

17. **Optimization Settings**:
- Includes optimizations for smooth scrolling and fast terminal connections, including reducing screen redraw times.

18. **Smart Write Function**:
- Defines a function (`smart_write`) to save files intelligently, ensuring proper handling of modified and non-modified files.

19. **Better tabline**:
- Enhance the visual clarity of the tabline by displaying solely the filename and removing unnecessary information.

20. **Useful functions**:
- Select pasted text
- Search the current selection using `//`, `*`, or `#`.

## Author and license

Copyright (C) 2000-2025 [James Cherti](https://www.jamescherti.com).

Distributed under terms of the MIT license.

## Links

- [jc-vimrc @GitHub](https://github.com/jamescherti/jc-vimrc)
