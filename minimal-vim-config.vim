" Name: .vimrc
" Description: A minimal and optimized Vim/Neovim configuration with
"              improved defaults and sensible enhancements.
" Maintainer:  James Cherti
" URL:         https://github.com/jamescherti/minimal-vim-config
"
" Licence:     Copyright (C) 2000-2025 James Cherti
"              Distributed under terms of the MIT license.
"
"              Permission is hereby granted, free of charge, to any person
"              obtaining a copy of this software and associated documentation
"              files (the 'Software'), to deal in the Software without
"              restriction, including without limitation the rights to use,
"              copy, modify, merge, publish, distribute, sublicense, and/or
"              sell copies of the Software, and to permit persons to whom the
"              Software is furnished to do so, subject to the following
"              conditions: The above copyright notice and this permission
"              notice shall be included in all copies or substantial portions
"              of the Software. THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT
"              WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
"              LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
"              PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
"              AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
"              OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
"              OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"              SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

" Init {{{

" Use Vim settings, rather than Vi settings (much better).
if &compatible
  " vint: next-line -ProhibitSetNoCompatible
  set nocompatible
endif

if exists('g:loaded_minimal_vimrc')
  finish
endif
let g:loaded_minimal_vimrc = 1

if &compatible || v:version < 600
  finish
endif

setglobal encoding=utf-8
setglobal fileencodings=utf-8
scriptencoding utf-8

let minimal_vim_config_before =
      \ fnamemodify('~/.minimal-vim-config/before.vim', ':p')
if filereadable(minimal_vim_config_before)
  execute 'source' minimal_vim_config_before
endif


" }}}
" Base options {{{

let g:font_default_name = get(g:, 'font_default_name', "DejaVu Sans Mono")
let g:font_default_size = get(g:, 'font_default_size', 14)

" Init {{{

" Tell vim to remember certain things when we exit
if has('nvim')
  set viminfo='10,\"100,:100
else
  " 100: Search histories.
  " \"300: Register entries.
  " <50: Limits file marks to this amount of entries.
  " s10: Number of file marks to keep.
  " h: Stores the history of each file that was edited.
  " :20: command-line history entries.
  set viminfo='100,\"300,<50,s10,h,:20
endif

" Session

set sessionoptions=blank,curdir,folds,help,tabpages,unix,slash
set viewoptions=folds,options,cursor,curdir,unix,slash

" }}}

" GUI {{{

if has('gui_running')
  set columns=150
  set lines=45

  " Disabled blinking
  set guicursor+=a:blinkon0

  set guiheadroom=0
  set linespace=0

  " i: icon
  " d: dark theme
  " k: do not change the Windows size when the font size is changed
  " c: Use console dialogs instead of popup dialogs (e.g. call confirm())
  set guioptions+=i
  set guioptions+=d
  set guioptions+=k
  set guioptions+=c

  " 'a': Autoselect:  If present, then whenever VISUAL mode is started,
  set guioptions-=a

  " 'e'  Tab pages
  set guioptions-=e

  " 'g'  Grey menu items: Make menu items that are not active grey.
  set guioptions-=g

  " 'm'  Menu bar
  set guioptions-=m

  " 'r'  Right-hand scrollbar
  set guioptions-=r

  " 'l'  Left-hand scrollbar
  set guioptions-=L

  " 't'  Include tearoff menu items.  Currently only works for Win32,
  " GTK+, and Motif 1.2 GUI.
  set guioptions-=t

  " 'T'  Include Toolbar.  Currently only in Win32, GTK+, Motif and
  " Photon GUIs.
  set guioptions-=T

  " Use console dialogs for simple choices
  " set guioptions+=c

  set titlestring=gvim

  set noicon
endif

" }}}

" Console {{{

if !has('gui_running') && &t_Co >= 256
  " Improve displayed color if supported by terminal
  set termguicolors
  let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
  let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
end

" }}}

" Syntax / indent / format {{{

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has('gui_running')
  if has('autocmd')
    filetype plugin indent on
  endif

  if has('syntax') && !exists('g:syntax_on')
    syntax enable
  endif
endif

" Highlighting strings inside C comments.
" Revert with :unlet c_comment_strings
let c_comment_strings=1

" endif

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set textwidth=0

" w: Trailing white space indicates a paragraph continues in the next line. A
" line that ends in a non-white character ends a paragraph.
set formatoptions+=w

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j  " Delete comment character when joining comments
endif

