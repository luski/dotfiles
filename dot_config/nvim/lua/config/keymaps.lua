-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Telescope import
vim.keymap.set("n", "<leader>ci", "<cmd>Telescope import<cr>", { desc = "Telescope [i]mport" })

-- Split screen vertically
vim.keymap.set("n", "<leader>\\", "<C-W>v", { desc = "Split Window Right", remap = true })

-- Package Info:
-- Show dependency versions
vim.keymap.set(
  { "n" },
  "<LEADER>ps",
  require("package-info").show,
  { silent = true, noremap = true, desc = "Show node dependency versions" }
)

-- Hide dependency versions
vim.keymap.set(
  { "n" },
  "<LEADER>pc",
  require("package-info").hide,
  { silent = true, noremap = true, desc = "Hide node dependency versions" }
)

-- Toggle dependency versions
vim.keymap.set(
  { "n" },
  "<LEADER>pt",
  require("package-info").toggle,
  { silent = true, noremap = true, desc = "Toggle node dependency versions" }
)

-- Update dependency on the line
vim.keymap.set(
  { "n" },
  "<LEADER>pu",
  require("package-info").update,
  { silent = true, noremap = true, desc = "Update dependency on the line" }
)

-- Delete dependency on the line
vim.keymap.set(
  { "n" },
  "<LEADER>pd",
  require("package-info").delete,
  { silent = true, noremap = true, desc = "Delete dependency on the line" }
)

-- Install a new dependency
vim.keymap.set(
  { "n" },
  "<LEADER>pi",
  require("package-info").install,
  { silent = true, noremap = true, desc = "Install a new dependency" }
)

-- Install a different dependency version
vim.keymap.set(
  { "n" },
  "<LEADER>pp",
  require("package-info").change_version,
  { silent = true, noremap = true, desc = "Install a different dependency version" }
)

-- Prevent from replacing the buffer when pasting highlighted text
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without replacing the buffer" })

-- Biome Linting
vim.keymap.set("n", "<leader>bl", ":BiomeLintAll<CR>", { desc = "Biome Lint (all)" })
vim.keymap.set("n", "<leader>be", ":BiomeLintErrors<CR>", { desc = "Biome Lint (errors only)" })
vim.keymap.set("n", "<leader>bw", ":BiomeLintErrorsAndWarnings<CR>", { desc = "Biome Lint (errors and warnings only)" })
