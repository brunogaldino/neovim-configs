-- stylua: ignore start

local map = function(mode, keys, func, opts)
  vim.keymap.set(mode, keys, func, opts)
end

-- Diagnostics
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Buffer navigation
map('n', '<S-h>', ':bprev<CR>', { desc = 'Previous buffer', silent = true })
map('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer', silent = true })
map('n', '<leader>bD', function() Snacks.bufdelete.other() end, { desc = '[B]uffer [D]elete Others' })
map('n', '<leader>bd', function() Snacks.bufdelete.delete() end, { desc = '[B]uffer [D]elete' })

-- Window management
map('n', '<leader>|', ':vsplit<CR>', { desc = 'Split pane vertically', silent = true })
map('n', '<leader>_', ':split<CR>', { desc = 'Split pane horizontally', silent = true })

-- File management
map('n', '-', function() require('mini.files').open(vim.uv.cwd(), true) end, { desc = 'Open MiniFiles (CWD)', silent = true })
map('n', '_', function() require('mini.files').open(vim.api.nvim_buf_get_name(0), true) end, { desc = 'Open MiniFiles (Current DIR)', silent = true })

-- Windows management
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Misc keybinds
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>fn', ':enew<CR>', { desc = 'Create [F]ile [N]ew', silent = true })
map({ 'n', 't' }, '<C-;>', function() Snacks.terminal.toggle() end, { desc = 'Open terminal' })
map({ 'n', 'i' }, '<C-s>', function() vim.lsp.buf.signature_help { border = 'rounded', max_width = 120, max_height = 80 } end)
map('n', 'K', function()
  vim.lsp.buf.hover {
    border = 'rounded',
    max_height = 80,
    max_width = 120,
  }
end, { desc = 'LSP Hover' })

-- Categories for which-key

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- stylua: ignore end
-- vim: ts=2 sts=2 sw=2 et
