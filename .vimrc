syntax on

set laststatus=2
set noerrorbells
set guifont=UbuntuMono_Nerd_Font:20
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
set colorcolumn=80
let NERDTreeShowHidden=1

nmap <leader>gs :Gstatus<CR><C-w>5-

let mapleader = "\<space>"

filetype plugin on
set omnifunc=syntaxcomplete#Complete

nmap <C-n> :NERDTreeToggle<CR>
let g:DevIconsEnableFoldersOpenClose = 1
packloadall

nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>

nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>

"Keep the line scroll in the middle
nnoremap j jzzzv
nnoremap k kzzzv

"Remap insert-mode
nnoremap ı i

call plug#begin('~/.vim/plugged')
    Plug 'gruvbox-community/gruvbox'
    Plug 'jremmen/vim-ripgrep'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'git@github.com:tpope/vim-rails.git'
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
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'yaml', 'yml'] }
    Plug 'ryanoasis/vim-devicons'
call plug#end()

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.yaml,*.yml PrettierAsync

let g:fzf_layout = { 'window': { 'width':0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
nnoremap <leader>gc :GCheckout<CR>

let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='gruvbox'
let g:airline_section_z = '%l:%c'

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

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

augroup nerdtreeconcealbrackets
    autocmd!
    autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
    autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
    autocmd FileType nerdtree setlocal conceallevel=3
    autocmd FileType nerdtree setlocal concealcursor=nvic
augroup END
