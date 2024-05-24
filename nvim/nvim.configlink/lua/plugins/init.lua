return {
  {
    "tpope/vim-fugitive",
    lazy=false,
  },
  {
    "terryma/vim-expand-region",
    lazy=false,
  },
  {
    "easymotion/vim-easymotion",
    lazy=false,
  },
  {
    "vim-scripts/yaifa.vim",
    lazy=false,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  -- MasonInstallAll   - install managed tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server", "stylua",
        "html-lsp", "css-lsp" , "prettier",
        "pyright", "jdtls"
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "black", "debugpy", "flake8",
        "isort", "mypy", "pylint"
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "python", "java"
      },
    },
  },
}

-- Notes for the default plugins (https://nvchad.com/docs/features/)
-- - Lazy.vim for plugin management
-- - Treesitter: syntax highlighting and basic refactoring. How does it compare to lsp?
-- - Mason: package manager (for language servers)
-- - mason tool installer: package manager for supporting tools such as debuggers
-- - Comment.vim: commenting plugin https://github.com/numToStr/Comment.nvim

-- Ditched plugins:
-- rainbow parens
-- gundo
