return {
  "saghen/blink.cmp",
  dependencies = { "onsails/lspkind.nvim" },
  opts = {
    keymap = {
      ["<c-x>"] = { "show_signature", "hide_signature", "fallback" },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    completion = {
      menu = {
        winhighlight = "Normal:None,FloatBorder:None,CursorLine:CursorLine,Search:None",
        border = "rounded",
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "label", gap = 1 },
            { "kind_icon", "kind" },
          },
          components = {
            kind_icon = {
              text = function(item)
                local kind = require("lspkind").symbol_map[item.kind] or ""
                return kind .. " "
              end,
            },
            label = {
              text = function(item)
                return item.label
              end,
            },
            kind = {
              text = function(item)
                return item.kind
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        treesitter_highlighting = true,
        window = {
          border = "rounded",
          winhighlight = "Normal:None,FloatBorder:None,EndOfBuffer:BlinkCmpDoc,NormalFloat:None",
        },
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },
    -- sources = {
    --   default = { "lsp", "path", "snippets", "buffer" },
    --   providers = {
    --     lsp = {
    --       min_keyword_length = 2, -- Number of characters to trigger porvider
    --       score_offset = 0, -- Boost/penalize the score of the items
    --     },
    --     path = {
    --       min_keyword_length = 0,
    --     },
    --     snippets = {
    --       min_keyword_length = 2,
    --     },
    --     buffer = {
    --       min_keyword_length = 5,
    --       max_items = 5,
    --     },
    --   },
    -- },
  },
}
