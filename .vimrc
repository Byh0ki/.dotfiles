" Useful for exam session


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/syntastic'
Plug 'valloric/youcompleteme'

" On demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } 

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " Disable vi compatibility
set nocompatible

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

"Always show current position
set ruler

"Set line number
set number

" --- search / regexp ---
set gdefault                " RegExp global by default
set magic                   " Enable extended regexes.
set hlsearch                " highlight searches
set incsearch               " show the `best match so far' astyped
set ignorecase smartcase    " make searches case-insensitive, unless they
                            "   contain upper-case letters

" --- performance / buffer ---
set hidden                  " can put buffer to the background without writing
                            "   to disk, will remember history/marks.
set lazyredraw              " don't update the display while executing macros
set ttyfast                 " Send more characters at a given time.

" --- Indent---
set expandtab                   " Expand tabs to spaces
set autoindent smartindent      " auto/smart indent
set copyindent                  " copy previous indentation on auto indent
set softtabstop=2               " Tab key results in # spaces
set tabstop=2                   " Tab is # spaces
set shiftwidth=2                " The # of spaces for indenting.
set smarttab                    " At start of line, <Tab> inserts shift width
                                "   spaces, <Bs> deletes shift width spaces.

set wrap                        " wrap lines
set textwidth=80
"80 column limit
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

