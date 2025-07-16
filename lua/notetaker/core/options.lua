local opt = vim.opt

opt.number = true                -- Show line numbers
opt.relativenumber = true        -- Relative line numbers for navigation
opt.wrap = true                  -- Soft wrap long lines
opt.linebreak = true             -- Wrap at word boundaries
opt.showbreak = '↪ '             -- Visual indicator for wrapped lines
opt.colorcolumn = '200'           -- Highlight column 80 (optional)
opt.signcolumn = 'yes'           -- Always show sign column
opt.scrolloff = 4                -- Keep 4 lines above/below cursor
opt.sidescrolloff = 8            -- Keep 8 columns left/right of cursor
opt.conceallevel = 2             -- Hide markdown formatting
opt.concealcursor = 'nc'         -- Conceal in normal/command mode
opt.list = false                 -- Show invisible chars (set to true if you want)
opt.listchars = {tab = '→ ', trail = '·', extends = '…', precedes = '…'}
opt.spell = true                 -- Enable spell checking
opt.spelllang = 'en_us'          -- Spell check language
opt.textwidth = 200               -- Auto-wrap at 80 chars
opt.formatoptions = 'tqn'        -- Auto-wrap, continue comments, numbered lists
opt.autoindent = true            -- Auto-indent new lines
opt.smartindent = true           -- Smarter auto-indenting
opt.tabstop = 4                  -- 2 spaces per tab
opt.shiftwidth = 4               -- 2 spaces for autoindent
opt.expandtab = true             -- Use spaces instead of tabs
opt.mouse = 'a'                  -- Enable mouse support
opt.cursorline = true            -- Highlight current line
opt.foldmethod = 'marker'        -- Use markers for folding (or 'expr' for markdown)
opt.foldlevel = 99               -- Open all folds by default
opt.ignorecase = true            -- Ignore case in search
opt.smartcase = true             -- ...unless uppercase in search
opt.incsearch = true             -- Incremental search
opt.hlsearch = true              -- Highlight search results
opt.termguicolors = true         -- True color support
opt.background = 'dark'          -- Set to 'light' if you use a light theme
opt.updatetime = 300             -- Faster UI updates
opt.timeoutlen = 500             -- Faster keymap timeout

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 200 -- hard wrap at 200 characters
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.formatoptions:append("t") -- auto-wrap text as you type
  end,
})