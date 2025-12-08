return {
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "catppuccin/nvim",
    enabled = false,
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.zenbones = { italic_strings = false, lighten_comments = 20 }
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "zenbones",
    },
  },
}
