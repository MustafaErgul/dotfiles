return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local nvimtree = require("nvim-tree")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		vim.opt.termguicolors = true

		nvimtree.setup({
			view = {
				width = 35,
				side = "right",
			},
			disable_netrw = true,
			hijack_netrw = true,
			--auto_close        = false,
			open_on_tab = false,
			hijack_cursor = true,
			update_cwd = false,
			renderer = {
				icons = {
					web_devicons = {
						file = {
							enable = true,
							color = true,
						},
						folder = {
							enable = false,
							color = true,
						},
					},
				},
			},
			diagnostics = {
				enable = false,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			update_focused_file = {
				enable = false,
				update_cwd = false,
				ignore_list = {},
			},
			system_open = {
				cmd = nil,
				args = {},
			},
			filters = {
				dotfiles = false,
				custom = {
					"^\\.git",
				},
			},
		})
	end,
}
