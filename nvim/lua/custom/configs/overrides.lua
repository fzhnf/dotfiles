local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "php",
    "c",
    "markdown",
    "markdown_inline",
    "python",
    "cpp",
    "rust",
    "go",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "intelephense",
    "phpcbf",

    -- c/cpp stuff
    "clangd",
    "clang-format",
    "codelldb",

    -- rust stuff
    "rust-analyzer",

    -- go stuff
    "gopls",
    "impl",
    "gotest",
    "gomodifytags",
    "gofumpt",
    "goimports-reviser",
    "golines",

    -- python stuff
    "pyright",
    "mypy",
    "ruff",
    "black",
    "pyright",
    "debugpy",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
    ignore = false,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
