return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy', -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  opts = {
    multilines = {
      enabled = true,
    },
  },
  config = function()
    require('tiny-inline-diagnostic').setup()
    vim.diagnostic.config { virtual_text = false } -- Only if needed in your configuration, if you already have native LSP diagnostics
  end,
}
