return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "astro",
        "scss",
        "css",
      })
    end,
  },
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    config = function()
      require("treesitter-modules").setup({
        incremental_selection = {
          enable = true,
          -- set value to `false` to disable individual mapping
          -- node_decremental captures both node_incremental and scope_incremental
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<S-space>",
            node_decremental = "<BS>",
          },
        },
      })
    end,
  },
}
