vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    -- Look for .prettierrc or similar files
    local prettier_files = {
      ".prettierrc",
      ".prettierrc.json",
      ".prettierrc.yml",
      ".prettierrc.yaml",
      ".prettierrc.js",
    }

    for _, filename in ipairs(prettier_files) do
      local path = vim.fs.find(filename, {
        path = vim.fn.expand("%:p:h"),
        upward = true,
        stop = vim.uv.os_homedir(),
      })

      if not vim.tbl_isempty(path) then
        local col = vim.fn.system("sed -n '/printWidth/p' " .. path[1] .. "| awk -F':|,' '{print $2}'| cut -d' ' -f2")
        -- Remove any newlines or whitespace
        col = vim.trim(col)

        if col ~= "" then
          -- Convert to number and set only if it's a valid number
          local num = tonumber(col)
          if num then
            vim.opt.colorcolumn = tostring(num)
          end
          break -- Exit after finding first valid config
        end
      end
    end
  end,
})

-- Custom highlights
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   group = vim.api.nvim_create_augroup("CustomHighlights", { clear = true }),
--   pattern = "*",
--   callback = function()
--     -- Zenbones
--     vim.api.nvim_set_hl(0, "Boolean", { italic = false })
--
--   end,
-- })

-- Disable colorcolumn on dashboard
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype ~= "snacks_dashboard" then
      vim.opt.colorcolumn = "80"
    end

    -- Highlight overrides
    vim.api.nvim_set_hl(0, "FlashMatch", { fg = "none", bg = "none" })
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ffffff", bg = "#ff0066" })
  end,
})
