local function lsp_organize_imports(bufnr)
  local params = vim.lsp.util.make_range_params(nil, 'utf-8')
  params.context = { only = { 'source.organizeImports' } }
  local result = vim.lsp.buf_request_sync(bufnr, 'textDocument/codeAction', params, 1000)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, 'utf-8')
      else
        vim.lsp.buf.code_action { apply = true, context = { only = { 'source.organizeImports' }, diagnostics = {} } }
      end
    end
  end
end

-- LSP Plugins
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufWritePre', 'BufNewFile' },
    -- event = 'VeryLazy',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'smjonas/inc-rename.nvim', opts = {} },

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- map('<leader>cr', ':IncRename<CR>', '[C]ode [R]ename')
          vim.keymap.set('n', '<leader>cr', function()
            return ':IncRename ' .. vim.fn.expand '<cword>'
          end, { desc = '[C]ode [R]ename', expr = true })
          map('<C-.>', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('ga', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          -- map('gr', require('snacks').picker.lsp_references, '[G]oto [R]eferences')
          -- map('gi', require('snacks').picker.lsp_implementations, '[G]oto [I]mplementation')
          -- map('gd', require('snacks').picker.lsp_definitions, '[G]oto [D]efinition')
          -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          -- map('<leader>ss', require('snacks').picker.lsp_symbols, 'Open Document Symbols')
          -- map('<leader>sS', require('snacks').picker.lsp_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('gy', require('snacks').picker.lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>Th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')

            vim.lsp.inlay_hint.enable(true)
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        -- virtual_text = {
        --   source = 'if_many',
        --   spacing = 2,
        --   format = function(diagnostic)
        --     local diagnostic_message = {
        --       [vim.diagnostic.severity.ERROR] = diagnostic.message,
        --       [vim.diagnostic.severity.WARN] = diagnostic.message,
        --       [vim.diagnostic.severity.INFO] = diagnostic.message,
        --       [vim.diagnostic.severity.HINT] = diagnostic.message,
        --     }
        --     return diagnostic_message[diagnostic.severity]
        --   end,
        -- },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                nilness = true,
                unusedparams = true,
                shadow = false,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = nil,
              directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules', '-scripts', '-infrastructure' },
              semanticTokens = true,
            },
          },
          on_attach = function(_, bufnr)
            vim.keymap.set('n', '<leader>ct', '', { desc = '[C]ode [T]ags' })
            vim.keymap.set('n', '<leader>cta', function()
              local tags = vim.fn.input('Enter tags (e.g. json xml): ', 'json')
              if tags ~= '' then
                vim.cmd('GoAddTags ' .. tags)
              end
            end, { desc = 'LSP: [C]ode [T]ags, [A]dd' })
            vim.keymap.set('n', '<leader>ctr', ':GoRemoveTags<CR>', { desc = 'LSP: [C]ode [T]ags, [R]emove' })
            vim.keymap.set('n', '<leader>co', function()
              vim.lsp.buf.code_action { apply = true, context = { only = { 'source.organizeImports' }, diagnostics = {} } }
            end, { desc = 'LSP: [C]ode [O]rganize Imports' })

            vim.api.nvim_create_autocmd('BufWritePre', {
              callback = function()
                -- lsp_organize_imports(bufnr)
              end,
            })
          end,
        },

        vtsls = {
          settings = {
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = {
                completeFunctionCalls = true,
              },
              preferences = {
                importModuleSpecifier = 'non-relative',
                quoteStyle = 'single',
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
                includeInlayVariableTypeHints = { enable = true },
              },
            },
          },
          on_attach = function(_, bufnr)
            vim.keymap.set('n', '<leader>co', function()
              vim.lsp.buf.code_action { apply = true, context = { only = { 'source.organizeImports' }, diagnostics = {} } }
            end, { desc = 'LSP: [C]ode [O]rganize Imports' })

            vim.keymap.set('n', '<leader>cM', function()
              vim.lsp.buf.code_action { apply = true, context = { only = { 'source.addMissingImports.ts' }, diagnostics = {} } }
            end, { desc = 'LSP: [C]ode add [M]issing imports' })
          end,
        },

        yamlls = {
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          -- root_dir = function(bufnr, on_dir)
          --   local parent = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
          --   if not (vim.endswith(parent, '/.github/workflows') or vim.endswith(parent, '/.forgejo/workflows') or vim.endswith(parent, '/.gitea/workflows')) then
          --     on_dir(parent)
          --   end
          -- end,
        },

        gh_actions_ls = {},
        pyright = {},

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code

        -- Typescript
        'vtsls', -- Typescript LSP wrapper around tl_ls
        'prettierd', -- Prettier Daemonized
        'eslint', -- Eslint LSP instead of eslint_d

        -- GO
        'gopls', -- GO LSP
        -- 'gofumpt', -- Auto formatter to be used with Conform
        -- 'goimports', -- Automatic import organizer
        'golangci-lint',
        'gotestsum', -- Improve readability on go test output
        'gomodifytags', -- Automatic add json tags to structs

        -- Python
        'pyright', -- Python LSP

        -- YAML
        'yamlls',
        'gh-actions-language-server',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed, run_on_start = true }

      require('mason-lspconfig').setup {
        automatic_enable = {},
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer
        automatic_installation = false,
      }

      -- local lspconfig = require 'lspconfig'
      for server_name, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
        -- lspconfig[server_name].setup(config)
        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
      end
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
