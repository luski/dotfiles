return {
  "cbochs/grapple.nvim",
  opts = {
    scope = "git", -- also try out "git_branch"
  },
  event = { "BufReadPost", "BufNewFile" },
  cmd = "Grapple",
  keys = {
    { "<leader>h", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
    { "<leader>H", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },

    { "<leader>1", "<cmd>Grapple select index=3<cr>" },
    { "<leader>2", "<cmd>Grapple select index=4<cr>" },
    { "<leader>3", "<cmd>Grapple select index=5<cr>" },
    { "<leader>4", "<cmd>Grapple select index=6<cr>" },
    { "<leader>5", "<cmd>Grapple select index=7<cr>" },
    { "<leader>6", "<cmd>Grapple select index=8<cr>" },
    { "<leader>7", "<cmd>Grapple select index=9<cr>" },
    { "<leader>8", "<cmd>Grapple select index=0<cr>" },

    -- sf-gui
    { "<leader>9", "<cmd>Grapple select name=en<cr>" },
    { "<leader>0", "<cmd>Grapple select name=env<cr>" },
  },
}
