syntax on

" vim-ruby
set nocompatible      " We're running Vim, not Vi!
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

set encoding=UTF-8
set laststatus=2
set noerrorbells
set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20
set relativenumber
set nu
set tabstop=2 shiftwidth=2 softtabstop=2
set shiftwidth=2
set expandtab
set hidden
set noswapfile
set autoindent
set nobackup
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set list
set listchars=tab:>-
set colorcolumn=80
set clipboard+=unnamedplus
set cursorline

let mapleader = "\<Space>"
let g:blamer_enabled = 1
let g:prettier#config#tab_width = 'auto'
let g:ruby_indent_access_modifier_style = 'indent'

call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'tpope/vim-fugitive'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/plenary.nvim'
    Plug 'BurntSushi/ripgrep'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    Plug 'rebelot/kanagawa.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'       
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'MunifTanjim/prettier.nvim'
    Plug 'vim-ruby/vim-ruby'
    Plug 'tpope/vim-rails'
    Plug 'APZelos/blamer.nvim'
    Plug 'windwp/nvim-autopairs'
    Plug 'pantharshit00/vim-prisma'
    Plug 'airblade/vim-gitgutter'
    Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()

colorscheme kanagawa

packadd! matchit

if !exists( "*EndToken" )
  function EndToken()
    let current_line = getline( '.' )
    let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
    if match( current_line, braces_at_end ) >= 0
      return '}'
    else
      return 'end'
    endif
  endfunction
endif

imap <S-CR> <ESC>:execute 'normal o' . EndToken()<CR>O

" Console log from insert mode; Puts focus inside parentheses
imap cll console.log();<Esc>==h
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap cll yocll<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap cll yiwocll<Esc>p

" Vim-fugitive configs
nmap <leader>gs :Gstatus<CR><C-w>-5
nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //1<CR>

" Keep the line scroll in the middle
nnoremap j jzzzv
nnoremap k kzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" NvimTree configs
nnoremap <C-n> :NvimTreeToggle<CR>

" Remap insert-mode
nnoremap ı i

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>tg <cmd>lua require('telescope.builtin').git_status()<cr>

"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

lua << EOF
  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
EOF

"lua << EOF
"  -- Mappings.
"  local opts = { noremap=true, silent=true }
"
"  -- Use an on_attach function to only map the following keys
"  -- after the language server attaches to the current buffer
"  local on_attach = function(client, bufnr)
"      -- Enable completion triggered by <c-x><c-o>
"      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
"
"      local bufopts = { noremap=true, silent=true, buffer=bufnr }
"      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
"      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
"      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
"      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
"      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
"      vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
"      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
"      vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
"      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
"      vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
"      vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
"      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
"      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
"      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
"  end
"
"
"  -- this is for diagnositcs signs on the line number column
"  -- use this to beautify the plain E W signs to more fun ones
"  -- !important nerdfonts needs to be setup for this to work in your terminal
"  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " } 
"  for type, icon in pairs(signs) do
"      local hl = "DiagnosticSign" .. type
"      vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
"  end
"EOF

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

  -- this is for diagnositcs signs on the line number column
  -- use this to beautify the plain E W signs to more fun ones
  -- !important nerdfonts needs to be setup for this to work in your terminal
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " } 
  for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
  end

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities,
    filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx' }
  }

  local servers = { "solargraph" }
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup {
        on_attach = on_attach,
        default_config = {
          root_dir = [[root_pattern("Gemfile", ".git")]],
        },
        flags = {
          debounce_text_changes = 150,
        }
      }
  end
EOF

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

EOF

" Source init.lua
lua require("init")
