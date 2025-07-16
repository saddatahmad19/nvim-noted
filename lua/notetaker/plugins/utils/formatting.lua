return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				markdown = { "prettier" },
			},
			format_on_save = function(bufnr)
				local ft = vim.bo[bufnr].filetype
				if ft == "markdown" then
					return {
						lsp_fallback = false, -- never use LSP for markdown
						async = false,
						timeout_ms = 1000,
						formatters = { "prettier" }, -- always use prettier for markdown
					}
				end
				-- Check for active LSP client for other filetypes
				local clients = vim.lsp.get_clients({ bufnr = bufnr })
				local has_lsp = false
				for _, client in ipairs(clients) do
					if vim.tbl_contains(client.config.filetypes or {}, ft) then
						has_lsp = true
						break
					end
				end
				return {
					lsp_fallback = not has_lsp,
					async = false,
					timeout_ms = 1000,
				}
			end,
		})
	end,
}

-- Default Formatting Keymap:
-- <leader>mp : Format file or range (in visual mode)