" Auto-wrap comments using textwidth, inserting the current comment leader
" automatically.
set formatoptions+=c

" r  Automatically insert the current comment leader after hitting
"   <Enter> in Insert mode.
" Disabled because it caused issues in a bash script.
set formatoptions-=r

" o  Automatically insert the current comment leader after hitting 'o' or
"   'O' in Normal mode.  In case comment is unwanted in a specific place
"   use CTRL-U to quickly delete it. |i_CTRL-U|
set formatoptions-=o

" Long lines are not broken in insert mode: When a line was longer than
" 'textwidth' when the insert command started, Vim does not automatically
" format it.
set formatoptions-=l

" 'autoindent' does nothing more than copy the indentation from the previous
" line, when starting a new line. It can be useful for structured text files,
" or when you want to control most of the indentation manually, without Vim
" interfering.
" I disabled it because it prevented me from commenting out a yaml code
" (indent = cancel comment out with Ctrl-v + char)
set noautoindent  " use indent from previous line

" 'smartindent' automatically inserts one extra level of indentation in some
" cases, and works for C-like files. 'cindent' is more customizable, but also
" more strict when it comes to syntax.
"
" 'smartindent' and 'cindent' might interfere with file type based
" indentation, and should never be used in conjunction with it.
"
" I disabled smartindent because it is not possible to shift > comments that
" start with #
set nosmartindent  " like autoindent but recognizes some C syntax
set nocindent  " more clever than the other 2

" Enabling this will make the tab key (in insert mode) insert spaces or tabs
" to go to the next indent of the next tabstop when the cursor is at the
" beginning of a line (i.e. the only preceding characters are whitespace).
set nosmarttab

set backspace=indent,eol,start

set conceallevel=2

" Builtin plugins
runtime macros/matchit.vim

" }}}

 " Status line {{{

function! GetOptionsStatus(...) abort
  let l:status = ''

  if &paste
    let l:status .= '[PASTE] '
  endif

  " if &ignorecase
  "   let l:status .= '[IC] '
  " endif

  if &wrap
    let l:status .= '[W] '
  endif

  return l:status
endfunction

function! CachedGitBranch() abort
  return exists('b:git_branch') ? b:git_branch . ' | ' : ''
endfunction

" %= separates left from right
set statusline=%{GetOptionsStatus()}%F%m%r%h%w%=\ \|\ %l:%c\ \|\ %{CachedGitBranch()}%{strftime('%I:%M\ %p\ ')}

 "}}}

" Vim display / layout / behavior {{{

set noshowmode

" Hide these extensions from the file completion
set suffixes=.bak,~,.swp,.swo
set suffixes+=.a,.o,.pyc,.pyo
" set suffixes+=.aux,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" set suffixes+=.mp4,.avi,.mkv,.ogg,.mp3,.flac
" set suffixes+=.jpg,.png,.jpeg,.jpg,.gif
" set suffixes=.bak,~,.swp,.o

" do not highlight the brackets when
set noshowmatch

" Backup files
set nobackup
set noundofile

set fileformats=unix,dos,mac

" History and undo
set tabpagemax=30
set history=400
set undolevels=2000
set undoreload=10000
set undofile

" Show @@@ in the last line if it is truncated.
set display=truncate

" :help avoid-hit-enter
" Default: set shortmess=filnxtToOS
"
" 1. Disable the Vim startup message
" set shortmess+=I
"
" 2. Added 'T' flag to 'shortmess': Truncate all messages that would cause the
" hit-enter prompt (unless that would happen anyway).
"
" 3. The 'O' flag in 'shortmess' now also applies to quickfix messages, e.g.,
" from the ":cn" command.
set shortmess+=mrcFIwxst

set number
set relativenumber

" Disable beeping
set noerrorbells
set novisualbell
set belloff=all
set t_vb=

" When a file has been detected to have been changed otuside of vim and it has
" not been changed inside of Vim, automatically read it again
set autoread

" Activates the status line (2 = always, 1 = only if there are 2 windows)
set laststatus=2

" Always show tab"
set showtabline=2

" Print options
if !has('nvim')
  set printoptions=paper:letter
endif

" By default, setting wrap displays lines by breaking words if necessary. You
" can force it to preserve words instead by only breaking at certain
" characters:
set linebreak
" set showbreak=---\|
if exists('+breakindent')
  set showbreak=
  " set breakindent showbreak=\ +
endif

" When included, the column used for 'number' and
" 'relativenumber' will also be used for text of wrapped
" lines.
set cpoptions+=n

