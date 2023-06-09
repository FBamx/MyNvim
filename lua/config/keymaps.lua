local map = vim.keymap.set
local Util = require("util")

vim.g.mapleader = " "

-- unset highlight
map("n", "<Esc>", ":nohl<CR>")

-- lazy
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- local history
map("n", "<A-h>", ":LocalHistoryToggle<CR>")

-- escape the insert mode
map("i", "jj", "<Esc>")

-- navigate within insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")

map("n", "x", '"_x')
map("n", "=", "<C-a>")
map("n", "-", "<C-x>")

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

map("n", "<C-a>", "ggVG", { silent = true })

map("i", "<M-z>", "<ESC>", { silent = true })

map("n", "<leader>nh", ":nohl<CR>", { silent = true })

-- git
map("n", "<leader>rh", ":lua require 'gitsigns'.reset_hunk()<CR>")
map("n", "<leader>ph", ":lua require 'gitsigns'.preview_hunk()<CR>")
map("n", "<leader>gb", ":lua package.loaded.gitsigns.blame_line()<CR>")
map("n", "<leader>td", ":lua require 'gitsigns'.toggle_deleted()<CR>")

-- SymbolsOutline
map("n", "<leader>cs", ":SymbolsOutline<CR>")

-- diagnostic
map("n", "<A-n>", vim.diagnostic.goto_next)
map("n", "<A-p>", vim.diagnostic.goto_prev)

-- tmux navigation
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")

-- buffers
if Util.has("bufferline.nvim") then
	map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
	map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
	map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
	map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
	map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
	map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
	map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
	map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- lazygit
map("n", "<leader>gg", function()
	Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false })
end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function()
	Util.float_term({ "lazygit" }, { esc_esc = false })
end, { desc = "Lazygit (cwd)" })

-- toglle format
map("n", "<leader>uf", require("plugins.lsp.format").toggle, { desc = "Toggle format on Save" })

-- LspInfo
map("n", "<leader>ls", "<cmd> LspInfo<CR>")
