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
map("n", "<M-p>", ":Telescope grep_string <CR>")
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

-- Commenting
-- TODO, should be <ld>ci to toggle

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

