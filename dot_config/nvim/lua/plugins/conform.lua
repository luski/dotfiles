return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "biome", "prettierd", stop_after_first = true },
      typescript = { "biome", "prettierd", stop_after_first = true },
      javascriptreact = { "biome", "prettierd", stop_after_first = true },
      typescriptreact = { "biome", "prettierd", stop_after_first = true },
      json = { "biome", "prettierd", stop_after_first = true },
      css = { "prettierd" },
      astro = { "prettierd" },
      scss = { "prettierd" },
      html = { "prettierd" },
      markdown = { "prettierd" },
      vue = { "prettierd" },
      kdl = { "kdlfmt" },
    },
    formatters = {
      biome = {
        condition = function(ctx)
          return vim.fs.find({ "biome.json", "biome.jsonc" }, { upward = true, path = ctx.dirname })[1] ~= nil
        end,
      },
    },
  },
}
