return {
  'andythigpen/nvim-coverage',
  version = '*',
  cmd = { 'CoverageSummary', 'CoverageToggle' },
  config = function()
    require('coverage').setup {
      auto_reload = true,
      load_coverage_cb = function(ftype)
        vim.notify('Loaded ' .. ftype .. ' coverage')
      end,
    }
  end,
  keys = {
    { '<leader>tc', ':CoverageSummary<CR>', desc = '[T]est [C]overage Summary', silent = true },
    { '<leader>Tc', ':CoverageToggle<CR>', desc = '[T]oggle [C]overage', silent = true },
  },
}
