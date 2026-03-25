return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
  },
  opts = {
    adapters = {
      ["neotest-vitest"] = {
        vitestCommand = function(path)
          -- specifically for mosaixx-ui
          -- if string.find(path, "frontend") then
          return "npx vitest"
          -- else
          --   return "vitest"
          -- end
        end,
      },
    },
  },
}
