return {
  "vuki656/package-info.nvim",
  depends = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    package_manager = "npm",
    autostart = false,
  },
  config = function(_, opts)
    require("package-info").setup(opts)
  end,
}
