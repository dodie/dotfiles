-- Needed to highlight the word under the cursor
vim.cmd [[
  hi default CursorWord cterm=underline gui=underline
]]

-- Create an augroup for Highlights
local highlight_group = vim.api.nvim_create_augroup("Highlights", { clear = true })

-- Highlight trailing whitespace
vim.api.nvim_create_autocmd({"WinEnter", "VimEnter"}, {
    pattern = "*",
    callback = function()
        vim.fn.matchadd('Todo', '\\s\\+$', -1)
    end,
    group = highlight_group
})

-- Highlight TODO and FIXME
vim.api.nvim_create_autocmd({"WinEnter", "VimEnter"}, {
    pattern = "*",
    callback = function()
        vim.fn.matchadd('Todo', 'TODO\\|FIXME', -1)
    end,
    group = highlight_group
})

vim.api.nvim_create_autocmd('CursorMoved', {
    group = highlight_group,
    pattern = '*',
    callback = function()
        local word = vim.fn.expand('<cword>')
        local escaped_word = vim.fn.escape(word, '/\\')
        local pattern = string.format('\\V\\<%s\\>', escaped_word)
        vim.cmd('match CursorWord /' .. pattern .. '/')
    end,
})
