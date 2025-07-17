return {
  "folke/flash.nvim",
  enabled = true,
  opts = {
    jump = {
      nohlsearch = true,
    },
    modes = {
      char = {
        jump_labels = true,
      },
      search = {
        enabled = true,
        highlight = { backdrop = true },
      },
    },
  },
}
