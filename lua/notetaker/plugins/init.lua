vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	{ import = "notetaker.plugins.ui.nvim-tree" },
	{
		"grapp-dev/nui-components.nvim",
		dependencies = { "MunifTanjim/nui.nvim" }
	}
}

