return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.opt.termguicolors = true

			local function nvim_tree_on_attach(bufnr)
				local api = require("nvim-tree.api")
				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- Start with nvim-tree defaults
				api.config.mappings.default_on_attach(bufnr)

				-- Netrw-like keymaps (override or add as needed)
				vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "l", api.node.open.edit, opts("Expand/Enter"))
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Collapse/Up"))
				vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up Directory"))
				vim.keymap.set("n", "%", api.fs.create, opts("Create File"))
				vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
				vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
				vim.keymap.set("n", "q", api.tree.close, opts("Close Tree"))
				vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
				vim.keymap.set("n", "yy", api.fs.copy.node, opts("Copy"))
				vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
				vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
				vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy (again)"))
				vim.keymap.set("n", "m", api.marks.toggle, opts("Mark/Unmark"))
				vim.keymap.set("n", "J", function() api.marks.toggle(); vim.cmd("norm j") end, opts("Mark Down"))
				vim.keymap.set("n", "K", function() api.marks.toggle(); vim.cmd("norm k") end, opts("Mark Up"))
			end

			require("nvim-tree").setup({
				sort = { sorter = "name" },
				view = { width = 30 },
				renderer = { group_empty = true },
				filters = { dotfiles = false },
				on_attach = nvim_tree_on_attach,
			})

			-- Set a custom statusline for NvimTree buffers
			local autocmd = vim.api.nvim_create_autocmd
			autocmd("FileType", {
				pattern = "NvimTree",
				callback = function()
					vim.opt_local.statusline = " NvimTree "
				end,
			})
		end,
	},
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = true,
	},
}