" Show a few lines of context around the cursor. Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=0

" Keep 5 columns next to the cursor when scrolling horizontally.
set sidescrolloff=5

" Turn off search wrapping
set nowrapscan

" Turn off wrap
set nowrap

" Other search options
set noignorecase

" Do incremental searching when it's possible to timeout.
" DO NOT ENABLE incsearch because it deselects the visual when the user types
" ':s/string/string2/g'
set noincsearch

" You might find the slightly cleverer behavior of smartcase is better,
" though. This option only applies case sensitivity if at least one of the
" letters in the pattern is uppercase; otherwise, case is ignored.
set smartcase

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" Stop certain movements from always going to the first character
" of a line
set startofline

" Search highlighting
set hlsearch

" Don't allows writing to any file with no need for "!" override.
set nowriteany

" Show incomplete commands
set showcmd

" Show the line and column number of the cursor position
set ruler

" grep
set helpheight=25

set cmdheight=1

" Set minimum window size to 79x5.
" set winwidth=79
set winwidth=10
set winheight=5

" filler: Display filler lines when lines are added or deleted to keep things
" aligned split windows vertically
set diffopt+=vertical

set splitright

" Popup and help below
set splitbelow

" nicr = make mouse drag not select text or go into visual mode
set mousemodel=popup

" n  Normal mode and Terminal modes
" v  Visual mode
" i  Insert mode
" c  Command-line mode
" h  all previous modes when editing a help file
" a  all previous modes
" r  for |hit-enter| and |more-prompt| prompt
set mouse=nivc
" set ttymouse=

" When off a buffer is unloaded when it is |abandon|ed.  When on a
" buffer becomes hidden when it is |abandon|ed.  If the buffer is still
" displayed in another window, it does not become hidden, of course.
" The commands that move through the buffer list sometimes make a buffer
" hidden although the 'hidden' option is off: When the buffer is
" modified, 'autowrite' is off or writing is not possible, and the '!'
" flag was used.  See also |windows.txt|.
" To only make one buffer hidden use the 'bufhidden' option.
" This option is set for one command with ":hide {command}" |:hide|.
" WARNING: It's easy to forget that you have changes in hidden buffers.
" Think twice when using ":q!" or ":qa!".
set nohidden

" Write the contents of the file, if it has been modified, on each `:next`,
" `:rewind`, `:last`, `:first`, `:previous`, `:stop`, `:suspend`, `:tag, `:!`,
" ``:make`, CTRL-] and CTRL-^ command; and when :edit", ":enew", ":quit",
" :qall", ":exit", ":xit", ":recover" and closing the Vim window.  Setting
" this option also implies that Vim behaves like 'autowrite' has been set.
set noautowriteall

" }}}

" Completion {{{

" When doing keyword completion in insert mode |ins-completion|, and
" 'ignorecase' is also on, the case of the match is adjusted depending on the
" typed text.  If the typed text contains a lowercase letter where the match
" has an upper case letter, the completed part is made lowercase.  If the
" typed text has no lowercase letters and the match has a lowercase letter
" where the typed text has an uppercase letter, and there is a letter before
" it, the completed part is made uppercase.  With 'noinfercase' the match is
" used as-is.
set infercase

" Treat words with dash as words
" set iskeyword+=-

" Make Ctrl-X-F work with "=/"
set isfname-==

" }}}

" Keyboard {{{

