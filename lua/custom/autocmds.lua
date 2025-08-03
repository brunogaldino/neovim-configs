-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Automatically load last saved session from directory
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('enter_commands', { clear = true }),
  callback = function()
    Snacks.indent.enable()
    --     if vim.fn.getcwd() ~= vim.env.HOME then
    --       require('persistence').load()
    --     end
  end,
  --   nested = true,
})

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client:supports_method 'textDocument/foldingRange' then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})

vim.api.nvim_create_autocmd('LspNotify', {
  callback = function(args)
    if args.data.method == 'textDocument/didOpen' then
      vim.lsp.foldclose('imports', vim.fn.bufwinid(args.buf))
    end
  end,
})

-- Open Trouble for neotest results automatically on failures
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'NeotestFinished',
--   callback = function()
--     local neotest = require 'neotest'
--     local results = neotest.summary.get_summary()
--     if results and results.failed > 0 then
--       vim.cmd 'Trouble quickfix'
--     end
--   end,
-- })

-- Close floating windows with 'q' and stop lazygit from unfocus on 'q'
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, silent = true }
    -- Only apply to floating windows
    if vim.api.nvim_win_get_config(0).relative ~= '' then
      vim.keymap.set('n', 'q', '<cmd>close<cr>', opts)
      vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', opts)
    end
  end,
})
