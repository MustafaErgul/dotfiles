-- Mason conifg for LSP servers
require("mason").setup()
require("mason-lspconfig").setup{
    ensure_installed = { "solargraph", "tsserver", "eslint" }
}

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

require("nvim-autopairs")

require('nvim-web-devicons').setup()

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

-- Standard Ruby Style Guide config
vim.opt.signcolumn = "yes" -- otherwise it bounces in and out, not strictly needed though
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }), -- also this is not /needed/ but it's good practice 
  callback = function()
    vim.lsp.start {
      name = "standard",
      cmd = { "standardrb", "--lsp" },
    }
  end,
})


require'prettier'.setup({
  bin = 'prettier',
  filetypes = {
    "css",
    "scss",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
    "yml",
    "graphql"
  },
  cli_options = {
    trailingComma = "es5",
    tabWidth = 2,
    semi = true,
    singleQuote = true,
    printWidth = 140
  },
})

-- prettier.nvim format_on_save config
local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

require'nvim-treesitter.configs'.setup {
    ensure_installed = { 
      "javascript", 
      "typescript", 
      "ruby", 
      "json", 
      "vim",
      "lua", 
      "css", 
      "yaml",
      "query",
      "graphql",
    },
    highlight = {
    enable = true,
    indent = {
       enable = true
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "?",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

require'lualine'.setup {
      options = {
        icons_enabled = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = { 'NvimTree' },
        },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff',
                      {'diagnostics', sources={'nvim_lsp', 'coc'}}},
        lualine_c = {   
                        "'%='",
                        {   
                            icons_enabled = true,
                            'filename',                        
                            file_status = true,  -- displays file status (readonly status, modified status)
                            path = 1,            -- 0 = just filename, 1 = relative path, 2 = absolute path
                            align = left
                            --shorting_target = 40 -- Shortens path to leave 40 space in the window
                        }
                    },
        lualine_x = {'filetype'},
        lualine_y = {},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {'progress'},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    }

require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  --auto_close        = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {
        "^\\.git"
    }
  },
  view = {
    width = 40,
    hide_root_folder = false,
    side = 'left',
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}
