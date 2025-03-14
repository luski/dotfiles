return {
  "dmmulroy/tsc.nvim",
  config = function()
    require("tsc").setup({
      use_trouble_qflist = true,
      auto_start_watch_mode = true,
      auto_close_qflist = true,
      flags = {
        -- watch = true,
      },
    })
  end,
}
