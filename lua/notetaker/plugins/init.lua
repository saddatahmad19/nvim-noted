vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"nvim-tree/nvim-web-devicons", -- icons for nvim-tree and other plugins
	{ import = "notetaker.plugins.ui.nvim-tree" },
	{ import = "notetaker.plugins.ui.bufferline" },
	{
		"grapp-dev/nui-components.nvim",
		dependencies = { "MunifTanjim/nui.nvim" }
	}
}

