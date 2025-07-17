-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Enable LazyVim auto format
vim.g.autoformat = true

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
-- vim.opt.colorcolumn = "80"

vim.opt.number = false
vim.opt.relativenumber = false
-- FlashLabel

-- vim.api.nvim_set_hl(0, "FlashLabel", {
--   bg = "#ff0066",
--   bold = true,
-- })
-- transparent notify background
-- vim.api.nvim_set_hl(0, "NotifyINFOBody", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyERRORBody", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyWARNBody", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyTRACEBody", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyINFOTitle", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyERRORTitle", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyWARNTitle", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyTRACETitle", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyINFOBorder", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyERRORBorder", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyWARNBorder", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { bg = "none", ctermbg = "none", force = true })
-- vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { bg = "none", ctermbg = "none", force = true })
