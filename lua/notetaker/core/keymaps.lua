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

-- Tab Management Keybindings
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>t]", ":tabnext<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>t[", ":tabprevious<CR>", { desc = "Go to previous tab" })

-- Tab menu with telescope
vim.keymap.set("n", "<leader>tm", function()
  local tabs = {}
  for i = 1, vim.fn.tabpagenr('$') do
    local tab_name = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
    local buf_name = vim.fn.bufname(tab_name)
    local display_name = buf_name ~= "" and vim.fn.fnamemodify(buf_name, ":t") or "[No Name]"
    table.insert(tabs, { tab = i, name = display_name })
  end
  
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  
  pickers.new({}, {
    prompt_title = "Select Tab",
    finder = finders.new_table({
      results = tabs,
      entry_maker = function(entry)
        return {
          value = entry.tab,
          display = string.format("%d: %s", entry.tab, entry.name),
          ordinal = string.format("%d: %s", entry.tab, entry.name),
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd("tabn " .. selection.value)
      end)
      return true
    end,
  }):find()
end, { desc = "Open tab menu" })

-- Tab selection by number
vim.keymap.set("n", "<leader>t#", function()
  local input = vim.fn.input("Tab number: ")
  local tab_num = tonumber(input)
  if tab_num then
    local total_tabs = vim.fn.tabpagenr('$')
    -- Handle edge cases
    if tab_num <= 0 then
      tab_num = 1
    elseif tab_num > total_tabs then
      tab_num = total_tabs
    end
    vim.cmd("tabn " .. tab_num)
  end
end, { desc = "Go to tab by number" })

-- Close current tab
vim.keymap.set("n", "<leader>tw", ":tabclose<CR>", { desc = "Close current tab" })

-- Close all tabs except current
vim.keymap.set("n", "<leader>tx", function()
  local current_tab = vim.fn.tabpagenr()
  local total_tabs = vim.fn.tabpagenr('$')
  
  for i = total_tabs, 1, -1 do
    if i ~= current_tab then
      vim.cmd("tabclose " .. i)
    end
  end
end, { desc = "Close all tabs except current" })

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

-- Treesitter: Open command list via Telescope
vim.keymap.set("n", "<leader>tt", ":Telescope commands<CR>", { desc = "Open Treesitter Commands via Telescope" })

-- Themify: Open theme picker
vim.keymap.set("n", "<leader>th", ":Themify<CR>", { desc = "Open Themify Theme Picker" })

-- Telescope: Open main picker
vim.keymap.set("n", "<leader>tl", ":Telescope<CR>", { desc = "Open Telescope Command Palette" })

