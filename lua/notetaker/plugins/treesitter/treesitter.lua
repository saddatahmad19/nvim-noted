return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "markdown", "markdown_inline", "csv", "lua", "vim", "bash", "json", "yaml"
        },
        highlight = { enable = true },
        incremental_selection = { enable = true },
        -- rainbow = { enable = true, extended_mode = true }, -- Removed, handled by rainbow-delimiters.nvim
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
  -- { import = "notetaker.plugins.treesitter.buffer" }, -- Removed because the module does not exist
}

-- Default Treesitter Keymaps (may require manual setup in your config):
-- Incremental selection:
--   init_selection    : gn
--   node_incremental  : grn
--   node_decremental  : grm
--   scope_incremental : grc
-- Rainbow parentheses: (no default keymap, enabled automatically) 