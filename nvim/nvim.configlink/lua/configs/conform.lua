local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

-- See main init.lua where wrapping is disabled for Python.

require("conform").setup(options)
