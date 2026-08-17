# Lightvim - The Efficient Vim/Neovim Configuration
![License](https://img.shields.io/github/license/jamescherti/lightvim)

The [Lightvim](https://www.jamescherti.com/minimal-vim-neovim-config/) project is a Vim configuration that is intended to serve as a solid foundation for a Vim configuration.

The author began developing this configuration upon first adopting Vim and has continuously refined it over 25 years of research and testing to identify the most effective parameters and optimizations for a Vim configuration file.

This Vim configuration does not install any plugins. It lets you choose exactly which plugins to use, giving you the freedom to build a setup suited to your specific needs without unnecessary dependencies or bloat.

## Installation

Clone the repository into `~/.lightvim`:

```
git clone https://github.com/jamescherti/lightvim ~/.lightvim
```

Create symbolic links for **Vim**:

```
ln -sf ~/.lightvim/lightvim.vim ~/.vimrc
```

Create symbolic links for **Neovim**:

```
mkdir -p ~/.config/nvim
ln -sf ~/.lightvim/lightvim.vim ~/.config/nvim/init.vim
```


## Update

To update *lightvim* with the latest changes from the repository, execute the following command:

```
git -C ~/.lightvim pull
```

## Key bindings

- The default `<Leader>`: `,`

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

## Paths

### Lightvim Directory Structure

Lightvim isolates all configuration, cache, and runtime data under its own directory tree, independent from the default `~/.vim` structure. This ensures a clean, self-contained Vim environment.

### Configuration Files

* **`~/.lightvim.d/before.vim`**: Executed before the main configuration is loaded. Used for early initialization or plugin path setup.

* **`~/.lightvim.d/after.vim`**: Executed after all configuration and plugins have been loaded. Used for post-configuration customization.

### Runtime Data Directories

* **`~/.lightvim.d/var/undo/`**: Stores persistent undo history files.

* **`~/.lightvim.d/var/backup/`**: Stores backup files created before saving modifications.

* **`~/.lightvim.d/var/swap/`**: Stores swap files for open buffers.

* **`~/.lightvim.d/var/spell/`**: Stores custom spell dictionaries. Each file is created dynamically according to the active language and encoding.

### Runtime and Package Paths

Lightvim adds its root directory to both `runtimepath` and `packpath` so that all plugins, syntax files, and configuration scripts are discovered exclusively from the Lightvim directory tree `~/.lightvim.d/`.

## Features

This vimrc enhances defaults that improve the editing experience with Vim, based on extensive research and testing.

**Miscellaneous enhancements**:

- Automatically remove unnecessary whitespace before saving files.
- Disables compatibility with Vi and uses Vim-specific settings.
- Prevents loading the configuration multiple times.

**Encoding and File Handling**:

- Sets global encoding, file encodings, and script encoding to UTF-8.
- Allows loading an optional pre-configuration script (`~/.vim/before.vim`).
- Allows loading an optional post-configuration script (`~/.vim/after.vim`).

**Font Settings**:

- Configures default font and size (`DejaVu Sans Mono` at size 14).
- Offers a method to scale the GUI font size within a defined range (6-30).

**Session Management**:

- Defines options for Vim sessions and view settings (e.g., folds, current directory, cursor position).
- Restore the cursor position when editing a file, except for Git commit files such as `COMMIT_EDITMSG`.

**GUI and Console Configuration**:

- Customizes GUI-specific settings, including window size, font rendering, cursor behavior, and disabling unnecessary UI elements.
- Improves color handling and terminal display with 256-color support and true color.

**Syntax, Indentation, and Formatting**:

- Enables syntax highlighting and filetype-based indentation plugins.
- Configures indentation style (spaces instead of tabs, 4 spaces per indentation level).
- Automatically wraps comments and disables smart indenting features for better manual control.

**Status Line**:

- Customizes the status line to show relevant information such as paste mode, wrap status, filename, line/column number, and current Git branch.

**Window and Layout Settings**:

- Sets split window behavior (e.g., splits right and below).
- Configures window size and scrolling behavior.

**Backup and Undo Settings**:

- Disables backup files and sets undo options (e.g., persistent undo with undo files).

**Key Mappings and Shortcuts**:

- Assigns useful key mappings (e.g., tabs, grep, for writing files, changing directories, adjusting font size).
- Custom leader key (`,`), allowing for personalized shortcuts.

**Search Settings**:

- Configures incremental search, case-sensitive search (`smartcase`), and disables search wrapping.

**Language and Spell Check**:

- Configures spell checking and defines custom dictionary and thesaurus files.

**Clipboard Integration**:

- Supports clipboard integration (copy/paste between Vim and external applications) when available.

**File Type Specific Settings**:

- Defines custom settings for specific file types (e.g., Dockerfile, YAML, Python, Shell, Vim).

**Autocommands**:

- Uses autocommands to automate behaviors like adjusting settings when a file type is detected or resizing windows on Vim resize events.

**Mouse Configuration**:

- Configures mouse support in various modes, including the ability to drag and select text within Vim without switching to visual mode.

**Optimization Settings**:

- Includes optimizations for smooth scrolling and fast terminal connections, including reducing screen redraw times.

**Smart Write Function**:

- Defines a function (`smart_write`) to save files intelligently, ensuring proper handling of modified and non-modified files.

**Better tabline**:

- Enhance the visual clarity of the tabline by displaying solely the filename and removing unnecessary information.

**Useful functions**:

- Select pasted text
- Search the current selection using `//`, `*`, or `#`.

## Author and license

Copyright (C) 2000-2026 [James Cherti](https://www.jamescherti.com).

Distributed under terms of the MIT license.

## Links

- [lightvim @GitHub](https://github.com/jamescherti/lightvim)
- [Announcement: Lightvim – The Efficient Vim/Neovim Configuration](https://www.jamescherti.com/minimal-vim-neovim-config/)
