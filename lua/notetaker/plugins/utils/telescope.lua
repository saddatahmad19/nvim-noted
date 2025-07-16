return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod
		local builtin = require("telescope.builtin")

		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")

		-- or create your custom action
		local custom_actions = transform_mod({
			open_trouble_qflist = function(prompt_bufnr)
				trouble.toggle("quickfix")
			end,
		})

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				file_ignore_patterns = { -- Ignore these patterns in searches
					"node_modules",
					".git",
					"target",
					"vendor",
					"%.lock",
					"%.pyc",
					"%.pyo",
					"__pycache__",
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						["<C-t>"] = trouble_telescope.open,
						["<C-u>"] = false, -- Clear prompt
						["<C-d>"] = false,
						["<Esc>"] = actions.close, -- Close with single Esc
					},
				},
				-- Improve preview performance
				preview = {
					treesitter = true,
					filesize_limit = 0.1, -- MB
					timeout = 250, -- ms
				},
				-- Better sorting
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
			},
			pickers = {
				find_files = {
					hidden = true, -- Show hidden files
					no_ignore = false, -- Respect .gitignore
					follow = true, -- Follow symlinks
				},
				live_grep = {
					additional_args = function()
						return { "--hidden" } -- Search in hidden files
					end,
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Git files" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>fs", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end,
}
