vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = ","

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})

-- https://www.reddit.com/r/neovim/comments/1febwuu/best_neovim_config_option_ive_found_all_year/
-- sync buffers automatically
vim.opt.autoread = true
-- disable neovim generating a swapfile and showing the error
vim.opt.swapfile = false

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

require "configs.highlights"
require "configs.substitfution"

local py_wrap_group =
  vim.api.nvim_create_augroup("Disable wrapping for Python as it is handled by the formatter better", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  group = py_wrap_group,
  callback = function()
    vim.wo.wrap = false
    vim.opt.textwidth = 999
  end,
})
