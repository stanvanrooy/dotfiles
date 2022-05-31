set nocompatible
filetype off
syntax on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
" beautifull colorschemes
Plugin 'flazz/vim-colorschemes'
" temporarily highlights the line vim moves to after a search
Plugin 'inside/vim-search-pulse'
" highlight all other occurences of a search term
Plugin 'RRethy/vim-illuminate'
" easy navigation between vim and tmux
Plugin 'christoomey/vim-tmux-navigator'
" show tabs for all buffers
Plugin 'ap/vim-buftabline'
" fuzzy finder 
Plugin 'kien/ctrlp.vim'
" Syntax highlighting
Plugin 'github/copilot.vim'

call vundle#end()
filetype plugin indent on

" add sub directories to path for find
set path+=**

" Show file options above command line
set wildmenu
set wildignore+=*.swp,*.swo,bin/*,obj/*

" Automatically change directory to the directory of whichever file is opened
set autochdir

colorscheme gruvbox
set tags=./tags,tags;$HOME

" Use the OS's clipboard
set clipboard=unnamed
" Optimize for fast terminal connections
set ttyfast

" Set default indentation to 2 spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
let mapleader=" "

" Set indentation to 4 spaces for .cs files
autocmd FileType cs setlocal shiftwidth=4 softtabstop=4 expandtab

" Enable relative line numbers
set relativenumber

" Centralize backups, swp files and undo history
set backupdir=~/dotfiles/.vim/backups
set directory=~/dotfiles/.vim/swaps
set undodir=~/dotfiles/.vim/undos
set undofile

set textwidth=72

set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use backspace to go to previous line
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" spell check for markdown, asciidoc & git commit messages
autocmd BufRead,BufNewFile *.md,*.adoc,*.txt,*.git-commit :set spell spelllang=en_us

" execute macro q by pressing space
:nnoremap <Space> @q

" buffer tabs
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" fuzzy finder
let g:ctrlp_map = '<c-f>'

