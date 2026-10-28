return {
  {
    "youyoumu/pretty-ts-errors.nvim",
    opts = {
      auto_open = false, -- Automatically show errors on hover
      lazy_window = true, -- Open the floating window only after errors are formatted
    },
    config = function()
      -- Show error under cursor
      vim.keymap.set("n", "<leader>te", function()
        require("pretty-ts-errors").show_formatted_error()
      end, { desc = "Show TS error" })

      -- Show all errors in file
      vim.keymap.set("n", "<leader>tE", function()
        require("pretty-ts-errors").open_all_errors()
      end, { desc = "Show all TS errors" })

      -- Toggle auto-display
      vim.keymap.set("n", "<leader>tT", function()
        require("pretty-ts-errors").toggle_auto_open()
      end, { desc = "Toggle TS error auto-display" })
    end,
  },
}
