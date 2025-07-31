-- local map = function(mode, keys, func, desc)
--   vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
-- end
--
-- local Snacks = require 'snacks'

-- stylua: ignore
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>fn', ':enew<CR>', { desc = 'Create [F]ile [N]ew' })
vim.keymap.set({ 'n', 't' }, '<C-;>', function()
  Snacks.terminal.toggle()
end, { desc = 'Open terminal' })

-- Diagnostics
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- vim.keymap.set('n', '<C-,>', vim., { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>ll', ':Lazy<CR>', { desc = '[L]azy', silent = true })
vim.keymap.set('n', '<leader>lm', ':Mason<CR>', { desc = '[M]ason', silent = true })

-- use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Buffer navigation
vim.keymap.set('n', '<S-h>', ':bprev<CR>', { desc = 'Previous buffer', silent = true })
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer', silent = true })
vim.keymap.set('n', '<leader>bD', function()
  Snacks.bufdelete.other()
end, { desc = '[B]uffer [D]elete Others' })
vim.keymap.set('n', '<leader>bd', function()
  Snacks.bufdelete.delete()
end, { desc = '[B]uffer [D]elete' })

-- Window management
vim.keymap.set('n', '<leader>|', ':vsplit<CR>', { desc = 'Split pane vertically', silent = true })
vim.keymap.set('n', '<leader>_', ':split<CR>', { desc = 'Split pane horizontally', silent = true })

-- File management
vim.keymap.set('n', '-', function()
  require('mini.files').open(vim.uv.cwd(), true)
end, { desc = 'Open MiniFiles (CWD)', silent = true })
vim.keymap.set('n', '_', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
end, { desc = 'Open MiniFiles (Current DIR)', silent = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- vim: ts=2 sts=2 sw=2 et
