return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- Frontend & JS/TS
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "emmet_ls",

        -- PHP / Laravel
        "intelephense",

        -- Systems & Compiled
        "clangd",
        "rust_analyzer",

        -- Python
        "pyright",

        -- Lua & Neovim
        "lua_ls",

        -- DevOps & Systems
        "bashls",
        "dockerls",
        "yamlls",
      },
    },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- Formatters
        "prettier",     -- Web / JS / TS / CSS / JSON / Markdown
        "stylua",       -- Lua
        "isort",        -- Python imports
        "black",        -- Python code formatting
        "clang-format", -- C / C++ formatting
        "pint",         -- Laravel PHP code style

        -- Linters
        "pylint",       -- Python
        "eslint_d",     -- JS / TS
        "php-cs-fixer", -- PHP linting
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
}
