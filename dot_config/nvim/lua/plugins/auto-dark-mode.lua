return {
  "f-person/auto-dark-mode.nvim",
  enabled = true,
  opts = {
    update_interval = 450,
    set_dark_mode = function()
      vim.o.background = "dark"
    end,
    set_light_mode = function()
      vim.o.background = "light"
    end,
  },
}
