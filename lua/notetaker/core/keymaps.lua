-- Set leader
vim.g.mapleader = " "

-- nvim-tree (when focused):
--   %   : New file
--   d   : New directory
--   D   : Delete file/dir
--   m   : Mark/unmark
--   J/K : Mark and move down/up
--   yy  : Copy marked
--   dd  : Cut marked
--   p   : Paste
--   df  : Trash marked
--   dF  : Remove marked
--   R   : Rename
--   S   : Cycle sort (name/time/size)

-- nvim-tree keymaps
vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle nvim-tree (alt)" })

-- <leader>f prefix mapping for nvim-tree and related actions
vim.keymap.set('n', '<leader>ff', function()
  vim.cmd('NvimTreeToggle')
end, { noremap = true, desc = 'Toggle nvim-tree (<leader>ff)' })

vim.keymap.set('n', '<leader>fl', function()
  vim.cmd('wincmd p')
end, { noremap = true, desc = 'Focus editor from tree (<leader>fl)' })

vim.keymap.set('n', '<leader>fh', function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
    if ft == 'NvimTree' then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
end, { noremap = true, desc = 'Focus tree from editor (<leader>fh)' })

-- Open file explorer at file's directory
vim.keymap.set("n", "<leader>pf", function()
  local path = vim.fn.expand('%:p:h')
  vim.cmd('NvimTreeOpen ' .. path)
end, { desc = "Open file explorer at file's directory" })

-- Grep in file's directory
vim.keymap.set("n", "<leader>fs", function()
  local path = vim.fn.expand('%:p:h')
  require('telescope.builtin').live_grep({ search_dirs = { path } })
end, { desc = "Grep in file's directory" })

-- Grep in workspace
vim.keymap.set("n", "<leader>fg", function()
  require('telescope.builtin').live_grep()
end, { desc = "Grep in workspace" })

-- Treesitter Incremental Selection
vim.keymap.set("n", "gn", function() vim.cmd('normal! gn') end, { desc = "Start Treesitter selection" })
vim.keymap.set("n", "grn", function() vim.cmd('normal! grn') end, { desc = "Expand Treesitter node" })
vim.keymap.set("n", "grm", function() vim.cmd('normal! grm') end, { desc = "Shrink Treesitter node" })
vim.keymap.set("n", "grc", function() vim.cmd('normal! grc') end, { desc = "Expand Treesitter scope" })

-- Treesitter Playground
vim.keymap.set("n", "<leader>ts", ":TSPlaygroundToggle<CR>", { desc = "Toggle Treesitter Playground" })

-- Formatting (from formatting.lua)
vim.keymap.set({"n", "v"}, "<leader>mp", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file or range (in visual mode)" })

-- Format and Save: <leader>ps
vim.keymap.set("n", "<leader>ps", function()
  local ok, conform = pcall(require, "conform")
  if not ok then
    vim.notify("conform.nvim is not loaded!", vim.log.levels.ERROR)
    return
  end
  local ft = vim.bo.filetype
  if ft == "markdown" then
    -- Use LSP if available, fallback to prettier
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    local has_lsp = false
    for _, client in ipairs(clients) do
      if vim.tbl_contains(client.config.filetypes or {}, "markdown") then
        has_lsp = true
        break
      end
    end
    conform.format({
      lsp_fallback = not has_lsp,
      async = false,
      timeout_ms = 1000,
    })
  else
    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    })
  end
  vim.cmd("w")
end, { desc = "Format and Save file (markdown: LSP if available, else prettier)" })

-- <leader>b buffer commands
vim.keymap.set("n", "<leader>bN", ":bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bf", ":Telescope find_files<CR>", { desc = "Find File" })
vim.keymap.set("n", "<leader>bl", ":Telescope buffers<CR>", { desc = "List Buffers" })
vim.keymap.set("n", "<leader>bn", ":enew<CR>", { desc = "New Buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bs", ":Telescope live_grep<CR>", { desc = "Search in Files" })

-- -- Buffer: Delete by Number
-- vim.keymap.set("n", "<leader>bD", function()
--   local bufnr = vim.fn.input('Buffer #: ')
--   vim.cmd('bdelete ' .. bufnr)
-- end, { desc = "Delete by Number" })

-- Buffer: Close Other Buffers
-- vim.keymap.set("n", "<leader>bo", function()
--   local current = vim.api.nvim_get_current_buf()
--   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--     if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
--       vim.cmd('bdelete ' .. buf)
--     end
--   end
-- end, { desc = "Close Other Buffers" })

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", '"+yy', { desc = "Yank entire line to system clipboard" })

vim.keymap.set("x", "<leader>p", [["_dP]])

