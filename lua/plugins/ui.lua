return {

	-- bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		},
		opts = {
			options = {
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("config.icons").diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},

	-- statusline
	-- {
	--   "nvim-lualine/lualine.nvim",
	--   event = "VeryLazy",
	--   opts = function()
	--     local icons = require("config.icons")
	--     local Util = require("util")
	--
	--     return {
	--       options = {
	--         theme = "auto",
	--         globalstatus = true,
	--         disabled_filetypes = { statusline = { "dashboard", "alpha" } },
	--       },
	--       sections = {
	--         lualine_a = { "mode" },
	--         lualine_b = { "branch" },
	--         lualine_c = {
	--           {
	--             "diagnostics",
	--             symbols = {
	--               error = icons.diagnostics.Error,
	--               warn = icons.diagnostics.Warn,
	--               info = icons.diagnostics.Info,
	--               hint = icons.diagnostics.Hint,
	--             },
	--           },
	--           {
	--             "filetype",
	--             icon_only = true,
	--             separator = "",
	--             padding = {
	--               left = 1,
	--               right = 0,
	--             },
	--           },
	--           { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
	--           -- stylua: ignore
	--           {
	--             function() return require("nvim-navic").get_location() end,
	--             cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
	--           },
	--         },
	--         lualine_x = {
	--           -- stylua: ignore
	--           {
	--             function() return require("noice").api.status.command.get() end,
	--             cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
	--             color = Util.fg("Statement"),
	--           },
	--           -- stylua: ignore
	--           {
	--             function() return require("noice").api.status.mode.get() end,
	--             cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
	--             color = Util.fg("Constant"),
	--           },
	--           -- stylua: ignore
	--           {
	--             function() return "  " .. require("dap").status() end,
	--             cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
	--             color = Util.fg("Debug"),
	--           },
	--           {
	--             require("lazy.status").updates,
	--             cond = require("lazy.status").has_updates,
	--             color = Util.fg("Special"),
	--           },
	--           {
	--             "diff",
	--             symbols = {
	--               added = icons.git.added,
	--               modified = icons.git.modified,
	--               removed = icons.git.removed,
	--             },
	--           },
	--         },
	--         lualine_y = {
	--           { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
	--           { "location", padding = { left = 0, right = 1 } },
	--         },
	--         lualine_z = {
	--           function()
	--             return " " .. os.date("%R")
	--           end,
	--         },
	--       },
	--       extensions = { "neo-tree", "lazy" },
	--     }
	--   end,
	-- },

	-- noicer ui
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- which key integration
			{
				"folke/which-key.nvim",
				opts = function(_, opts)
					if require("util").has("noice.nvim") then
						opts.defaults["<leader>sn"] = { name = "+noice" }
					end
				end,
			},
		},
		opts = {
			lsp = {
				progress = {
					enabled = false,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				-- bottom_search = true,
				-- command_palette = true,
				long_message_to_split = true,
			},
		},
    -- stylua: ignore
    keys = {
      {
        "<S-Enter>",
        function() require("noice").redirect(vim.fn.getcmdline()) end,
        mode = "c",
        desc =
        "Redirect Cmdline"
      },
      {
        "<leader>snl",
        function() require("noice").cmd("last") end,
        desc =
        "Noice Last Message"
      },
      {
        "<leader>snh",
        function() require("noice").cmd("history") end,
        desc =
        "Noice History"
      },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      {
        "<leader>snd",
        function() require("noice").cmd("dismiss") end,
        desc =
        "Dismiss All"
      },
      {
        "<c-f>",
        function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
        silent = true,
        expr = true,
        desc =
        "Scroll forward",
        mode = {
          "i", "n", "s" }
      },
      {
        "<c-b>",
        function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
        silent = true,
        expr = true,
        desc =
        "Scroll backward",
        mode = {
          "i", "n", "s" }
      },
    },
	},

	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- char = "▏",
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},

	-- active indent guide and indent text objects
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},

	-- colorizer
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- notify
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			background_colour = "#000000",
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			-- when noice is not enabled, install notify on VeryLazy
			local Util = require("util")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
	},

	-- better vim.ui
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣧⠞⢻⡅⠀⠀⢀⣷⡆⠈⡙⢶⡄⠐⠂⠀⠒⠂⠀⠈⠉⠉⠉⡍⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢫⡞⠁⣰⣿⣿⣄⣼⣿⡛⣷⠀⠈⠈⣷⡄⢀⣩⡐⠶⣄⡀⠂⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡟⠀⣸⣿⠛⣿⣿⡿⠛⡇⢸⣆⠀⠀⢸⣿⠰⠤⠜⠳⠁⢶⡄⠂⠀⠆⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⣿⠀⣰⣿⡟⠀⠘⠟⠀⠀⢿⡌⢻⣆⠀⣾⣋⣸⠶⠀⣤⣀⣒⣠⡐⢀⠀⠀⡤⡀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⡀⣿⡀⣿⣿⠃⠀⠀⠀⠀⠀⠘⣷⡾⠋⣴⡟⣮⣽⡛⢩⡉⢡⡽⢂⠓⠈⠀⣀⠠⢉⡀⠉⠀⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠘⠂⠛⢧⣌⣃⣀⣀⣀⣀⣀⣀⣀⠉⣀⣼⣿⣶⣭⠆⣡⢈⡁⡄⣴⡛⠀⠀⠀⠥⠂⠨⡽⣦⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣭⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣭⣭⣉⠉⠉⠉⠉⠛⠿⣷⣮⣉⠉⣈⠙⠯⠹⠊⠀⠿⠴⠀⠈⠛⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⡿⣫⣾⢿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣀⠀⠀⠈⠙⠿⣷⣜⣊⡹⡗⣟⠐⠀⠸⠶⠄⠁⠀⠀⠀⣀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠙⠿⣿⣇⠛⢶⡆⡀⠀⠻⠄⠀⠀⠀⠈⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⠛⠉⠉⠁⠀⠀⠀⠀⠀⠀⢉⣭⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⠀⠈⠻⢿⣭⣙⣧⣜⣀⡠⢈⠀⠀⠀⠀⠈⢷⠻⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⡍⠛⠿⢷⣶⣄⡀⠙⢿⣿⣮⣁⡰⠀⡌⠐⠀⠀⠀⠁⠀⠈⠟⢿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠋⠻⣿⣷⠀⠀⠀⠀⠀⠀⠠⣼⣿⡿⠋⠉⠀⠀⠈⠙⢿⣿⣇⠀⠀⠀⠉⠛⢿⣶⣄⠙⠷⣿⣿⣞⠓⢖⡀⠄⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠈⣋⢻⡂⠀⠀⠀⠀⠀⠠⠟⠁⠀⣀⣀⣀⡀⠀⠀⠙⠿⠿⠄⠀⠀⠀⠀⠀⠉⠻⣿⣾⣟⣹⣿⣷⣿⣟⣋⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⡴⢋⣋⣛⡆⠀⠀⠀⠀⠀⠀⢀⣴⣟⣁⡀⠀⠉⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣻⣿⣜⣉⣉⠀⠀⢀⠛⡄⠀⠀⢸⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⠁⣾⣯⣽⣿⡆⠀⠀⠀⠀⠀⣾⣿⣿⡿⢻⣆⠀⠀⠹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣽⣿⣿⡖⣢⣄⠀⠁⠀⠀⢸⣿
⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⠿⠛⠋⠀⠘⠘⠻⠻⡻⣿⡁⠀⠀⠀⠀⢰⣿⣿⣍⣿⡆⢹⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣯⣩⣿⣿⣿⣿⣿⣿⣾⡇⡉⠁⠂⠀⠀⣾⣿
⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⣼⢻⣿⣿⣿⠇⢸⠀⠀⠀⣧⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⢛⡿⣿⣿⣿⣿⢿⣿⠿⠟⠛⠛⠷⠶⣦⣄⣸⣿⣿
⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⡜⠿⠿⠟⢠⡞⠀⠀⢰⢣⡀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣴⣠⣸⡿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿
⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢟⣲⠤⠖⠋⠀⠀⣄⣫⣼⣷⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⢻⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿
⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣈⣁⣤⣤⣶⣾⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢹⣿⠙⢳⣺⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿
⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣽
⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣤⣤⣤⣤⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣷⡉⠉⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠻⢿⣿⠿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣧⡀⠀⠀⠀⠀⠀⣀⣴⣾⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣼⢿⣷⠀⠀⠀⠉⠙⠯⣅⣉⣙⣛⣋⣉⣀⣀⣠⠤⠖⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣷⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡶⠛⣦⣀⣀⣀⣀⣀⣀⣀⣠⡤⠶⠶⠖⣛⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⡿⢠⣾⠛⠋⠙⠋⢻⣿⡀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⡿⢇⠟⠁⠀⠀⠀⢠⣴⢿⡇⢀⣠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
      ]]
			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},

	--smoothCursor
	{
		"gen740/SmoothCursor.nvim",
		lazy = false,
		opts = {
			autostart = true,
			cursor = "",
			texthl = "SmoothCursor",
			linehl = nil,
			type = "default",
			fancy = {
				enable = true,
				head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
				body = {
					{ cursor = "", texthl = "SmoothCursorRed" },
					{ cursor = "", texthl = "SmoothCursorOrange" },
					{ cursor = "●", texthl = "SmoothCursorYellow" },
					{ cursor = "●", texthl = "SmoothCursorGreen" },
					{ cursor = "•", texthl = "SmoothCursorAqua" },
					{ cursor = ".", texthl = "SmoothCursorBlue" },
					{ cursor = ".", texthl = "SmoothCursorPurple" },
				},
				tail = { cursor = nil, texthl = "SmoothCursor" },
			},
			flyin_effect = nil,
			speed = 25,
			intervals = 35,
			priority = 10,
			timeout = 3000,
			threshold = 3,
			disable_float_win = false,
			enabled_filetypes = nil,
			disabled_filetypes = nil,
		},
	},

	-- edgy
	-- {
	-- 	"folke/edgy.nvim",
	-- 	event = "VeryLazy",
	-- 	init = function()
	-- 		vim.opt.laststatus = 3
	-- 		vim.opt.splitkeep = "screen"
	-- 	end,
	-- 	opts = {
	-- 		bottom = {
	-- 			-- toggleterm / lazyterm at the bottom with a height of 40% of the screen
	-- 			{
	-- 				ft = "toggleterm",
	-- 				size = { height = 0.4 },
	-- 				-- exclude floating windows
	-- 				filter = function(buf, win)
	-- 					return vim.api.nvim_win_get_config(win).relative == ""
	-- 				end,
	-- 			},
	-- 			{
	-- 				ft = "lazyterm",
	-- 				title = "LazyTerm",
	-- 				size = { height = 0.4 },
	-- 				filter = function(buf)
	-- 					return not vim.b[buf].lazyterm_cmd
	-- 				end,
	-- 			},
	-- 			"Trouble",
	-- 			{ ft = "qf", title = "QuickFix" },
	-- 			{
	-- 				ft = "help",
	-- 				size = { height = 20 },
	-- 				-- only show help buffers
	-- 				filter = function(buf)
	-- 					return vim.bo[buf].buftype == "help"
	-- 				end,
	-- 			},
	-- 			{ ft = "spectre_panel", size = { height = 0.4 } },
	-- 		},
	-- 		left = {
	-- 			-- Neo-tree filesystem always takes half the screen height
	-- 			{
	-- 				title = "Neo-Tree",
	-- 				ft = "neo-tree",
	-- 				filter = function(buf)
	-- 					return vim.b[buf].neo_tree_source == "filesystem"
	-- 				end,
	-- 				size = { height = 0.5 },
	-- 			},
	-- 			{
	-- 				title = "Neo-Tree Git",
	-- 				ft = "neo-tree",
	-- 				filter = function(buf)
	-- 					return vim.b[buf].neo_tree_source == "git_status"
	-- 				end,
	-- 				pinned = true,
	-- 				open = "Neotree position=right git_status",
	-- 			},
	-- 			{
	-- 				title = "Neo-Tree Buffers",
	-- 				ft = "neo-tree",
	-- 				filter = function(buf)
	-- 					return vim.b[buf].neo_tree_source == "buffers"
	-- 				end,
	-- 				pinned = true,
	-- 				open = "Neotree position=top buffers",
	-- 			},
	-- 			{
	-- 				ft = "Outline",
	-- 				pinned = true,
	-- 				open = "SymbolsOutline",
	-- 			},
	-- 			-- any other neo-tree windows
	-- 			"neo-tree",
	-- 		},
	-- 	},
	-- },
}
