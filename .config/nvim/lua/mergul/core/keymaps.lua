local keymap = vim.keymap

-- alt insert mode
keymap.set("n", "ı", "i", { desc = "go insert mode with ı as well" })

-- movement keymaps
keymap.set("n", "j", "jzzzv", { desc = "go down and center the page" })
keymap.set("n", "k", "kzzzv", { desc = "go up and center the page" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "scroll down and center the page" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "scroll up and center the page" })

-- nvim-tree keymaps
keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "toggle NvimTree" })

-- vim-fugitive keymaps
keymap.set("n", "<leader>gs", ":G<CR><C-w>-5", { desc = "vim-fugitive - git status" })
keymap.set("n", "<leader>gh", ":diffget //3<CR>", { desc = "vim-fugitive - git diff to the right" })
keymap.set("n", "<leader>gu", ":diffget //1<CR>", { desc = "vim-fugitive - git diff to the left" })

-- yank
keymap.set("v", "<leader>y", '"+y', { desc = "yank and keep" })
keymap.set("n", "<leader>p", '"+p', { desc = "yank and keep pasting" })
