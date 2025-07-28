return {
  'akinsho/bufferline.nvim',
  version = '*',
  lazy = false,
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {},
  keys = {
    { '<S-h>', ':bprev<CR>', 'Previous buffer', { silent = true } },
    { '<S-l>', ':bnext<CR>', 'Previous buffer', { silent = true } },
    { '<leadersb', ':bd<CR>', 'Delete buffe' },
  },
}