let g:mapleader = ','

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If setlocal (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

" On many terminals, <Esc>O (with an uppercase O) is a prefix for several
" keycodes). You can see them with "set termcap" command.
" To solve the problem :
set timeout

" Allow for mappings including `Esc`, while preserving
" zero timeout after pressing it manually.
" (only vim needs a fix for this)
if !has('nvim')
  set timeoutlen=1000
  set ttimeoutlen=500
endif

" }}}

" Language {{{

set spellsuggest=best
set spellfile=$HOME/.vim-spell.en.utf8.add

" List of files to be searched when you press <C-P><C-N> (comma separated)
set dictionary=~/.vim/dict/english_words

" <C-X><C-T> completion
set thesaurus=~/.vim/thesaurus/english.txt

" }}}

" Optimize {{{

" Speeds-up pasting to command-line. Avoid command-line re-draw on every
" character entered by turning off Arabic shaping.
if has('arabic')
    set noarabicshape
endif

" The time limit in milliseconds for redrawing the display.
" default: 2000
" set redrawtime=2000

" syntax column
" set synmaxcol=3000

" Indicates a fast terminal connection. More characters will be sent to
" the screen for redrawing, instead of using insert/delete line
" commands. Improves smoothness of redrawing when there are multiple
" windows and the terminal does not support a scrolling region.
" Also enables the extra writing of characters at the end of each screen
" line for lines that wrap. This helps when using copy/paste with the
" mouse in an xterm and other terminals.
set ttyfast

" When this option is set, the screen will not be redrawn while
" executing macros, registers and other commands that have not been
" " typed.  Also, updating the window title is postponed.  To force an
" update use |:redraw|.
set lazyredraw

" }}}

" }}}
" autocmd {{{

set list listchars=tab:>-,extends:>,precedes:<,nbsp:+

" Highlight tabs (used by 'setlocal list' and 'setlocal listchars')
highlight SpecialKey ctermfg=1

if has('autocmd')
  augroup FileTypesOptions
    autocmd!
    autocmd BufReadPost *
      \ if &filetype !=# 'gitcommit' || expand('%:t') !=# 'COMMIT_EDITMSG' |
      \   if line("'\"") > 0 && line("'\"") <= line("$") |
      \     execute "normal! g`\"" |
      \   endif |
      \ endif

    autocmd FileType dockerfile setlocal conceallevel=0
    autocmd FileType text setlocal autoindent

    autocmd FileType sh setlocal indentkeys-=)
    autocmd FileType yaml,yaml.ansible
      \ setlocal indentkeys-=<:> indentkeys-=0# indentkeys-=0- indentkeys-=<:>
      \ indentexpr= autoindent shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType python setlocal indentkeys-=<:> indentkeys-=0#
    autocmd FileType vim
      \ setlocal indentkeys-=0} indentkeys-==} indentkeys-==cat
      \ indentkeys-==finall shiftwidth=2 tabstop=2 softtabstop=2

    " autocmd FileType python,sh,puppet,vim setlocal textwidth=78
    autocmd FileType vim,python,sh setlocal colorcolumn=80
    autocmd FileType yaml,yaml.ansible setlocal cursorcolumn

    " Resize
    autocmd VimResized * wincmd =
  augroup END

endif

" end autocmd }}}
" Key bindings {{{

nnoremap <silent> <Leader>wr :silent setlocal invwrap wrap?<CR>

nnoremap <A-o> :bprevious<CR>
nnoremap <A-i> :bnext<CR>

" Shift the selection to the right/left and reselect the text in visual mode
vnoremap > >gv
vnoremap < <gv

" }}}
" Functions {{{
" Chdir to the file directory {{{

" Change the current working directory to the directory of the current buffer.
function! s:chdir_file_dir() abort
  if &filetype ==# 'netrw'
    if !exists('b:netrw_curdir')
      echoerr 'The variable ''b:netrw_curdir'' is not declared.'
      return
    endif

    let l:cwd = fnameescape(b:netrw_curdir)
  else
    let l:cwd = expand('%:p:h')
  endif

  if !isdirectory(l:cwd)
    echoerr printf('The directory ''%s'' does not exist.', l:cwd)
    return
  endif

  execute 'lcd ' . l:cwd
  pwd
endfunction

nnoremap <Leader>cd :call <SID>chdir_file_dir()<CR>

" Open the directory of the current file
nnoremap - :edit %:p:h<CR>

" }}}
" Clipboard {{{

if exists('+clipboard')
  function! JcSelectPastedText() range
    call execute('normal! `[' . strpart(getregtype(), 0, 1) . '`]')
    if &selection ==# 'exclusive'
      normal! l
    endif
  endfunction

  if has('patch-8.2.1978')
    nnoremap gp <cmd>call JcSelectPastedText()<CR>
  else
    nnoremap gp :call JcSelectPastedText()<CR>
  endif

  vnoremap <C-c> "+y
  vnoremap <C-x> "+c
  inoremap <c-v> <Esc>"+pi
endif

" }}}
" GUI Font Resize {{{

execute 'set guifont=' . escape(g:font_default_name . ' ' . g:font_default_size, ' \"')

let s:minfontsize = 6
let s:maxfontsize = 30

function! s:guifontsize_change_size(size) abort
  if has('gui_gtk2') || has('gui_gtk3')
    let l:inc = 0
    call s:gtk_adjust_font_size(a:size, l:inc)
  endif
endfunction

