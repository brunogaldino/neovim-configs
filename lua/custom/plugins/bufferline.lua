return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'BufReadPre',
  dependencies = { { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font, event = 'VeryLazy' } },
  opts = {},
}
