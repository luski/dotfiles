-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.opt.mouse = "a"
vim.wo.foldmethod = "manual"
vim.opt.title = true
vim.opt.titlelen = 0 -- do not shorten title
vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
})