function! s:guifontsize_scale_up() abort
  if has('win32')
    call s:windows_scale_font_up()
  else
    let l:inc = 1
    call s:gtk_adjust_font_size(1, l:inc)
  endif
endfunction

function! s:guifontsize_scale_down() abort
  if has('win32')
    call s:windows_scale_font_down()
  else
    let l:inc = 1
    call s:gtk_adjust_font_size(-1, l:inc)
  endif
endfunction

function! s:windows_scale_font_up() abort
  let gf_size_whole = matchstr(&guifont, '\(\:h\)\@<=\d\+')
  let gf_size_frac = matchstr(&guifont, '\(\:h\d\+\.\)\@<=\d\=')
  let font_size = gf_size_whole * 10 + gf_size_frac
  let font_size = font_size + 5
  let gf_size_whole = font_size / 10
  let gf_size_frac = font_size - gf_size_whole * 10
  let new_font_size = ':h'.gf_size_whole.'.'.gf_size_frac.':'
  let &guifont = substitute(&guifont, '\:h.\{-}\:', new_font_size, '')
endfunction

function! s:windows_scale_font_down() abort
  let gf_size_whole = matchstr(&guifont, '\(\:h\)\@<=\d\+')
  let gf_size_frac = matchstr(&guifont, '\(\:h\d\+\.\)\@<=\d\=')
  let font_size = gf_size_whole * 10 + gf_size_frac
  let font_size = font_size - 5
  let gf_size_whole = font_size / 10
  let gf_size_frac = font_size - gf_size_whole * 10
  let new_font_size = ':h'.gf_size_whole.'.'.gf_size_frac.':'
  let &guifont = substitute(&guifont, '\:h.\{-}\:', new_font_size, '')
endfunction

function! FontParseGuiFont(guifont) abort
  let l:pattern = '^\v(.*\s)([0-9]*)$'

  if !(has('gui_running') && (has('gui_gtk3') || has('gui_gtk2')))
    throw 'font.vim: FontParseGuiFont(): the only GUI that are supported are Gtk 2 and Gtk 3.'
  endif

  let l:guifont = trim(a:guifont)

  let l:font_name = trim(substitute(l:guifont, l:pattern, '\1', ''))
  if empty(l:font_name)
    let l:font_name = 'DejaVu Sans Mono'
  endif

  let l:font_size = trim(substitute(l:guifont, l:pattern, '\2', ''))
  if empty(l:font_size)
    let l:font_size = string(g:font_default_size)
  endif

  return [l:font_name, l:font_size]
endfunction

function! s:gtk_adjust_font_size(amount, inc) abort
  if !has('gui_running')
    return
  endif

  if !has('gui_gtk2') && !has('gui_gtk3')
    echoerr 'You need to run the Gtk 2 or Gtk 3 version of Vim to use this function.'
    return
  endif

  let [l:font_name, cursize] = FontParseGuiFont(&guifont)
  let l:new_size = (a:inc) ? (cursize + a:amount) : a:amount

  if !((l:new_size >= s:minfontsize) && (l:new_size <= s:maxfontsize))
    return
  endif

  let &guifont = l:font_name . ' ' . l:new_size
endfunction

command! FontScaleUp call <SID>guifontsize_scale_up()
command! FontScaleDown call <SID>guifontsize_scale_down()
command! -nargs=1 FontSize call <SID>guifontsize_change_size(<f-args>)

if has('gui_running')
  nnoremap <silent> <C-MouseUp> :FontScaleDown<CR>
  nnoremap <silent> <C-MouseDown> :FontScaleUp<CR>
  tnoremap <silent> <C-MouseUp> :FontScaleDown<CR>
  tnoremap <silent> <C-MouseDown> :FontScaleUp<CR>

  nnoremap <silent> <C-_> :FontScaleDown<CR>
  nnoremap <silent> <C-S-+> :FontScaleUp<CR>
  tnoremap <silent> <C-_> <C-w>:FontScaleDown<CR>
  tnoremap <silent> <C-S-+> <C-w>:FontScaleUp<CR>

  if has('patch-8.2.1978')
    inoremap <silent> <C-MouseUp> <cmd>FontScaleDown<CR>
    inoremap <silent> <C-MouseDown> <cmd>FontScaleUp<CR>

    inoremap <silent> <C-_> <cmd>FontScaleDown<CR>
    inoremap <silent> <C-S-+> <cmd>FontScaleUp<CR>
  else
    inoremap <silent> <C-MouseUp> <Esc>:FontScaleDown<CR>a
    inoremap <silent> <C-MouseDown> <Esc>:FontScaleUp<CR>a

    inoremap <silent> <C-_> <Esc>:FontScaleDown<CR>a
    inoremap <silent> <C-S-+> <Esc>:FontScaleUp<CR>a
  endif
