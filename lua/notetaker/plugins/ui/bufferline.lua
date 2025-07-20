return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local bufferline = require("bufferline")
		
		bufferline.setup({
			options = {
				-- Core behavior
				mode = "buffers", -- "buffers" | "tabs"
				separator_style = "slant", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
				always_show_bufferline = true,
				show_buffer_close_icons = true,
				show_close_icon = false,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				show_buffer_icons = true,
				show_tab_icons = true,
				show_close_icon = false,
				show_buffer_close_icons = true,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				show_buffer_icons = true,
				show_tab_icons = true,
				
				-- Tab management
				enforce_regular_tabs = false,
				view = "multiwindow",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diag)
					local icons = require("notetaker.core.icons").diagnostics
					local ret = {}
					for severity, icon in pairs(icons) do
						local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[string.upper(severity)] })
						if n > 0 then
							table.insert(ret, icon .. " " .. n)
						end
					end
					return table.concat(ret, " ")
				end,
				
				-- Styling
				highlights = {
					fill = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					background = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					tab = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					tab_selected = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLine" },
					},
					tab_close = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					close_button = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					close_button_visible = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					close_button_selected = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLine" },
					},
					buffer_visible = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					buffer_selected = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLine" },
						bold = true,
						italic = false,
					},
					numbers = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					numbers_visible = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					numbers_selected = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLine" },
						bold = true,
						italic = false,
					},
					diagnostic = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					diagnostic_visible = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					diagnostic_selected = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLine" },
						bold = true,
						italic = false,
					},
					duplicate = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					duplicate_visible = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					duplicate_selected = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLine" },
						bold = true,
						italic = false,
					},
					separator = {
						fg = { attribute = "bg", highlight = "StatusLineNC" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					separator_visible = {
						fg = { attribute = "bg", highlight = "StatusLineNC" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					separator_selected = {
						fg = { attribute = "bg", highlight = "StatusLine" },
						bg = { attribute = "bg", highlight = "StatusLine" },
					},
					indicator_selected = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultError" },
						bg = { attribute = "bg", highlight = "StatusLine" },
					},
					modified = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					modified_visible = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					modified_selected = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLine" },
					},
					pick = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					pick_visible = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					pick_selected = {
						fg = { attribute = "fg", highlight = "Normal" },
						bg = { attribute = "bg", highlight = "StatusLine" },
					},
					error = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultError" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					error_visible = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultError" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					error_selected = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultError" },
						bg = { attribute = "bg", highlight = "StatusLine" },
						bold = true,
						italic = false,
					},
					error_diagnostic = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultError" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					error_diagnostic_visible = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultError" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					error_diagnostic_selected = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultError" },
						bg = { attribute = "bg", highlight = "StatusLine" },
						bold = true,
						italic = false,
					},
					warning = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultWarning" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					warning_visible = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultWarning" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					warning_selected = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultWarning" },
						bg = { attribute = "bg", highlight = "StatusLine" },
						bold = true,
						italic = false,
					},
					warning_diagnostic = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultWarning" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					warning_diagnostic_visible = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultWarning" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					warning_diagnostic_selected = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultWarning" },
						bg = { attribute = "bg", highlight = "StatusLine" },
						bold = true,
						italic = false,
					},
					info = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultInformation" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					info_visible = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultInformation" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					info_selected = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultInformation" },
						bg = { attribute = "bg", highlight = "StatusLine" },
						bold = true,
						italic = false,
					},
					info_diagnostic = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultInformation" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					info_diagnostic_visible = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultInformation" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					info_diagnostic_selected = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultInformation" },
						bg = { attribute = "bg", highlight = "StatusLine" },
						bold = true,
						italic = false,
					},
					hint = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultHint" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					hint_visible = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultHint" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					hint_selected = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultHint" },
						bg = { attribute = "bg", highlight = "StatusLine" },
						bold = true,
						italic = false,
					},
					hint_diagnostic = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultHint" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					hint_diagnostic_visible = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultHint" },
						bg = { attribute = "bg", highlight = "StatusLineNC" },
					},
					hint_diagnostic_selected = {
						fg = { attribute = "fg", highlight = "LspDiagnosticDefaultHint" },
						bg = { attribute = "bg", highlight = "StatusLine" },
						bold = true,
						italic = false,
					},
				},
				
				-- Tab configuration
				tab_size = 18,
				max_name_length = 18,
				max_prefix_length = 15,
				tab_style = "slant",
				enforce_regular_tabs = false,
				view = "multiwindow",
				
				-- Close behavior
				close_command = "bdelete! %d",
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				middle_mouse_command = nil,
				
				-- Indicators
				indicator = {
					icon = "▎",
					style = "icon",
				},
				
				-- Offsets
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				
				-- Numbers
				numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function
				
				-- Sort
				sort_by = "insert_after_current", -- "insert_at_end" | "insert_after_current" | "id" | "extension" | "relative_directory" | "directory" | "tabs" | function
			},
		})
		
		-- Hide bufferline when alpha is open
		local autocmd = vim.api.nvim_create_autocmd
		autocmd("FileType", {
			pattern = "alpha",
			callback = function()
				vim.opt.showtabline = 0
			end,
		})
		
		autocmd("FileType", {
			pattern = { "alpha" },
			callback = function()
				vim.opt.showtabline = 0
			end,
		})
		
		-- Show bufferline for other filetypes
		autocmd("FileType", {
			pattern = { "*" },
			callback = function()
				if vim.bo.filetype ~= "alpha" then
					vim.opt.showtabline = 2
				end
			end,
		})
	end,
} 