set nocompatible
filetype off
syntax on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
" Beautifull colorschemes
Plugin 'flazz/vim-colorschemes'

" Hemporarily highlights the line vim moves to after a search
Plugin 'inside/vim-search-pulse'

" Highlight all other occurences of a search term
Plugin 'RRethy/vim-illuminate'

" Easy navigation between vim and tmux
Plugin 'christoomey/vim-tmux-navigator'

" Show tabs for all buffers
Plugin 'ap/vim-buftabline'

" fuzzy finder 
Plugin 'kien/ctrlp.vim'

Plugin 'github/copilot.vim'

" Org mode
Plugin 'jceb/vim-orgmode'
Plugin 'vim-scripts/utl.vim'
Plugin 'tpope/vim-speeddating'

call vundle#end()

filetype plugin indent on

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords


" add sub directories to path for find
set path+=**

" Show file options above command line
set wildmenu
set wildignore+=*.swp,*.swo,bin/*,obj/*

colorscheme gruvbox

" Use the OS's clipboard
set clipboard=unnamed
" Optimize for fast terminal connections
set ttyfast

" Set default indentation to 2 spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
let mapleader="//"
let maplocalleader=","

" Set indentation to 4 spaces for .cs files
autocmd FileType cs setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab

" Set indentation to 2 spaces for .py files
autocmd FileType py setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

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
autocmd BufRead,BufNewFile *.md,*.adoc,*.txt,*.git-commit,*.org :set spell spelllang=en_us

" execute macro q by pressing space
:nnoremap <Space> @q

" buffer tabs
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" fuzzy finder
let g:ctrlp_map = '<c-f>'

" org mode
packloadall
silent! helptags ALL

augroup dateformats
	autocmd!
	autocmd VimEnter * silent execute 'SpeedDatingFormat %d-%m-%Y'
augroup END

let g:org_agenda_files=['~/org/todo.org']

" UTL
let g:utl_cfg_hdl_scm_http_system = ":call system('open %u')"
