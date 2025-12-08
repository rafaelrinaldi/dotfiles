-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Toggle fold
vim.keymap.set("n", "<Tab>", "za", { desc = "Toggle Fold", silent = true })

-- Snacks.notifier.hide()
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><cmd>lua Snacks.notifier.hide()<cr><esc>", { noremap = true, silent = true })

-- Delete key for killing buffers
vim.keymap.set("n", "<del>", "<cmd>lua Snacks.bufdelete()<cr>", { noremap = true })
