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
  group = vim.api.nvim_create_augroup('restore_session', { clear = true }),
  callback = function()
    if vim.fn.getcwd() ~= vim.env.HOME then
      require('persistence').load()
    end
  end,
  nested = true,
})
