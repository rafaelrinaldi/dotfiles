-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local Util = require("lazyvim.util")

vim.keymap.set("n", "<Tab>", "za", { desc = "Toggle Fold", silent = true })
-- vim.keymap.set("n", "<Leader>b", "<cmd>Telescope buffers<cr>")
-- vim.keymap.set("n", "<Leader>f", Util.telescope("files"))

-- TypeScript
-- vim.keymap.set("n", "<M-LeftMouse>", ":TypescriptGoToSourceDefinition<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>tr", ":TypescriptRenameFile<CR>")
-- vim.keymap.set("n", "<leader>ti", ":TypescriptAddMissingImports<CR>")
--
-- Markdown
-- vim.keymap.set("n", "<leader>md", ":MarkdownPreview<CR>")

-- zen-mode
-- vim.keymap.set("n", "<leader>f", ":ZenMode<CR>", { noremap = true })

-- Git
vim.keymap.set("n", "<leader>gn", ":Neogit<CR>", { desc = "Open Neogit", noremap = true })
-- vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { noremap = true })

-- Neotree
-- vim.keymap.set(
--   "n",
--   "-",
--   "<cmd>Neotree position=current action=show<cr>",
--   { desc = "Open Neotree full screen", noremap = true }
-- )

-- Default to `git_files` instead of `find_files` mostly because I was having issues with losing project root reference all the time
-- vim.keymap.set("n", "<leader><space>", "<cmd>FzfLua git_files<cr>", { desc = "Find Files (Git)", noremap = true })

-- Get rid of search highlights when pressing escape
-- vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>", { noremap = true, silent = true })

-- Clear search with <esc>
-- vim.keymap.set("n", "<esc>", "<cmd>lua require('noice').cmd('dismiss')<cr>", { noremap = true, silent = true })

-- Clear notifications and search highlights when pressing escape
-- vim.keymap.set(
--   "n",
--   "<esc>",
--   "<cmd>noh<cr><cmd>lua require('noice').cmd('dismiss')<cr><esc>",
--   { noremap = true, silent = true }
-- )
-- Snacks.notifier.hide()
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><cmd>lua Snacks.notifier.hide()<cr><esc>", { noremap = true, silent = true })

-- Delete key for killing buffers
vim.keymap.set("n", "<del>", "<cmd>lua Snacks.bufdelete()<cr>", { noremap = true })
-- vim.keymap.set("n", "<del>", "<cmd>close<cr>", { noremap = true, silent = true })
