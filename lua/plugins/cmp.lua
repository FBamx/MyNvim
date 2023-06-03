return {
	-- cmp
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-emoji" },
			{ "onsails/lspkind.nvim" },
			{
				"Saecki/crates.nvim",
				event = { "BufRead Cargo.toml" },
				config = true,
			},
		},
		opts = function()
			local cmp = require("cmp")
			local hl_groups = {
				PmenuSel = { bg = "#282C34", fg = "NONE" },
				Pmenu = { fg = "#C5CDD9", bg = "#22252A" },
				CatppCursor = { bg = "#EABDFF", fg = "#4B4453" },
				CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE" },
				CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE" },
				CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE" },
				CmpItemMenu = { fg = "#D4BB6C", bold = true },
				CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
				CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
				CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },
				CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
				CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
				CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },
				CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
				CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
				CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },
				CmpItemKindFunction = { fg = "#EADFF0", bg = "#AAAFFF" },
				CmpItemKindStruct = { fg = "#EADFF0", bg = "#AAAFFF" },
				CmpItemKindClass = { fg = "#EADFF0", bg = "#AAAFFF" },
				CmpItemKindModule = { fg = "#EADFF0", bg = "#AAAFFF" },
				CmpItemKindOperator = { fg = "#EADFF0", bg = "#AAAFFF" },
				CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
				CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },
				CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
				CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
				CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A958" },
				CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
				CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
				CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },
				CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
				CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
				CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
			}
			for group, color in pairs(hl_groups) do
				vim.api.nvim_set_hl(0, group, color)
			end
			return {
				sources = cmp.config.sources({
					{ name = "emoji" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "crates" },
					-- { name = "cmp_tabnine" },
				}),
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:CatppCursor,Search:None",
						side_padding = 0,
					},
					documentation = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						side_padding = 0,
					},
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({
							mode = "symbol_text",
							maxwidth = 40,
							ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						})(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })

						kind.menu = ({
							buffer = "☄️",
							nvim_lsp = "☘️ ",
							luasnip = "🌖",
							nvim_lua = "🌙",
							latex_symbols = "📚",
						})[entry.source.name]
						-- add return types for function suggestions.
						local item = entry:get_completion_item()
						if kind.menu == nil then
							kind.menu = ""
						end
						if item.detail then
							kind.menu = "    " .. (strings[2] or "") .. kind.menu .. "✨" .. item.detail
						else
							kind.menu = "    " .. (strings[2] or "") .. kind.menu
						end

						kind.kind = " " .. (strings[1] or "") .. " "
						return kind
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
			}
		end,
	},
}