endif

" }}}
" Smart write {{{

function! s:smart_write(filename, force) abort
  let l:filename = a:filename
  let l:force = a:force

  let l:filename = empty(l:filename) ?
      \ expand('%') : fnamemodify(l:filename, ':p')

  if fnamemodify(l:filename, ':p') !=# expand('%:p') || &modified
    execute 'silent write' .
        \ ((l:force) ? '!' : '') . ' ' . fnameescape(l:filename)
    echo 'Saved.'
  else
    if &buftype !=# ''
      echoerr "Cannot write, 'buftype' option is set"
      return
    endif

    if &readonly
      echoerr "'readonly' option is set (add ! to overwrite)"
      return
    endif

    echo 'Saved.'
  endif
endfunction

command! -bar -bang -nargs=? -complete=file Write
  \ call <SID>smart_write(<q-args>, <bang>0)
nnoremap <silent> <C-s> <cmd>call <SID>smart_write('', 0)<CR>
inoremap <silent> <C-s> <cmd>call <SID>smart_write('', 0)<CR>
vnoremap <silent> <C-s> <cmd>call <SID>smart_write('', 0)<CR>

" }}}
" Tabs {{{

nnoremap <leader>t :tab split<CR>

inoremap <C-S-k> :tabmove -1<CR>
nnoremap <C-S-k> :tabmove -1<CR>
vnoremap <C-S-k> :tabmove -1<CR>
inoremap <C-S-j> :tabmove 1<CR>
nnoremap <C-S-j> :tabmove 1<CR>
vnoremap <C-S-j> :tabmove 1<CR>

" Tab next / Tab previous
" patch-8.2.1978 = <cmd> supported
if has('patch-8.2.1978')
  nnoremap <C-k> <cmd>tabprevious<CR><cmd>echon ''<CR>
  nnoremap <C-j> <cmd>tabnext<CR><cmd>echon ''<CR>
else
  nnoremap <silent> <C-k> :tabprevious<CR>:echon ''<CR>
  nnoremap <silent> <C-j> :tabnext<CR>:echon ''<CR>
endif

" Function to close the current window or tab if only one window remains
" Map Ctrl-w c to call the function
function! CloseWindowOrTab()
  if winnr('$') > 1
    " If there is more than one window, close the current window
    close
  else
    " If only one window remains, close the tab
    tabclose
  endif
endfunction

nnoremap <C-w>c :call CloseWindowOrTab()<CR>
vnoremap <C-w>c :call CloseWindowOrTab()<CR>

" }}}
" Miscellaneous key bindings {{{

" Grep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden\ -g\ '!.git/'
  set grepformat=%f:%l:%c:%m,%f:%l:%m
else
  set grepprg=grep\ -Rn\ --exclude-dir=.git\ --exclude-dir=.svn\ --no-messages
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

nnoremap <Leader>gr :silent grep<Space>

" }}}
" Whitespace delete {{{

function! DeleteWhiteSpace() abort
  if &buftype !=# ''
    return
  endif

  let l:save_register = @@
  let l:save = winsaveview()

  let l:delete_white_space_git_changes =
    \ get(b:, 'delete_white_space_git_changes',
    \     get(g:, 'delete_white_space_git_changes', 0))

  if l:delete_white_space_git_changes
    let l:range_list = git#get_diff_lines()
  else
    let l:range_list = ['%']
  endif

  for l:range in l:range_list
    if l:range !=# '%'
      if l:range > line('$')
        continue
      endif
    endif
    execute 'keeppatterns ' . l:range . 'substitute/\s\+$//e'
  endfor

  " Delete lines in the end
  if !l:delete_white_space_git_changes
    while line('$') > 1 && getline(line('$')) ==# ''
      keeppatterns $g/^$/d
    endwhile
  endif

  call winrestview(l:save)
  let @@ = l:save_register
endfunction

augroup DeleteWhiteSpaceGroup
  autocmd!
  "autocmd BufWritePre * if !exists('b:keep_white_space') || b:keep_white_space
  "      \ call DeleteWhiteSpace() | endif
  autocmd BufWritePre * call DeleteWhiteSpace()
augroup END

" }}}
" Tabline {{{

