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
  "<LEADER>ns",
  require("package-info").show,
  { silent = true, noremap = true, desc = "Show node dependency versions" }
)

-- Hide dependency versions
vim.keymap.set(
  { "n" },
  "<LEADER>nc",
  require("package-info").hide,
  { silent = true, noremap = true, desc = "Hide node dependency versions" }
)

-- Toggle dependency versions
vim.keymap.set(
  { "n" },
  "<LEADER>nt",
  require("package-info").toggle,
  { silent = true, noremap = true, desc = "Toggle node dependency versions" }
)

-- Update dependency on the line
vim.keymap.set(
  { "n" },
  "<LEADER>nu",
  require("package-info").update,
  { silent = true, noremap = true, desc = "Update dependency on the line" }
)

-- Delete dependency on the line
vim.keymap.set(
  { "n" },
  "<LEADER>nd",
  require("package-info").delete,
  { silent = true, noremap = true, desc = "Delete dependency on the line" }
)

-- Install a new dependency
vim.keymap.set(
  { "n" },
  "<LEADER>ni",
  require("package-info").install,
  { silent = true, noremap = true, desc = "Install a new dependency" }
)

-- Install a different dependency version
vim.keymap.set(
  { "n" },
  "<LEADER>np",
  require("package-info").change_version,
  { silent = true, noremap = true, desc = "Install a different dependency version" }
)

-- Custom copilot accepting keymap
vim.keymap.set("i", "<Tab>", function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end, {
  silent = true,
})

-- Mapowanie w trybie normalnym
vim.keymap.set("n", "<C-A-c>", ":Lazy reload copilot.lua<CR>", { noremap = true, silent = true })

-- Mapowanie w trybie insert
vim.keymap.set("i", "<C-A-c>", "<Esc>:Lazy reload copilot.lua<CR>", { noremap = true, silent = true })
