""""""""""""""""""""""""""""""""""""""""""""""""""
" Description:
"   This is the .vimrc file
"
" Maintainer:
"   Byh0ki
"
" Complete_version:
"   You can find the complete configuration,
"   including all the plugins used, here:
"   https://github.com/Byh0ki/.dotfiles
"
" Acknowledgements:
"
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" General parameters
""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable vi compatibility
set nocompatible

" Sets how many lines of history VIM has to remember
set history=500

""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-plug
call plug#begin('~/.vim/plugged')

" Installed
Plug 'junegunn/fzf.vim'
"Plug 'itchyny/lightline.vim'
Plug 'scrooloose/syntastic'
Plug 'jiangmiao/auto-pairs'


" Testing / Removed for test purpose
"Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'luochen1990/rainbow'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'



" On demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable filetype plugins
filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread

"Always show current position
"set ruler

"Set line number
set number

"""""""""""""""""""""""""""""""""""""""""""""""""
" Search options
""""""""""""""""""""""""""""""""""""""""""""""""""

set gdefault                " RegExp global by default
set magic                   " Enable extended regexes.
set hlsearch                " highlight searches
set incsearch               " show the `best match so far' astyped
set ignorecase smartcase    " make searches case-insensitive, unless they
                            "   contain upper-case letters

"""""""""""""""""""""""""""""""""""""""""""""""""
" Performance / buffer
""""""""""""""""""""""""""""""""""""""""""""""""""

set hidden                  " can put buffer to the background without writing
                            "   to disk, will remember history/marks.
set lazyredraw              " don't update the display while executing macros
set ttyfast                 " Send more characters at a given time.


""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation options
""""""""""""""""""""""""""""""""""""""""""""""""""

set expandtab                   " Expand tabs to spaces
set autoindent smartindent      " auto/smart indent
set copyindent                  " copy previous indentation on auto indent
set softtabstop=2               " Tab key results in # spaces
set tabstop=8                   " Tab is # spaces
set shiftwidth=2                " The # of spaces for indenting.
set smarttab                    " At start of line, <Tab> inserts shift width
                                "   spaces, <Bs> deletes shift width spaces.

set wrap                        " wrap lines
set textwidth=79

"80 column limit
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Enables syntax highlighting
syntax on


""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin mappings and options
""""""""""""""""""""""""""""""""""""""""""""""""""

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:rainbow_active = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
" Not yet validated stuff / Test / Debug
""""""""""""""""""""""""""""""""""""""""""""""""""

au BufNewFile * startinsert
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
