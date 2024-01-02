local null_ls = require "null-ls"
local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

local sources = {
  formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
  formatting.stylua, -- lua
  formatting.clang_format, -- c, cpp
  formatting.black, -- python
  formatting.rustfmt, -- rust
  formatting.gofumpt, -- go
  formatting.google_java_format, -- java
  formatting.phpcbf, -- php
}

-- format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds {
      group = augroup,
      buffer = bufnr,
    }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { bufnr = bufnr }
      end,
    })
  end
end

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = on_attach,
}
