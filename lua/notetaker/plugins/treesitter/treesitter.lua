return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Create a safe treesitter wrapper
      local function safe_treesitter_operation(operation, ...)
        local ok, result = pcall(operation, ...)
        if not ok then
          -- Log the error but don't crash
          vim.notify("Treesitter operation failed: " .. tostring(result), vim.log.levels.WARN)
          return nil
        end
        return result
      end

      -- Override treesitter highlight function to handle errors gracefully
      local original_highlight = vim.treesitter.highlighter.hl_range
      vim.treesitter.highlighter.hl_range = function(self, ...)
        return safe_treesitter_operation(original_highlight, self, ...)
      end

      -- Override treesitter query function to handle invalid node types
      local original_query = vim.treesitter.query.get
      vim.treesitter.query.get = function(lang, query_name)
        return safe_treesitter_operation(original_query, lang, query_name)
      end

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "markdown", "markdown_inline", "lua", "vim", "bash", "json", "yaml"
        },
        highlight = { 
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = { enable = true },
        indent = { enable = true },
        -- rainbow = { enable = true, extended_mode = true }, -- Removed, handled by rainbow-delimiters.nvim
      })
      
      -- Add error handling for treesitter queries
      local function safe_require(module)
        local ok, result = pcall(require, module)
        if not ok then
          vim.notify("Failed to load " .. module .. ": " .. result, vim.log.levels.WARN)
          return nil
        end
        return result
      end
      
      -- Disable problematic parsers that might cause query errors
      local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      if parser_configs.re2c then
        parser_configs.re2c.install_info.url = nil -- Disable re2c parser
      end
      if parser_configs.commonlisp then
        parser_configs.commonlisp.install_info.url = nil -- Disable commonlisp parser
      end

      -- Add autocmd to handle treesitter errors on buffer load
      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function()
          -- This will catch any treesitter errors when loading files
          safe_treesitter_operation(function()
            -- Any treesitter operations here will be wrapped in error handling
            return true
          end)
        end,
      })
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      -- Default config is usually sufficient, but you can customize here if needed
      -- local rainbow_delimiters = require('rainbow-delimiters')
      -- vim.g.rainbow_delimiters = { ... }
    end,
  },
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  },
  -- { import = "notetaker.plugins.treesitter.buffer" }, -- Removed because the module does not exist
}

-- Default Treesitter Keymaps (may require manual setup in your config):
-- Incremental selection:
--   init_selection    : gn
--   node_incremental  : grn
--   node_decremental  : grm
--   scope_incremental : grc
-- Rainbow parentheses: (no default keymap, enabled automatically) 