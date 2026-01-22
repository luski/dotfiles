return {
  "dmmulroy/tsc.nvim",
  config = function()
    require("tsc").setup({
      use_trouble_qflist = true,
      auto_start_watch_mode = true,
      -- vue specific!
      bin_name = "vue-tsc",
      flags = {
        -- watch = true,
      },
    })
  end,
}
