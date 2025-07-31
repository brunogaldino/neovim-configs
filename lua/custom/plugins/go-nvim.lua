return {
  'ray-x/go.nvim',
  dependencies = { -- optional packages
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    lsp_keymaps = false,
    lsp_cfg = false,
    diagnostic = { -- set diagnostic to false to disable vim.diagnostic.config setup,
      -- true: default nvim setup
      hdlr = false, -- hook lsp diag handler and send diag to quickfix
      underline = true,
      virtual_text = { spacing = 2, prefix = '' }, -- virtual text setup
      signs = true,
      update_in_insert = false,
    },
  },
  config = function(lp, opts)
    require('mason').setup()
    require('mason-lspconfig').setup()
    require('go').setup {
      lsp_cfg = false,
    }
    local cfg = require('go.lsp').config() -- config() return the go.nvim gopls setup

    require('lspconfig').gopls.setup(cfg)
  end,
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
