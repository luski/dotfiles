return {
  "vuki656/package-info.nvim",
  depends = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    package_manager = "npm",
  },
  config = function()
    require("package-info").setup()
  end,
}
