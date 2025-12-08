return {
  "akinsho/bufferline.nvim",
  opts = function()
    return {
      options = {
        max_name_length = 24,
        separator_style = "thick",
        show_buffer_close_icons = false,
        show_buffer_icons = true,
        tab_size = 24,
        style_preset = 4, -- no_italic
        highlights = {},
        -- highlights = require("rose-pine.plugins.bufferline"),
        -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
        -- indicator = {
        -- style_preset = "thick",
        -- },
      },
    }
  end,
}
