return {
  "folke/flash.nvim",
  enabled = false,
  keys = {
    {
      "<c-space>",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter({
          actions = {
            ["<c-space>"] = "next",
            ["<BS>"] = "prev",
          },
          label = { after = false, before = false },
          labels = "1234567890",
        })
      end,
      desc = "Treesitter Incremental Selection",
    },
  },
}
