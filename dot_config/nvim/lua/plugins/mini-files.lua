return {
  "echasnovski/mini.files",
  opts = {
    mappings = {
      go_in_plus = "<CR>",
      go_in = "<C-l>",
      go_out = "<C-h>",
    },
    options = {
      use_as_default_explorer = true,
    },
    windows = {
      width_preview = 100,
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (Directory of Current File)",
    },
    {
      "<leader>E",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },
}
