return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local n = require("null-ls")
      opts.sources = opts.sources or {}

      -- usuń wszystkie wpisy biome dodane przez LazyVim
      opts.sources = vim.tbl_filter(function(src)
        return src.name ~= "biome"
      end, opts.sources)

      -- preferuj lokalne binarki z node_modules
      -- table.insert(
      --   opts.sources,
      --   n.builtins.formatting.prettierd.with({
      --     prefer_local = "node_modules/.bin",
      --     env = { PRETTIERD_LOCAL_PRETTIER_ONLY = "1" },
      --   })
      -- )
      -- table.insert(
      --   opts.sources,
      --   n.builtins.formatting.prettier.with({
      --     prefer_local = "node_modules/.bin",
      --   })
      -- )
    end,
  },
}
