" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

"""""""""""""""""""""""""""""""""" PERSONAL """"""""""""""""""""""""""""""""""""

" Set line numbers on LHS.
set number

" Use kj to switch into normal mode.
inoremap <silent> kj <ESC>
if has('nvim')
  tnoremap kj <C-\><C-n>
endif

" Save backups and swap files, and undo files in a specified folder in the home
" directory to avoid cluttering everything up.
set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backups//
set undodir=$HOME/.vim/undofiles//


" Wean yourself off the arrow keys!
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" Default textwidth is 80 if not otherwise set
if !&textwidth
	set textwidth=80
endif

" Default tab behavior if not otherwise set
set tabstop=2
set shiftwidth=2
set expandtab

" Set the local leader to be "\" and global leader to be "-"
let mapleader = "-"
let maplocalleader = "\\"

" Automatically install the solarized dark color scheme
if empty(glob("~/.vim/colors/solarized.vim"))
  silent !curl -fLo ~/.vim/colors/solarized.vim --create-dirs
		\ https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim
  silent !curl -fLo ~/.vim/autoload/togglebg.vim --create-dirs
  		\ https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/autoload/togglebg.vim
  silent !curl -fLo ~/.vim/bitmaps/togglebg.png --create-dirs
		\ https://github.com/altercation/vim-colors-solarized/blob/master/bitmaps/togglebg.png?raw=true
  silent !curl -fLo ~/.vim/doc/solarized.txt --create-dirs
  		\ https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/doc/solarized.txt
  silent !curl -fLo ~/.vim/doc/tags --create-dirs
		\ https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/doc/tags
endif

" Enable solarized dark
set background=dark
colorscheme solarized

" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load vim-plug packages, being sure to use single quotes
call plug#begin('~/.vim/bundle')

Plug 'jalvesaq/Nvim-R'
Plug 'chrisbra/csv.vim'
Plug 'lervag/vimtex'
Plug 'christoomey/vim-tmux-navigator'
Plug 'leafgarland/typescript-vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'eigenfoo/stan-vim'
Plug 'tpope/vim-liquid'
Plug 'plasticboy/vim-markdown'

call plug#end()

" Open nvim-r terminals in new tmux pane instead of in nvim
if has('nvim')
   let R_external_term = 0
   let R_source = $HOME . '/.vim/bundle/Nvim-R/R/tmux_split.vim'
endif

" Compile latex files with the '-shell-escape' flag for minted.
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \    '-xelatex',
    \    '-shell-escape',
    \    '-verbose',
    \    '-file-line-error',
    \    '-synctex=1',
    \    '-interaction=nonstopmode',
    \ ],
    \}