function! s:string_rstrip(string, chars) abort
  let l:index = len(a:string) - 1
  while l:index >= 0
    let l:found = 0
    for l:char in split(a:chars, '\zs')
      if a:string[l:index] ==# l:char
        let l:found = 1
        break
      endif
    endfor

    let l:index -= 1

    if ! l:found
      break
    endif
  endwhile

  return a:string[0:l:index+1]
endfunction

function! s:path_sep() abort
      return (!exists('+shellslash') || &shellslash) ? '/' : '\'
endfunction

function! s:path_rstrip_sep(path) abort
  return s:string_rstrip(a:path, s:path_sep())
endfunction

function! JcTabLabelClassic(tabnr) abort
  let l:bufnr = tabpagebuflist(a:tabnr)[tabpagewinnr(a:tabnr) - 1]

  let l:modified = 0
  if getbufvar(l:bufnr, '&modified')
    let l:modified = 1
  endif

  let l:tablabel = ''
  let l:custom_tablabel = gettabvar(a:tabnr, 'tablabel', '')
  if empty(l:custom_tablabel)
    let l:bufname = bufname(l:bufnr)
    if empty(l:bufname)
      let l:tablabel = empty(&buftype) ? 'No Name' : '<' . &buftype . '>'
    else
      let l:tablabel = fnamemodify(l:bufname, ':t')
    endif
  else
    let l:tablabel .= l:custom_tablabel
  endif

  if l:modified
    let l:tablabel .= '*'
  endif

  return l:tablabel
endfunction

function! JcTabLabelGrouped(tabnr) abort
  let l:tablabel = gettabvar(a:tabnr, 'tablabel', '')
  if ! empty(l:tablabel)
    return l:tablabel
  endif

  " Shows tab1|tab2|tab3 when the tab is not the current one and tab1 when it
  " is the current one
  " if a:tabnr ==# tabpagenr()
  "   let l:tabpagebuflist = [tabpagebuflist(a:tabnr)[tabpagewinnr(a:tabnr) - 1]]
  " else
  "   let l:tabpagebuflist = tabpagebuflist(a:tabnr)
  " endif

  " Shows tab1|tab2|tab3 all the time
  let l:tabpagebuflist = tabpagebuflist(a:tabnr)

  let l:tablabel = ''
  let l:bufnr_added = []
  for l:bufnr in l:tabpagebuflist
    if index(l:bufnr_added, l:bufnr) >= 0
      continue
    endif
    call add(l:bufnr_added, l:bufnr)

    " Tab label
    let l:bufname = s:path_rstrip_sep(bufname(l:bufnr))

    " Basename
    let l:new_tablabel = ''
    if !empty(l:bufname)
      if isdirectory(l:bufname)
        let l:new_tablabel .= 'dir:'
        let l:new_tablabel .=
          \ fnamemodify(fnamemodify(l:bufname, ':h'), ':t')
        let l:new_tablabel .= s:path_sep()
      endif

      let l:new_tablabel .= fnamemodify(l:bufname, ':t')
    endif

    " Add the label
    if l:tablabel !=# '' && l:new_tablabel !=# ''
      let l:tablabel .= '|'
    endif
    let l:tablabel .= l:new_tablabel

    if getbufvar(l:bufnr, '&modified')
      let l:tablabel .= '*'
    endif
  endfor

  if empty(l:tablabel)
    let l:tablabel = '-'
  endif

  return l:tablabel
endfunction

function! JcBetterTabline() abort
  let l:tabline = ''

  for l:num in range(1, tabpagenr('$'))
    let l:tabline .= (l:num != tabpagenr()) ? '%#TabLine#' : '%#TabLineSel#'
    let l:tabline .= '%' . l:num . 'T %{' . g:tab_label_function . '(' . l:num . ')} '
  endfor

  let l:tabline .= '%#TabLineFill#%T%='
  let l:tabline .= repeat('%#TabLine#%999X[X]', l:num > 1)

  return l:tabline
endfunction

" let g:tab_label_function = 'JcTabLabelClassic'
let g:tab_label_function = 'JcTabLabelGrouped'

if exists('+showtabline')
  set tabline=%!JcBetterTabline()
endif

if exists('+guitablabel')
  function! JcBetterGuitabline() abort
    return funcref(g:tab_label_function)(tabpagenr())
  endfunction

  function! s:set_guitabline() abort
      set guitablabel=%{JcBetterGuitabline()}
      " set guioptions+=e
  endfunction

  augroup GuiTabLine
    autocmd!
    autocmd GUIEnter * call <SID>set_guitabline()
  augroup END
