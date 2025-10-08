require "nvchad.mappings"

-- CheatSheet
-- :NvCheatsheet - open built-in cheatsheet
-- https://www.reddit.com/r/neovim/comments/12qku4w/nvchad_cheatsheet/

local map = vim.keymap.set

-- Ctrl backspace to remove last word
map("i", "<C-h>", "<C-W>")

map("n", "<leader><leader><leader>", ":Telescope keymaps <CR>", { desc = "Command palette" })

-- Let some uppercase commands work as their lowercase counterparts
vim.cmd "cnoreabbrev W w"
vim.cmd "cnoreabbrev Q q"
vim.cmd "command! Wq wq"
vim.cmd "command! WQ wq"
vim.cmd "command! Qa qa"
vim.cmd "command! QA qa"

-- Navigation
-- :Telescope  - a nice "find anything" list, including git_branches and git_commits
map("n", "<C-p>", ":Telescope find_files <CR>", { desc = "Find files" })
map("n", "<M-p>", ":Telescope live_grep <CR>", { desc = "Find in files" })
map(
  "n",
  "<leader>*",
  ":lua require('telescope.builtin').grep_string({ search = '<C-R><C-W>' })<CR>",
  { desc = "Find word under cursor in files" }
)

-- Tree
-- g? in tree - help
-- File management
--   a          - add (append / at the end to create dirs)
--   r          - rename
--   c          - copy
--   x          - cut
--   p          - paste
-- <CR>       - open
-- <tab>      - open preview
map("n", "<F2>", ":NvimTreeToggle<CR>", { desc = "Open file tree" })
map("n", "<F3>", ":NvimTreeFindFile<CR>", { desc = "Find current file in tree" })
-- TODO: not yet ideal, F3 in the tree should jump back to file and f4 should be the preview, which is tab for now

-- Toggle comment
map("n", "<leader>ci", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>ci", "gc", { desc = "Toggle comment", remap = true })

--use J to merge lines and K to split them
map("n", "K", "i<CR><Esc>k:.,.s/\\s\\+$//e<CR>j:.,.s/^\\s\\+//e<CR>:nohlsearch<CR>")

-- Spelling
--  zg   - mark the word under the cursor as a good
--  zw   - mark the word under the cursor as a wrong
--  z=   - find suggestions for a wrong word
map("n", "<F7>", ":setlocal spell! spell?<CR>", { desc = "Spell checker" })

-- Formatting
-- TODO: check other options
-- In Visual select lines then =

-- Plugins
-- :Lazy  - manage

-- Theme
-- <ld>th - switch

-- Mappings for vim-expand-region
map("v", "v", "<Plug>(expand_region_expand)", { noremap = true, silent = true, desc = "Expand visual region" })
map("v", "<C-v>", "<Plug>(expand_region_shrink)", { noremap = true, silent = true, desc = "Shrink visual region" })

-- Add "global" object
map("n", "yig", ":%y<CR>", { noremap = true, silent = true })
map("n", "vig", "ggVG", { noremap = true, silent = true })
map("n", "cig", ":%d<CR>i", { noremap = true, silent = true })

-- Terminal
-- alt-i - floating
-- alt-h - h-split
-- alt-v - v-split

-- Git
map("n", "<leader>gba", "<cmd>Gitsigns blame<CR>", { desc = "Git blame all lines" })
map("n", "<leader>gbl", "<cmd>:lua require\"gitsigns\".blame_line{full=true}<CR>",
  { desc = "Git blame show commit for line" })
map("n", "<leader>gbt", "<cmd>:Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle blame current line" })
-- :lua require"gitsigns".blame_line{full=true}  - show popup with full message and diff
-- :Gitsigns toggle_current_line_blame - virtual text for selected line

-- Symbols and diagnostics
map("n", "<F8>", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Errors, warnings and diagnostics" })
-- map('n', '<F8>', "<cmd>Trouble diagnostics toggle filter.buf=0<cr>") -- Diagnostics for current buffer only
map(
  "n",
  "<F5>",
  "<cmd>Trouble symbols toggle focus=false<cr>",
  { desc = "Symbol outline (functions, classes, fields)" }
)
map(
  "n",
  "<F6>",
  "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
  { desc = "LSP definitions for the symbol (references, types, incoming calls, callers, outgoing calls)" }
)
-- can be focused on just one category, e.g. usages
-- map('n', '<leader>xL', "<cmd>Trouble loclist toggle<cr>") -- Location List
-- map('n', '<leader>xQ', "<cmd>Trouble qflist toggle<cr>") -- Quickfix List

-- Copy to clipboard
vim.api.nvim_set_keymap("v", "<leader>y", '"*y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Y", '"*yg_', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>y", '"*y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>yy", '"*yy', { noremap = true, silent = true })

-- Paste from clipboard
vim.api.nvim_set_keymap("n", "<leader>p", '"*p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>P", '"*P', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>p", '"*p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>P", '"*P', { noremap = true, silent = true })

-- Disable Help page
vim.api.nvim_set_keymap("n", "<F1>", ":echo<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<F1>", "<C-o>:echo<CR>", { noremap = true, silent = true })
