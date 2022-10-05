syntax on

set encoding=UTF-8
set laststatus=2
set noerrorbells
set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20
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
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set list
set listchars=tab:>-
set colorcolumn=80
set clipboard+=unnamedplus

let mapleader = "\<Space>"

call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'tpope/vim-fugitive'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'projekt0n/github-nvim-theme'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'neovim/nvim-lspconfig'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "Python Plugins"
    Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'lukas-reineke/indent-blankline.nvim'
    "Ruby on Rails Plugins"
    Plug 'vim-ruby/vim-ruby'
    Plug 'tpope/vim-rails'
call plug#end()

" Deoplete configs
call deoplete#custom#option('auto_complete_delay', 100)
let g:deoplete#enable_at_startup = 1

" Coc extensions
let g:coc_global_extensions = ['coc-snippets', 'coc-css', 'coc-json', 'coc-yaml', 'coc-html']

" Nvim tree load-up
" lua require'nvim-tree'.setup {}

" Vim-fugitive configs
nmap <leader>gs :Gstatus<CR><C-w>-5
nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //1<CR>

" Keep the line scroll in the middle
nnoremap j jzzzv
nnoremap k kzzzv

" NvimTree configs
nnoremap <C-n> :NvimTreeToggle<CR>

" Remap insert-mode
nnoremap ı i

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" vim-multiple-cursors
" see https://github.com/terryma/vim-multiple-cursors/issues/235
func! Multiple_cursors_before()
    call deoplete#init#_disable()
endfunc
func! Multiple_cursors_after()
    call deoplete#init#_enable()
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""" solargraph-lspconfig to work
lua << EOF
require'lspconfig'.solargraph.setup{}
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "solargraph" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
	on_attach = on_attach,
	flags = {
	  debounce_text_changes = 150,
	}
  }
end

EOF

lua << EOF
-- Mappings.
local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end

-- this part is telling Neovim to use the lsp server
local servers = { 'pyright', 'tsserver' }
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
    }
end

-- this is for diagnositcs signs on the line number column
-- use this to beautify the plain E W signs to more fun ones
-- !important nerdfonts needs to be setup for this to work in your terminal
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " } 
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end
EOF

" Source init.lua
lua require("init")
