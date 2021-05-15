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
Plugin 'neoclide/coc.nvim'
Plugin 'Shirk/vim-gas'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'

call vundle#end()
filetype plugin indent on

" Map ctrl + o to open file explorer
map <C-o> :NERDTreeToggle<CR>

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

" coc.nvim setup
let g:coc_global_extensions = ['coc-json', 'coc-json', 'coc-tslint', 'coc-html', 'coc-angular', 'coc-clangd', 'coc-git', 'coc-go', 'coc-cmake', 'coc-html-css-support', 'coc-pyright', 'coc-sh', 'coc-omnisharp']

set updatetime=300
set shortmess+=c
set signcolumn=yes

" use tab for completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use ctrl + space to trigger completion
inoremap <silent><expr> <c-@> coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" go to shortcuts
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" map K to show docs
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

