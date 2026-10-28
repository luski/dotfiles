vim.keymap.set("n", "<leader>ci", "<cmd>Telescope import<cr>", { desc = "Telescope [i]mport" })

vim.keymap.set("n", "<leader>\\", "<C-W>v", { desc = "Split Window Right", remap = true })

vim.keymap.set("n", "<leader>by", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify(path, vim.log.levels.INFO, { title = "Path copied" })
end, { desc = "Copy buffer path to clipboard" })

vim.keymap.set("n", "<leader>bn", function()
  local path = vim.fn.expand("%:t")
  vim.fn.setreg("+", path)
  vim.notify(path, vim.log.levels.INFO, { title = "Name copied" })
end, { desc = "Copy buffer name to clipboard" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without replacing the buffer" })
