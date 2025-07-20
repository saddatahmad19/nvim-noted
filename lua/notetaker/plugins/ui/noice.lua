return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        -- Add any options here
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          opts = {
            position = {
              row = "50%",
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
          },
        },
        messages = {
          enabled = true,
          view = "notify",
          view_error = "notify",
          view_warn = "notify",
          view_history = "messages",
          opts = {},
        },
        popupmenu = {
          enabled = true,
          backend = "nui",
        },
        notify = {
          enabled = true,
          view = "notify",
        },
        lsp = {
          progress = {
            enabled = true,
            format = "lsp_progress",
            format_done = "lsp_progress_done",
            throttle = 1000 / 30,
            view = "mini",
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = {
            enabled = true,
            silent = false,
            view = nil,
            opts = {},
          },
          signature = {
            enabled = true,
            auto_open = {
              enabled = true,
              trigger = true,
              luasnip = true,
              throttle = 50,
            },
            view = nil,
            opts = {},
          },
          message = {
            enabled = true,
            view = "notify",
            opts = {},
          },
        },
        markdown = {
          hover = {
            ["|(%S-)|"] = vim.cmd.help,
            ["%[.-%]%((%S-)%)"] = require("noice.util").open,
          },
          highlights = {
            ["%|%S+|"] = "@text.reference",
            ["@%S+"] = "@parameter",
            ["^%s*(Parameters:)"] = "@text.title",
            ["^%s*(Return:)"] = "@text.title",
            ["^%s*(See also:)"] = "@text.title",
            ["{%S-}"] = "@parameter",
          },
        },
        health = {
          checker = true,
        },
        smart_move = {
          enabled = true,
          excluded_filetypes = {
            "cmp_menu",
            "cmp_docs",
            "notify",
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
        throttle = 1000 / 30,
        views = {},
        routes = {},
        status = {},
        format = {},
      })

      -- Add error handling for treesitter queries
      local function safe_treesitter_query()
        local ok, result = pcall(function()
          -- This will catch any treesitter query errors
          return true
        end)
        if not ok then
          vim.notify("Treesitter query error: " .. tostring(result), vim.log.levels.WARN)
          return false
        end
        return true
      end

      -- Wrap treesitter operations in error handling
      local original_ts_highlight = vim.treesitter.highlighter.hl_range
      vim.treesitter.highlighter.hl_range = function(self, ...)
        local ok, result = pcall(original_ts_highlight, self, ...)
        if not ok then
          -- Silently handle treesitter highlighting errors
          return
        end
        return result
      end

      -- Add autocmd to handle treesitter errors gracefully
      vim.api.nvim_create_autocmd("User", {
        pattern = "NoiceCmdlinePopup",
        callback = function()
          -- Handle any treesitter-related errors in the cmdline popup
          safe_treesitter_query()
        end,
      })
    end,
}