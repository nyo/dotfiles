" use vim mode instead of pure vi
set nocompatible
" syntax highlighting
if $TERM == "xterm-256color"
  set t_Co=256
endif
" enable syntax highlighting
syntax enable
" dark background for console
set background=dark
" enabled line numbers
set number
" enable mouse in vim
set mouse=a
" sets how many lines of history vim has to remember
set history=1000
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" enable auto indentation when writting code
set autoindent
" highlight search results
set hlsearch
" do case insensitive search...
set ignorecase
" ...unless capital letters are used
set smartcase
" highlight matching braces
set showmatch
" show insert/replace/visual mode
set showmode
" show the cursor position all the time
set ruler
" allow pattern matching with special characters
set magic
" confirm `:q` in case of unsaved changes
set confirm
" encoding used for displaying file
set encoding=utf-8
" encoding used when saving file
set fileencoding=utf-8
" do not keep the backup~ file
set nobackup
