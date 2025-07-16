return {
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        require("tokyonight").setup({
          style = "storm",
          transparent = false,
          styles = {
            sidebars = "dark",
            floats = "dark",
          },
          on_colors = function(colors)
            colors.bg = "#1a1b26"
            colors.bg_dark = "#16161e"
            colors.bg_float = "#16161e"
            colors.bg_highlight = "#292e42"
            colors.bg_popup = "#16161e"
            colors.bg_search = "#3d59a1"
            colors.bg_visual = "#2e3c64"
            colors.border = "#7aa2f7"
            colors.terminal_black = "#414868"
            colors.fg = "#c0caf5"
            colors.fg_dark = "#a9b1d6"
            colors.fg_gutter = "#3b4261"
            colors.fg_sidebar = "#a9b1d6"
            colors.comment = "#565f89"
            colors.blue = "#7aa2f7"
            colors.cyan = "#7dcfff"
            colors.blue1 = "#2ac3de"
            colors.blue2 = "#0db9d7"
            colors.blue5 = "#89ddff"
            colors.blue6 = "#b4f9f8"
            colors.magenta = "#bb9af7"
            colors.magenta2 = "#ff007c"
            colors.purple = "#9d7cd8"
            colors.orange = "#ff9e64"
            colors.yellow = "#e0af68"
            colors.green = "#9ece6a"
            colors.green1 = "#73daca"
            colors.green2 = "#41a6b5"
            colors.teal = "#1abc9c"
            colors.red = "#f7768e"
            colors.red1 = "#db4b4b"
          end,
          on_highlights = function(hl, c)
            hl.CursorLine = { bg = "#1f2335" }
            hl.LineNr = { fg = "#3b4261" }
            hl.CursorLineNr = { fg = "#737aa2" }
          end,
        })
  
        -- Set Tokyo Night as the default theme
        vim.cmd.colorscheme("tokyonight-storm")
      end,
    },
}