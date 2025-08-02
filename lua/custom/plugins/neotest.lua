return {
  {
    'nvim-neotest/neotest',
    event = 'LspAttach',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-neotest/neotest-jest',
      { 'fredrikaverpil/neotest-golang', version = '*' },
    },
    opts = {
      status = { virtual_text = true },
      output = { open_on_run = true },
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-jest' {
            jestCommand = 'npm test --',
            jestConfigFile = 'custom.jest.config.ts',
            env = { CI = true },
            cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
          require 'neotest-golang',
        },
      }
    end,
  -- stylua: ignore
  keys = {
    {"<leader>ct", "", desc = "[T]ests"},
    { "<leader>ctt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
    { "<leader>ctT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
    { "<leader>ctr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
    { "<leader>ctl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
    { "<leader>cts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
    { "<leader>cto", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
    { "<leader>ctO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
    { "<leader>ctS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
    { "<leader>ctw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
  },
  },
}
