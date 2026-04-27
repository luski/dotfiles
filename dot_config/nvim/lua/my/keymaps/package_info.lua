local pi = require("package-info")

vim.keymap.set("n", "<leader>ps", pi.show, { silent = true, noremap = true, desc = "Show node dependency versions" })
vim.keymap.set("n", "<leader>pc", pi.hide, { silent = true, noremap = true, desc = "Hide node dependency versions" })
vim.keymap.set("n", "<leader>pt", pi.toggle, { silent = true, noremap = true, desc = "Toggle node dependency versions" })
vim.keymap.set("n", "<leader>pu", pi.update, { silent = true, noremap = true, desc = "Update dependency on the line" })
vim.keymap.set("n", "<leader>pd", pi.delete, { silent = true, noremap = true, desc = "Delete dependency on the line" })
vim.keymap.set("n", "<leader>pi", pi.install, { silent = true, noremap = true, desc = "Install a new dependency" })
vim.keymap.set("n", "<leader>pp", pi.change_version, { silent = true, noremap = true, desc = "Install a different dependency version" })