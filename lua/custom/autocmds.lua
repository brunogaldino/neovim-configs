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
-- vim.api.nvim_create_autocmd('VimEnter', {
--   group = vim.api.nvim_create_augroup('restore_session', { clear = true }),
--   callback = function()
--     if vim.fn.getcwd() ~= vim.env.HOME then
--       require('persistence').load()
--     end
--   end,
--   nested = true,
-- })

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

-- Allow mini.files to show hidden files (TESTING)
-- local show_dotfiles = false
-- local filter_show = function(fs_entry)
--   return true
-- end
-- local filter_hide = function(fs_entry)
--   return not vim.startswith(fs_entry.name, '.')
-- end
--
-- local toggle_dotfiles = function()
--   show_dotfiles = not show_dotfiles
--   local new_filter = show_dotfiles and filter_show or filter_hide
--   MiniFiles.refresh { content = { filter = new_filter } }
-- end
--
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'MiniFilesBufferCreate',
--   callback = function(args)
--     local buf_id = args.data.buf_id
--     -- Tweak left-hand side of mapping to your liking
--     vim.keymap.set('n', '<A-h>', toggle_dotfiles, { buffer = buf_id })
--   end,
-- })
