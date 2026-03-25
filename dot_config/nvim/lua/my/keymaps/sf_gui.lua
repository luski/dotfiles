vim.keymap.set("n", "<leader>Gs", function()
  vim.cmd("!gh repo sync luski/sf-gui")
end, { desc = "Sync sf-gui GitHub repo" })
