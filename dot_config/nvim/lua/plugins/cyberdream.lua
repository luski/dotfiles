return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
    },
  },
  config = function()
    require("cyberdream").setup({
      -- Enable italics comments
      italic_comments = true,
    })
  end,
}
