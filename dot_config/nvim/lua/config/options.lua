-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Enable LazyVim auto format
vim.g.autoformat = true

-- https://www.lazyvim.org/extras/linting/eslint#options
-- vim.g.lazyvim_eslint_auto_format = true

-- https://www.lazyvim.org/extras/formatting/prettier#options
-- vim.g.lazyvim_prettier_needs_config = true

-- Folding
vim.opt.foldenable = true
vim.opt.foldnestmax = 10
vim.opt.foldlevelstart = 10
vim.opt.foldmethod = "indent"

-- Enable 24-bit RGB colors
vim.opt.termguicolors = true

vim.opt.showmatch = true -- Highlight matching parenthesis
vim.opt.splitright = true -- Split windows right to the current windows
vim.opt.splitbelow = true -- Split windows below to the current windows
vim.opt.autowrite = true -- Automatically save before :next, :make etc.
-- vim.opt.autochdir = true -- Change CWD when I open a file

vim.opt.clipboard = "unnamedplus" -- Copy/paste to system clipboard
vim.opt.swapfile = false -- Don't use swapfile
vim.opt.ignorecase = true -- Search case insensitive...
vim.opt.smartcase = true -- ... but not it begins with upper case
vim.opt.completeopt = "menuone,noinsert,noselect" -- Autocomplete options

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"

vim.opt.wrap = true

vim.opt.number = false
vim.opt.relativenumber = false

-- Disable status line
-- vim.opt.laststatus = 0
