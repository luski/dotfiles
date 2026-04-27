return {
  "dmmulroy/tsc.nvim",
  config = function()
    local has_vue_tsc = vim.fn.filereadable(vim.fn.getcwd() .. "/node_modules/.bin/vue-tsc") == 1
    require("tsc").setup({
      use_trouble_qflist = true,
      auto_start_watch_mode = true,
      bin_name = has_vue_tsc and "vue-tsc" or "tsc",
    })
  end,
}
