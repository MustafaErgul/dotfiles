syntax on

set laststatus=2
set noerrorbells
set guicursor=
set relativenumber
set nu
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set nohlsearch
set hidden
set smartindent
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set encoding=UTF-8
set list
set listchars=tab:>-

let mapleader = "\<space>"

filetype plugin on
set omnifunc=syntaxcomplete#Complete

nmap <C-n> :NERDTreeToggle<CR>

nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>

nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>

call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'preservim/nerdtree'
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vim-scripts/delimitMate.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'stsewd/fzf-checkout.vim'
call plug#end()

let g:fzf_layout = { 'window': { 'width':0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
nnoremap <leader>gc :GCheckout<CR>

let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='simple'

colorscheme gruvbox
set background=dark

highlight link xmlEndTag xmlTag

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup mergul
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END