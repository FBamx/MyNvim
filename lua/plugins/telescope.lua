local Util = require("util")
return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		dependencies = {
			{ "nvim-telescope/telescope-dap.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-project.nvim" },
			{ "debugloop/telescope-undo.nvim" },
			{ "xiyaowong/telescope-emoji.nvim" },
			{ "LinArcX/telescope-env.nvim" },
			{ "LinArcX/telescope-ports.nvim" },
		},
		opts = {
			defaults = {
				prompt_prefix = "   ",
				selection_caret = " ",
				layout_strategy = "horizontal",
				layout_config = {
					vertical = {
						preview_cutoff = 0.2,
						preview_height = 0.4,
					},
					height = 0.9,
					width = 0.9,
				},
				mappings = {
					i = {
						["<C-j>"] = function(...)
							return require("telescope.actions").move_selection_next(...)
						end,
						["<C-k>"] = function(...)
							return require("telescope.actions").move_selection_previous(...)
						end,
						["<C-p>"] = function(...)
							return require("telescope.actions.layout").toggle_preview(...)
						end,
					},
					n = {
						["j"] = function(...)
							return require("telescope.actions").move_selection_next(...)
						end,
						["k"] = function(...)
							return require("telescope.actions").move_selection_previous(...)
						end,
						["gg"] = function(...)
							return require("telescope.actions").move_to_top(...)
						end,
						["G"] = function(...)
							return require("telescope.actions").move_to_bottom(...)
						end,
						["<C-p>"] = function(...)
							return require("telescope.actions.layout").toggle_preview(...)
						end,
					},
				},
			},
			extensions = {
				project = {
					base_dirs = {
						"~/workspace/",
					},
				},
				undo = {
					use_delta = true,
					side_by_side = true,
					layout_strategy = "vertical",
					layout_config = {
						preview_height = 0.4,
					},
				},
			},
		},
		keys = {
			{ "<leader>fp", "<CMD>Telescope project display_type=full<CR>", desc = "Find project" },
			{ "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
			{ "<leader>mo", "<Cmd>Telescope emoji<CR>", desc = "emoji" },
			{ "<leader>nv", "<Cmd>Telescope env<CR>", desc = "env" },
			{ "<leader>po", "<Cmd>Telescope ports<CR>", desc = "ports" },
			{ "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
			{ "<leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)" },
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
			-- find
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
			{ "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			{ "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
			-- git
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
			-- search
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
			{ "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
			{ "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
			{ "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{ "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
			{ "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
			{
				"<leader>uC",
				Util.telescope("colorscheme", { enable_preview = true }),
				desc = "Colorscheme with preview",
			},
			{
				"<leader>ss",
				Util.telescope("lsp_document_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol",
			},
			{
				"<leader>sS",
				Util.telescope("lsp_dynamic_workspace_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol (Workspace)",
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			-- telescope.load_extension("dap")
			telescope.load_extension("fzf")
			telescope.load_extension("project")
			telescope.load_extension("undo")
			telescope.load_extension("emoji")
			telescope.load_extension("env")
			telescope.load_extension("ports")
		end,
	},

	-- neocilp
	{
		"telescope.nvim",
		dependencies = {
			-- project management
			{
				"AckslD/nvim-neoclip.lua",
				lazy = false,
				opts = {},
				config = function(_, opts)
					require("neoclip").setup(opts)
					require("telescope").load_extension("neoclip")
				end,
				keys = {
					{ "<leader>fy", "<Cmd>Telescope neoclip<CR>", desc = "neoclip" },
				},
			},
		},
	},
}
