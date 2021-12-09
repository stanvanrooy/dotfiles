set nocompatible
filetype off
syntax on

set rtp+=~/.vim/bundle/Vundle.vim
set rtp^=~/projects/coc-pyre/
call vundle#begin()

Plugin 'OmniSharp/omnisharp-vim'
Plugin 'gmarik/Vundle.vim'
" beautifull colorschemes
Plugin 'flazz/vim-colorschemes'
" temporarily highlights the line vim moves to after a search
Plugin 'inside/vim-search-pulse'
" beautifull bottom bar in the editor
Plugin 'vim-airline/vim-airline'
" highlight all other occurences of a search term
Plugin 'RRethy/vim-illuminate'
" syntax highlighting
Plugin 'neoclide/coc.nvim'
" easy navigation between vim and tmux
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'github/copilot.vim'

call vundle#end()
filetype plugin indent on

" add sub directories to path for find
set path+=**

colorscheme zenburn
set tags=./tags,tags;$HOME

" Use the OS's clipboard
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
set undofile

set textwidth=72

" coc.nvim setup
let g:coc_global_extensions = ['coc-tslint', 'coc-html', 'coc-angular', 'coc-cmake', 'coc-html-css-support', 'coc-sh', 'coc-tsserver'] 

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

" map filetypes
autocmd BufEnter *.svelte :setlocal filetype=svelte

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

" spell check for markdown, asciidoc & git commit messages
autocmd BufRead,BufNewFile *.md,*.adoc,*.txt,*.git-commit :set spell spelllang=en_us

