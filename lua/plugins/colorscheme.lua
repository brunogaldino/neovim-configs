return {
  {
    "rebelot/kanagawa.nvim",
    opts = {
      -- compile = true, -- Call :KanagawaCompile after any changes
      transparent = false,
      dimInactive = false,

      -- theme = "wave", -- Load "wave" theme
      -- background = { -- map the value of 'background' option to a theme
      --   dark = "wave",
      --   light = "lotus",
      -- },

      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      -- overrides = function(colors)
      --   local theme = colors.theme
      --   return {
      --     -- Float windows
      --     NormalFloat = { bg = "none" },
      --     FloatBorder = { bg = "none" },
      --     FloatTitle = { bg = "none" },
      --     NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
      --     LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
      --     MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
      --
      --     -- Proper transparency
      --     Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
      --     PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      --     PmenuSbar = { bg = theme.ui.bg_m1 },
      --     PmenuThumb = { bg = theme.ui.bg_p2 },
      --   }
      -- end,
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "kanagawa",
        callback = function()
          vim.api.nvim_set_hl(0, "StatusLine", { link = "lualine_c_normal" })
        end,
      })
    end,
  },

  { "EdenEast/nightfox.nvim" },

  -- {
  --   "sainnhe/gruvbox-material",
  --   enabled = true,
  --   -- dependencies = { "saghen/blink.cmp" },
  --   priority = 1000,
  --   config = function()
  --     vim.g.gruvbox_material_transparent_background = 0
  --     vim.g.gruvbox_material_foreground = "mix"
  --     vim.g.gruvbox_material_background = "hard"
  --     vim.g.gruvbox_material_ui_contrast = "high"
  --     vim.g.gruvbox_material_float_style = "dim"
  --     vim.g.gruvbox_material_statusline_style = "material"
  --     vim.g.gruvbox_material_cursor = "auto"
  --
  --     -- vim.g.gruvbox_material_colors_override = { bg0 = '#16181A' } -- #0e1010
  --     vim.g.gruvbox_material_better_performance = 1
  --
  --     vim.cmd.colorscheme("gruvbox-material")
  --   end,
  -- },

  -- {
  --   "akinsho/bufferline.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     options = {
  --       buffer_close_icon = "󰅖",
  --     },
  --   },
  -- },

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "kanagawa",
      colorscheme = "carbonfox",
      -- colorscheme = "gruvbox-material",
      -- colorscheme = "catppuccin-macchiato",
    },
  },
}
