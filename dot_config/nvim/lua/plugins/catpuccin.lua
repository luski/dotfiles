return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "onedark_dark",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-storm",
    },
  },
  {
    "catppuccin/nvim", -- albo twój theme, ważne żeby hook zadziałał
    opts = function(_, opts)
      -- jeśli używasz catppuccin możesz też tu sterować italic globalnie
      opts.styles = opts.styles or {}
      opts.styles.keywords = { "italic" }
      opts.styles.functions = { "italic" }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          local hl = vim.api.nvim_set_hl

          hl(0, "@keyword", { italic = true })
          hl(0, "@keyword.function", { italic = true })
          hl(0, "@variable.parameter", { italic = true })
          hl(0, "@variable.builtin", { italic = true })
        end,
      })
    end,
  },
}