endif

" }}}
" Visual search {{{

" A global variable (s:VeryLiteral) controls whether selected whitespace
" matches any whitespace (by default, VeryLiteral is off, so any whitespace
" is found).
let s:JcVeryLiteral = 1

function! JcVisualSearch(cmd) abort
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  normal! gvy
  if @@ =~? '^[0-9a-z,_]*$' || @@ =~? '^[0-9a-z ,_]*$' && s:JcVeryLiteral
    let @/ = @@
  else
    let pat = escape(@@, a:cmd.'\')
    if s:JcVeryLiteral
      let pat = substitute(pat, '\n', '\\n', 'g')
    else
      let pat = substitute(pat, '^\_s\+', '\\s\\+', '')
      let pat = substitute(pat, '\_s\+$', '\\s\\*', '')
      let pat = substitute(pat, '\_s\+', '\\_s\\+', 'g')
    endif
    let @/ = '\V'.pat
  endif
  normal! gV
  call setreg('"', old_reg, old_regtype)
endfunction

vnoremap <silent> // :<C-U>call JcVisualSearch('/')<CR>
vnoremap <silent> * :<C-U>call JcVisualSearch('/')<CR>/<C-R>/<CR>
vnoremap <silent> # :<C-U>call JcVisualSearch('?')<CR>?<C-R>/<CR>
vmap <kMultiply> //
nnoremap <silent> * :let @/ = expand('<cword>')<CR>:echo expand('<cword>')<CR>
nnoremap <silent> <C-*> :keepjumps normal! mi*`i<CR>:echo '/\<' . expand('<cword>') . '\>'<CR>

" }}}
" Miscellaneous functions {{{

function! JcMapCommand(modes, key_mapping, ...) abort
  let l:has_cmd = 0
  let l:pre_cmd = ':'
  let l:post_cmd = ":echom ''<CR>"
  if has('patch-8.2.1978')
    " The 'patch-8.2.1978' adds the '<cmd>' feature
    let l:has_cmd = 1
    let l:pre_cmd = '<cmd>'
    let l:post_cmd = ''
  endif

  for l:mode in split(a:modes, '\zs')
    let l:local_pre_cmd = l:pre_cmd
    if l:has_cmd ==# 0
      if l:mode ==# 't'
        let l:local_pre_cmd = '<C-w>' . l:local_pre_cmd
      elseif l:mode !=# 'n'
        let l:local_pre_cmd = '<Esc>' . l:local_pre_cmd
      endif
    endif

    let l:local_post_cmd = l:post_cmd
    if l:has_cmd ==# 0
      if l:mode ==# 'v'
        let l:local_post_cmd .= 'gv'
      endif

      if l:mode ==# 'i'
        let l:local_post_cmd .= 'a'
      endif
    endif

    let l:local_command = ''
    for l:item_command in a:000
      let l:local_command .= l:local_pre_cmd .
        \ ((l:has_cmd ==# 0 && l:mode ==# 'v') ? '<C-U>' : '') .
        \ l:item_command . '<CR>'
    endfor

    execute l:mode . 'noremap ' . a:key_mapping . ' ' .
      \ l:local_command . l:local_post_cmd
  endfor
endfunction

function! JcClearHighlight() abort
  let @/=''
  echon ''
  redraw
  syntax sync fromstart
endfunction

call JcMapCommand('nvi', '<C-l>', ':call JcClearHighlight()')

" }}}
" }}}
" External plugins {{{

function! s:fzf() abort
  try
    if exists(':FZF')
      FZF
    endif
  finally
    if !has('gui_running')
      " Fix issue in console mode
      redraw!
    endif
  endtry
endfunction
nnoremap <silent> <C-p> :call <SID>fzf()<CR>

if has('patch-8.2.1978')
  nnoremap <Leader>m <cmd>MRU<CR>
  nnoremap <Leader>b <cmd>MRU<CR>
else
  nnoremap <Leader>m :MRU<CR>
  nnoremap <Leader>b :MRU<CR>
endif


" }}}
" Plugins {{{

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall

" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

let minimal_vim_config_after =
      \ fnamemodify('~/.minimal-vim-config/after.vim', ':p')
if filereadable(minimal_vim_config_after)
  execute 'source' minimal_vim_config_after
endif

" }}}

" vim:foldmethod=marker:syntax=vim
