vim.cmd [[
  highlight! link NormalFloat GruvboxMaterialBackground
  highlight! link FloatBorder GruvboxMaterialComment
]]

return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'antoinemadec/FixCursorHold.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-jest',
      { 'fredrikaverpil/neotest-golang', version = '*' },
    },
    opts = {
      status = { virtual_text = false },
      output = { open_on_run = false },
      -- quickfix = {
      --   open = function()
      --     vim.cmd 'Trouble quickfix'
      --   end,
      --   enabled = true,
      -- },
      floating = {
        border = 'rounded',
        max_height = 0.6,
        max_width = 0.6,
      },
    },
    config = function(_, opts)
      require('neotest').setup(vim.tbl_deep_extend('force', opts, {
        adapters = {
          require 'neotest-jest' {
            jestCommand = 'npm test --',
            jestConfigFile = 'jest.config.ts',
            env = { CI = true, FORCE_COLOR = '1' },
            cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
          require 'neotest-golang' {
            runner = 'gotestsum',
            env = { CI = 'true', FORCE_COLOR = '1' },
          },
        },
      }))
    end,
  -- stylua: ignore
  keys = {
    {"<leader>t", "", desc = "[T]ests"},
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
    { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
  },
  },
}
