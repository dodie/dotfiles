require "nvchad.mappings"

-- CheatSheet
-- :NvCheatsheet - open built-in cheatsheet
-- https://www.reddit.com/r/neovim/comments/12qku4w/nvchad_cheatsheet/

local map = vim.keymap.set

-- Let some uppercase commands work as their lowercase counterparts
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")
vim.cmd("command! Wq wq")
vim.cmd("command! WQ wq")

-- Navigation
-- :Telescope  - a nice "find anything" list, including git_branches and git_commits
map("n", "<C-p>", ":Telescope find_files <CR>")
map("n", "<M-p>", ":Telescope live_grep <CR>")
map("n", "<leader>*", ":lua require('telescope.builtin').grep_string({ search = '<C-R><C-W>' })<CR>")

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
map("n", "<F2>", ":NvimTreeToggle<CR>")
map("n", "<F3>", ":NvimTreeFindFile<CR>")
-- TODO: not yet ideal, F3 in the tree should jump back to file and f4 should be the preview, which is tab for now

-- Toggle comment
vim.api.nvim_set_keymap('n', '<leader>ci', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>ci', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })

--use J to merge lines and K to split them
map("n", "K", "i<CR><Esc>k:.,.s/\\s\\+$//e<CR>j:.,.s/^\\s\\+//e<CR>:nohlsearch<CR>")

-- Spelling
--  zg   - mark the word under the cursor as a good
--  zw   - mark the word under the cursor as a wrong
--  z=   - find suggestions for a wrong word
map("n", "<F7>", ":setlocal spell! spell?<CR>")

-- Formatting
-- TODO: check other options
-- In Visual select lines then =

-- Plugins
-- :Lazy  - manage

-- Theme
-- <ld>th - switch

-- Mappings for vim-expand-region
local noremap_silent_opts = { noremap = true, silent = true }
map('v', 'v', '<Plug>(expand_region_expand)', noremap_silent_opts)
map('v', '<C-v>', '<Plug>(expand_region_shrink)', noremap_silent_opts)

-- Terminal
-- alt-i - floating
-- alt-h - h-split
-- alt-v - v-split

-- Git
-- :Git blame                          - blame all lines
-- :Gitsigns blame_line                - show popup with full commit for a given line
-- :lua require"gitsigns".blame_line{full=true}  - show popup with full message and diff
-- :Gitsigns toggle_current_line_blame - virtual text for selected line

-- Symbols and diagnostics
map('n', '<F8>', "<cmd>Trouble diagnostics toggle<cr>") -- Diagnostics for all open buffers
-- map('n', '<F8>', "<cmd>Trouble diagnostics toggle filter.buf=0<cr>") -- Diagnostics for current buffer only
map('n', '<F5>', "<cmd>Trouble symbols toggle focus=false<cr>") -- Show all symbols in the current file
map('n', '<F6>', "<cmd>Trouble lsp toggle focus=false win.position=right<cr>") -- LSP definitions for the symbol under cursor
                                                                               -- can be focused on just one category, e.g. usages
-- map('n', '<leader>xL', "<cmd>Trouble loclist toggle<cr>") -- Location List
-- map('n', '<leader>xQ', "<cmd>Trouble qflist toggle<cr>") -- Quickfix List
-- TODO: jump to definition
