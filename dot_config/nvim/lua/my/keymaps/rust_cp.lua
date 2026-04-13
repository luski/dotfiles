-- Rust Keymaps
local function run_rust_with_fzf()
  local fzf = require("fzf-lua")

  local current_dir = vim.fn.expand("%:p:h")
  local project_root = vim.fn.fnamemodify(current_dir, ":h")
  local test_dir = project_root .. "/test"

  if vim.fn.isdirectory(test_dir) == 0 then
    vim.notify("Folder /test nie istnieje!", vim.log.levels.ERROR)
    return
  end

  fzf.files({
    cwd = test_dir,
    prompt = "Wybierz input ❯ ",
    file_icons = false,
    git_icons = false,
    actions = {
      ["default"] = function(selected)
        local input_file = selected[1]
        local input_path = test_dir .. "/" .. input_file
        local source_file = vim.fn.expand("%:p")
        local output_bin = project_root .. "/dist"

        vim.cmd("wa")

        local compile = string.format(
          "rustc %s -o %s --edition 2024 -O -Ctarget-feature=+crt-static -Cstrip=debuginfo -Cstrip=symbols",
          source_file,
          output_bin
        )
        local run = string.format("RUST_BACKTRACE=1 %s < %s", output_bin, input_path)
        local full_cmd = compile .. " && echo '\n--- WYNIK: " .. input_file .. " ---\n' && " .. run

        -- Snacks.terminal z konfiguracją dolnego okna
        Snacks.terminal(full_cmd, {
          cwd = project_root,
          interactive = false,
          win = {
            position = "bottom", -- Terminal na dole
            height = 0.3, -- Zajmie 30% wysokości ekranu
          },
        })
      end,
    },
  })
end

vim.keymap.set("n", "<leader>rt", run_rust_with_fzf, { desc = "Rust: Testuj (Terminal na dole)" })
