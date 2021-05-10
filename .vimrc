set nocompatible
filetype off
syntax on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Omnisharp/omnisharp-vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'inside/vim-search-pulse'
Plugin 'vim-airline/vim-airline'
Plugin 'RRethy/vim-illuminate'
Plugin 'ycm-core/YouCompleteMe', {'do': './install.py --all' }
Plugin 'Shirk/vim-gas'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'

call vundle#end()
filetype plugin indent on

" Map ctrl + o to open file explorer
map <C-o> :NERDTreeToggle<CR>

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_see_identifiers_with_syntax = 1
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
let g:ycm_use_clangd = 1

colorscheme apprentice
set tags=./tags,tags;$HOME

" Use the OS clipboard
set clipboard=unnamed
" Optimize for fast terminal connections
set ttyfast
" Set indentation to 2 spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
" Enable relative line numbers
set relativenumber
" Centralize backups, swp files and undo history
set backupdir=~/dotfiles/.vim/backups
set directory=~/dotfiles/.vim/swaps
set undodir=~/dotfiles/.vim/undos

