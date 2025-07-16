return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      local wk = require("which-key")
      wk.register({
        ["<leader>b"] = {
          name = "+buffer",
          l = { "<cmd>Telescope buffers<cr>", "List Buffers" },
          n = { "<cmd>enew<cr>", "New Buffer" },
          d = { "<cmd>bdelete<cr>", "Delete Buffer" },
          p = { "<cmd>bprevious<cr>", "Previous Buffer" },
          N = { "<cmd>bnext<cr>", "Next Buffer" },
          f = { "<cmd>Telescope find_files<cr>", "Find File" },
          s = { "<cmd>Telescope live_grep<cr>", "Search in Files" },
          -- D = { nil, "Delete by Number" },
          -- o = { nil, "Close Other Buffers" },
        },
      }, { mode = "n" })
    end,
  },
} 