return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.zenbones = { italic_strings = false }
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "zenbones",
    },
  },
}
