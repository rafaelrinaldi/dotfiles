-- Use a local cache for Prettier and Git lookups
local prettier_cache = {}
local git_root_cache = {}

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(event)
    if not vim.api.nvim_buf_is_valid(event.buf) then
      return
    end

    local buftype = vim.bo[event.buf].buftype

    -- Don't do anything if not editing an actual file
    if buftype == "nofile" or buftype == "terminal" or buftype == "quickfix" then
      return
    end

    local filetype = vim.bo[event.buf].filetype

    -- Don't render colorcolumn on the dashboard
    if filetype == "snacks_dashboard" then
      vim.wo.colorcolumn = ""
      return
    end

    local relevant_filetypes = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "json",
      "html",
      "css",
      "markdown",
      "mdx",
      "yaml",
      "yml",
    }

    -- Don't do anything if file type is irrelevant
    if not vim.tbl_contains(relevant_filetypes, filetype) then
      return
    end

    -- Recursively search for Git's repository "root" folder
    local function find_git_root()
      local current_file = vim.fn.expand("%:p")
      if current_file == "" then
        return vim.fn.getcwd()
      end

      local file_dir = vim.fn.expand("%:p:h")

      if git_root_cache[file_dir] then
        return git_root_cache[file_dir]
      end

      local git_root = vim.fs.find(".git", {
        path = file_dir,
        upward = true,
        type = "directory",
      })

      local root = not vim.tbl_isempty(git_root) and vim.fn.fnamemodify(git_root[1], ":h") or vim.fn.getcwd()

      git_root_cache[file_dir] = root
      return root
    end

    -- If Prettier config is either a ts/js module, then tries to "require()" it
    -- so we can evaluate the config properly.
    -- Prettier doesn't provide this by default, which is annoying.
    local function parse_config_as_module(config_dir)
      local cmd =
        string.format("cd '%s' && node -e 'console.log(JSON.stringify(require(\"./prettier.config\")))'", config_dir)
      local result = vim.trim(vim.fn.system(cmd))

      if vim.v.shell_error == 0 and result ~= "" and result ~= "null" then
        local success, config = pcall(vim.json.decode, result)
        if success and type(config) == "table" and config.printWidth then
          return tonumber(config.printWidth)
        end
      end
      return nil
    end

    -- Tries to resolve the Prettier configuration as a JSON object.
    local function parse_json_config(config_path)
      local file = io.open(config_path, "r")
      if not file then
        return nil
      end

      local content = file:read("*all")
      file:close()

      local success, data = pcall(vim.json.decode, content)
      if not success or type(data) ~= "table" then
        return nil
      end

      if data.prettier and type(data.prettier) == "table" and data.prettier.printWidth then
        return tonumber(data.prettier.printWidth)
      elseif data.printWidth then
        return tonumber(data.printWidth)
      end

      return nil
    end

    -- Lastly, it tries to resolve Prettier's config by simply printing out its
    -- content and "grepping" for "printWidth".
    local function parse_other_config(config_path)
      local cmd = string.format("rg -o 'printWidth\\s*:\\s*(\\d+)' -r '$1' '%s'", config_path)
      local result = vim.trim(vim.fn.system(cmd))

      if vim.v.shell_error == 0 and result ~= "" then
        return tonumber(result)
      end
      return nil
    end

    local function get_prettier_config()
      local search_root = find_git_root()

      if prettier_cache[search_root] then
        return prettier_cache[search_root]
      end

      local config_files = {
        "prettier.config.js",
        "prettier.config.ts",
        "package.json",
        ".prettierrc.js",
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
      }

      for _, filename in ipairs(config_files) do
        local found_files = vim.fs.find(filename, {
          path = search_root,
          upward = true,
          stop = vim.uv.os_homedir(),
        })

        if not vim.tbl_isempty(found_files) then
          local config_path = found_files[1]
          local config_dir = vim.fn.fnamemodify(config_path, ":h")
          local config_file = vim.fn.fnamemodify(config_path, ":t")
          local print_width = nil

          if config_file == "prettier.config.js" or config_file == "prettier.config.ts" then
            print_width = parse_config_as_module(config_dir)
          elseif config_file == "package.json" or config_file == ".prettierrc.json" then
            print_width = parse_json_config(config_path)
          else
            print_width = parse_other_config(config_path)
          end

          if print_width then
            prettier_cache[search_root] = print_width
            return print_width
          end
        end
      end

      prettier_cache[search_root] = nil
      return nil
    end

    local print_width = get_prettier_config()

    if print_width and print_width > 0 then
      vim.wo.colorcolumn = tostring(print_width)
      vim.bo[event.buf].textwidth = print_width
    else
      vim.wo.colorcolumn = "80"
      vim.bo[event.buf].textwidth = 80
    end
  end,
})

vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    prettier_cache = {}
    git_root_cache = {}
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Override "Flash" search match highlight
    vim.api.nvim_set_hl(0, "FlashMatch", { fg = "none", bg = "none" })
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ffffff", bg = "#ff0066" })

    -- Darker blocks when dimming is enabled
    local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
    vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = comment_hl.fg })

    -- Override "colorcolumn" so it matches the same background as "cursorline"
    local cursorline_hl = vim.api.nvim_get_hl(0, { name = "CursorLine" })
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = cursorline_hl.bg })
  end,
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype
    local bt = vim.bo[buf].buftype

    -- Skip special buffers and filetypes
    local excluded_fts = { "gitcommit", "gitrebase", "snacks_dashboard" }
    local excluded_bts = { "quickfix", "nofile", "help", "acwrite", "terminal" }

    if vim.tbl_contains(excluded_fts, ft) or vim.tbl_contains(excluded_bts, bt) then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local line_count = vim.api.nvim_buf_line_count(buf)

    -- Ensure mark is valid and within bounds
    if mark[1] > 0 and mark[1] <= line_count then
      vim.schedule(function()
        -- Check if buffer is still valid
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end

        -- Only restore if we're in the target buffer
        if vim.api.nvim_get_current_buf() == buf then
          vim.api.nvim_win_set_cursor(0, { mark[1], mark[2] })
          -- Center the line and open folds if any
          vim.cmd("normal! zv zz")
        end
      end)
    end
  end,
  group = vim.api.nvim_create_augroup("RestoreCursorPosition", { clear = true }),
  desc = "Restore cursor position when opening file",
})
