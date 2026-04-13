return {
  "neovim/nvim-lspconfig",
  init = function()
    if vim.g.__astro_edit_fix_installed then
      return
    end
    vim.g.__astro_edit_fix_installed = true

    local orig = vim.lsp.util.apply_text_document_edit

    vim.lsp.util.apply_text_document_edit = function(edit, enc, bufnr)
      local td = edit and edit.textDocument
      local uri = td and td.uri

      local is_astro = (
        type(bufnr) == "number"
        and vim.api.nvim_buf_is_valid(bufnr)
        and vim.bo[bufnr].filetype == "astro"
      ) or (type(uri) == "string" and uri:match("%.astro$"))

      if is_astro and td then
        td.version = vim.NIL
      end

      return orig(edit, enc, bufnr)
    end
  end,
}
