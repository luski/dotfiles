return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.diagnostics.virtual_text = false
    opts.servers = opts.servers or {}
    opts.servers["*"] = opts.servers["*"] or {}
    opts.servers["*"].keys = opts.servers["*"].keys or {}
    vim.list_extend(opts.servers["*"].keys, {
      {
        "<leader>ca",
        function()
          vim.lsp.buf.code_action({
            filter = function(action)
              return not action.disabled
            end,
          })
        end,
        desc = "Code Action",
        mode = { "n", "v" },
        has = "codeAction",
      },
    })
  end,
}
