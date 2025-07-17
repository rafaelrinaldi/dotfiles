return {
  "f-person/auto-dark-mode.nvim",
  enabled = true,
  opts = {
    update_interval = 450,
    set_dark_mode = function()
      vim.o.background = "dark"

      -- local config_current = require("everforest").config
      -- local config_next = vim.tbl_deep_extend("force", config_current, { background = "hard" })
      --
      -- require("everforest").setup(config_next)
    end,
    set_light_mode = function()
      vim.o.background = "light"

      -- local config_current = require("everforest").config
      -- local config_next = vim.tbl_deep_extend("force", config_current, { background = "hard" })
      --
      -- require("everforest").setup(config_next)
    end,
  },
}
