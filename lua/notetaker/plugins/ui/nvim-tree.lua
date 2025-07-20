return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.opt.termguicolors = true

			-- Add safe treesitter operation wrapper
			local function safe_treesitter_operation(operation, ...)
				local ok, result = pcall(operation, ...)
				if not ok then
					-- Log the error but don't crash nvim-tree
					vim.notify("Treesitter operation failed in nvim-tree: " .. tostring(result), vim.log.levels.WARN)
					return nil
				end
				return result
			end

			local function nvim_tree_on_attach(bufnr)
				local api = require("nvim-tree.api")
				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- Start with nvim-tree defaults
				api.config.mappings.default_on_attach(bufnr)

				-- Optimized vim-like navigation
				vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "l", api.node.open.edit, opts("Expand/Enter"))
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Collapse/Up"))
				vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Go Back Directory"))
				vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up Directory"))
				vim.keymap.set("n", "=", api.tree.change_root_to_node, opts("Change Root"))
				
				-- File operations (resolved conflicts)
				vim.keymap.set("n", "a", api.fs.create, opts("Create File/Directory"))
				vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
				vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
				vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
				vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
				vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
				
				-- Tree control
				vim.keymap.set("n", "q", api.tree.close, opts("Close Tree"))
				vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
				vim.keymap.set("n", "gh", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
				vim.keymap.set("n", "gs", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
				
				-- Simplified bookmarking
				vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
				vim.keymap.set("n", "M", api.marks.bulk.delete, opts("Unmark All"))
				
				-- Bulk operations
				vim.keymap.set("n", "bm", api.marks.bulk.move, opts("Move Marked"))
				vim.keymap.set("n", "bc", api.marks.bulk.move, opts("Copy Marked"))
				vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Delete Marked"))
				
				-- Telescope integration
				vim.keymap.set("n", "tf", function()
					api.tree.close()
					require("telescope.builtin").find_files()
				end, opts("Find Files (Telescope)"))
				vim.keymap.set("n", "tg", function()
					api.tree.close()
					require("telescope.builtin").live_grep()
				end, opts("Live Grep (Telescope)"))
				
				-- Trouble integration
				vim.keymap.set("n", "td", function()
					api.tree.close()
					require("trouble").toggle("document_diagnostics")
				end, opts("Document Diagnostics (Trouble)"))
				vim.keymap.set("n", "tw", function()
					api.tree.close()
					require("trouble").toggle("workspace_diagnostics")
				end, opts("Workspace Diagnostics (Trouble)"))
				
				-- Markdown special handling
				vim.keymap.set("n", "gm", function()
					local node = api.tree.get_node_under_cursor()
					if node and node.name:match("%.md$") then
						api.node.open.edit()
						-- Could add markdown-specific actions here
					else
						api.node.open.edit()
					end
				end, opts("Open (Markdown-aware)"))
			end

			require("nvim-tree").setup({
				-- Core behavior
				on_attach = nvim_tree_on_attach,
				hijack_cursor = false,
				auto_reload_on_write = true,
				disable_netrw = true,
				hijack_netrw = true,
				hijack_unnamed_buffer_when_opening = false,
				root_dirs = {},
				prefer_startup_root = true,
				sync_root_with_cwd = true,
				reload_on_bufenter = false,
				respect_buf_cwd = true,
				select_prompts = false,
				
				-- Sorting
				sort = {
					sorter = "name",
					folders_first = true,
					files_first = false,
				},
				
				-- View configuration
				view = {
					centralize_selection = false,
					cursorline = true,
					cursorlineopt = "both",
					debounce_delay = 15,
					side = "left",
					preserve_window_proportions = false,
					number = false,
					relativenumber = false,
					signcolumn = "yes",
					width = 35, -- Optimal size for readability
					float = {
						enable = false,
						quit_on_focus_loss = true,
						open_win_config = {
							relative = "editor",
							border = "rounded",
							width = 30,
							height = 30,
							row = 1,
							col = 1,
						},
					},
				},
				
				-- Renderer configuration for maximum aesthetics
				renderer = {
					add_trailing = false,
					group_empty = false, -- Show empty folders individually
					full_name = false,
					root_folder_label = ":~:s?$?/..?",
					indent_width = 2,
					special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "package.json", "go.mod", "pyproject.toml" },
					hidden_display = "none",
					symlink_destination = true,
					
					-- Decorators for visual enhancement
					decorators = { 
						"Git", 
						"Open", 
						"Hidden", 
						"Modified", 
						"Bookmark", 
						"Diagnostics", 
						"Copied", 
						"Cut" 
					},
					
					-- Highlighting configuration
					highlight_git = "all",
					highlight_diagnostics = "all",
					highlight_opened_files = "all",
					highlight_modified = "all",
					highlight_hidden = "none",
					highlight_bookmarks = "all",
					highlight_clipboard = "name",
					
					-- Indent markers for better visual hierarchy
					indent_markers = {
						enable = true,
						inline_arrows = true,
						icons = {
							corner = "└",
							edge = "│",
							item = "│",
							bottom = "─",
							none = " ",
						},
					},
					
					-- Icon configuration for maximum aesthetics
					icons = {
						web_devicons = {
							file = {
								enable = true,
								color = true,
							},
							folder = {
								enable = true,
								color = true,
							},
						},
						git_placement = "before",
						modified_placement = "after",
						hidden_placement = "after",
						diagnostics_placement = "signcolumn",
						bookmarks_placement = "signcolumn",
						padding = {
							icon = " ",
							folder_arrow = " ",
						},
						symlink_arrow = " ➛ ",
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
							modified = true,
							hidden = false,
							diagnostics = true,
							bookmarks = true,
						},
						glyphs = {
							default = "󰈚",
							symlink = "󰉒",
							bookmark = "󰆤",
							modified = "●",
							hidden = "󰜌",
							folder = {
								arrow_closed = "󰉋",
								arrow_open = "󰉋",
								default = "󰉋",
								open = "󰉋",
								empty = "󰉋",
								empty_open = "󰉋",
								symlink = "󰉒",
								symlink_open = "󰉒",
							},
							git = {
								unstaged = "󰄱",
								staged = "󰄱",
								unmerged = "󰘬",
								renamed = "󰁴",
								untracked = "󰈔",
								deleted = "󰩺",
								ignored = "󰈝",
							},
						},
					},
				},
				
				-- Hijack directories for better integration
				hijack_directories = {
					enable = true,
					auto_open = true,
				},
				
				-- Update focused file
				update_focused_file = {
					enable = true,
					update_root = {
						enable = true,
						ignore_list = {},
					},
					exclude = false,
				},
				
				-- System open integration
				system_open = {
					cmd = "",
					args = {},
				},
				
				-- Git integration (only when in git repo)
				git = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
					disable_for_dirs = {},
					timeout = 400,
					cygwin_support = false,
				},
				
				-- Diagnostics integration
				diagnostics = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
					debounce_delay = 500,
					severity = {
						min = vim.diagnostic.severity.HINT,
						max = vim.diagnostic.severity.ERROR,
					},
					icons = {
						hint = "󰌵",
						info = "󰋼",
						warning = "󰅚",
						error = "󰅚",
					},
				},
				
				-- Modified file indicators
				modified = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
				},
				
				-- Filters
				filters = {
					enable = true,
					git_ignored = true,
					dotfiles = false, -- Show dotfiles by default
					git_clean = false,
					no_buffer = false,
					no_bookmark = false,
					custom = {},
					exclude = {},
				},
				
				-- Live filter
				live_filter = {
					prefix = "[FILTER]: ",
					always_show_folders = true,
				},
				
				-- Filesystem watchers (optimized for performance)
				filesystem_watchers = {
					enable = true,
					debounce_delay = 50,
					ignore_dirs = {
						"/.ccls-cache",
						"/build",
						"/node_modules",
						"/target",
						"/.git",
						"/.cache",
						"/tmp",
					},
				},
				
				-- Actions configuration
				actions = {
					use_system_clipboard = true,
					change_dir = {
						enable = true,
						global = false,
						restrict_above_cwd = false,
					},
					expand_all = {
						max_folder_discovery = 300,
						exclude = {},
					},
					file_popup = {
						open_win_config = {
							col = 1,
							row = 1,
							relative = "cursor",
							border = "shadow",
							style = "minimal",
						},
					},
					open_file = {
						quit_on_open = true, -- Close tree when file is opened
						eject = true,
						resize_window = true,
						relative_path = true,
						window_picker = {
							enable = true,
							picker = "default",
							chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
							exclude = {
								filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
								buftype = { "nofile", "terminal", "help" },
							},
						},
					},
					remove_file = {
						close_window = true,
					},
				},
				
				-- Trash configuration
				trash = {
					cmd = "gio trash",
				},
				
				-- Tab synchronization
				tab = {
					sync = {
						open = false,
						close = false,
						ignore = {},
					},
				},
				
				-- Notify configuration
				notify = {
					threshold = vim.log.levels.INFO,
					absolute_path = true,
				},
				
				-- Help configuration
				help = {
					sort_by = "key",
				},
				
				-- UI confirmations
				ui = {
					confirm = {
						remove = true,
						trash = true,
						default_yes = false,
					},
				},
				
				-- Experimental features
				experimental = {
					multi_instance = false,
				},
				
				-- Logging (disabled for performance)
				log = {
					enable = false,
					truncate = false,
					types = {
						all = false,
						config = false,
						copy_paste = false,
						dev = false,
						diagnostics = false,
						git = false,
						profile = false,
						watcher = false,
					},
				},
			})

			-- Set a custom statusline for NvimTree buffers
			local autocmd = vim.api.nvim_create_autocmd
			autocmd("FileType", {
				pattern = "NvimTree",
				callback = function()
					vim.opt_local.statusline = " 󰉋 NvimTree "
				end,
			})

			-- Add autocmd to handle treesitter errors when opening nvim-tree
			autocmd("User", {
				pattern = "NvimTreeOpen",
				callback = function()
					-- Handle any treesitter errors when opening nvim-tree
					safe_treesitter_operation(function()
						-- Any treesitter operations here will be wrapped in error handling
						return true
					end)
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