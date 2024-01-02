local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

--
-- lspconfig.pyright.setup { blabla}
lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_dir = lspconfig.util.root_pattern(
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    ".configure.ac",
    ".git"
  ),
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_patterns = { ".git", "go.mod", "go.work" },
  settings = {
    gopls = {
      completeUnimported = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
    },
  },
}

lspconfig.jdtls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "jdtls" },
  filetypes = { "java" },
  init_options = {
    workspace = "/home/fzhnf/.cache/jdtls/workspace",
  },
  root_dir = lspconfig.util.root_pattern(
    "build.xml",
    "pom.xml",
    "settings.gradle",
    "settings.gradle.kts",
    "build.gradle",
    "build.gradle.kts"
  ),
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = lspconfig.util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt"),
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "OpenFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
}
