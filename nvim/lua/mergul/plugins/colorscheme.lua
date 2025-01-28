return {
	"catppuccin/nvim",
	config = function()
		require("catppuccin").setup({
			integrations = {
				neotree = true,
				gitsigns = true,
				cmp = true,
				mason = false,
				treesitter = true,
				telescope = {
					enabled = true,
					-- style = "nvchad"
				},
				lsp_trouble = false,
				-- nvim-lspconfig colors
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
						ok = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
			},
		})
		vim.cmd("colorscheme catppuccin-mocha")
	end,
}
