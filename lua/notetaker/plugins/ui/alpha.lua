return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "MaximilianLloyd/ascii.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local ascii = require("ascii")
    local Popup = require("nui.popup")
    local event = require("nui.utils.autocmd").event

    -- Essential <leader>p commands
    local leader_p_commands = {
      { key = "<leader>pf", desc = "Open file explorer at file's directory" },
      { key = "<leader>ps", desc = "Format and Save file" },
      { key = "<leader>fs", desc = "Grep in file's directory" },
      { key = "<leader>fg", desc = "Grep in workspace" },
    }

    local function show_leader_p_popup()
      local lines = { "<leader>p commands:" }
      for _, cmd in ipairs(leader_p_commands) do
        table.insert(lines, string.format("%s  —  %s", cmd.key, cmd.desc))
      end
      local popup = Popup({
        enter = true,
        focusable = true,
        border = { style = "rounded", text = { top = " <leader>p Menu " } },
        position = "50%",
        size = { width = 50, height = #lines + 2 },
        win_options = { winhighlight = "Normal:Normal,FloatBorder:Normal" },
      })
      popup:mount()
      vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
      popup:on(event.BufLeave, function() popup:unmount() end, { once = true })
      popup:map("n", { "q", "<esc>" }, function() popup:unmount() end, { noremap = true })
    end

    -- Short, vertical, essential command list
    local essential_cmds = {
      dashboard.button("ff", "󰱼  Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("tt", "  Treesitter Commands (<leader>tt)", "<cmd>Telescope commands<CR>"),
      dashboard.button("th", "  Pick Theme (Themify) (<leader>th)", "<cmd>Themify<CR>"),
      dashboard.button("tl", "  Telescope (<leader>tl)", "<cmd>Telescope<CR>"),
      dashboard.button("P", "󰌶  Show <leader>p Menu", function() show_leader_p_popup() end),
    }

    -- Centered layout: Luffy left, commands right, both vertically centered
    dashboard.section.header.val = ascii.art.anime.onepiece.luffy
    dashboard.section.header.opts = { position = "center" }

    dashboard.section.buttons.val = essential_cmds
    dashboard.section.buttons.opts = { position = "center" }

    -- Footer: plugin stats
    local function get_plugin_count()
      local stats = require("lazy").stats()
      return "󱐌 " .. stats.count .. " plugins loaded"
    end
    dashboard.section.footer.val = get_plugin_count()
    dashboard.section.footer.opts.hl = "Comment"
    dashboard.section.footer.opts.position = "center"

    -- Remove extra padding for tighter centering
    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }
    dashboard.config.opts.noautocmd = true

    -- Highlights for transparency and style
    vim.cmd([[highlight default AlphaHeader guifg=#7aa2f7 guibg=NONE]])
    vim.cmd([[highlight default AlphaButtons guifg=#c0caf5 guibg=NONE]])
    vim.cmd([[highlight default AlphaFooter guifg=#565f89 guibg=NONE]])
    vim.cmd([[highlight default Dashboard guibg=NONE]])

    -- Setup alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    
    -- Hide bufferline when alpha is open
    vim.cmd([[autocmd FileType alpha set showtabline=0]])
    
    -- Alpha does not affect tabline; Nougat manages tabline
  end,
}
