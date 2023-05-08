local echo = function(str)
	vim.cmd("redraw")
	vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	echo("  Installing lazy.nvim & plugins ...")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("util")
require("config.keymaps")
require("config.autocmds")
require("config.options")
require("core")
require("lazy").setup("plugins")

-- colorscheme
vim.cmd([[colorscheme catppuccin]])

-- format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

local config = require("core.default_config").ui
vim.opt.statusline = "%!v:lua.require('ui.statusline." .. config.statusline.theme .. "').run()"

dofile(vim.g.base46_cache .. "defaults")
