local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- TODO: remove this, and migrate lspconfig as needed
vim.deprecate = function() end
-- https://github.com/neovim/nvim-lspconfig?tab=readme-ov-file
-- https://www.reddit.com/r/neovim/comments/1nmh99k/beware_the_old_nvimlspconfig_setup_api_is/

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "pyright", "jdtls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- Configure harper-lsp
lspconfig.harper_ls.setup({
  filetypes = { "markdown", "text", "gitcommit" },
})
