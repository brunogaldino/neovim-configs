-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.g.loaded_netrw = 1 -- disable netrw
vim.g.loaded_netrwPlugin = 1 --  disable netrw

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.o.showmode = false -- Don't show the mode, since it's already in the status line
vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.smartcase = true
vim.o.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.updatetime = 100 -- Decrease update time (4000ms default)
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.o.splitright = true -- Configure how new splits should be opened
vim.o.splitbelow = true
vim.o.wrap = false -- display lines as one long line
vim.o.incsearch = true -- make search act like search in modern browsers
vim.o.backup = false -- creates a backup file
vim.o.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.o.cursorline = true -- Show which line your cursor is on
vim.o.conceallevel = 0 -- so that `` is visible in markdown files
vim.o.fileencoding = 'utf-8' -- the encoding written to a file
vim.o.hlsearch = true -- highlight all matches on previous search pattern
-- vim.o.showtabline = 1 -- always show tabs
vim.o.smartindent = true -- make indenting smarter again
vim.o.swapfile = false -- creates a swapfile
vim.o.termguicolors = true -- set term gui colors (most terminals support this)
vim.o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.inccommand = 'split' -- Preview substitutions live, as you type!
vim.o.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.o.showcmd = false -- Don't show the command in the last line
vim.o.ruler = false -- Don't show the ruler

--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true -- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- Sets how neovim will display certain whitespace characters in the editor.

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Nice and simple folding:
vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = 'expr'
vim.o.foldtext = ''
vim.opt.foldcolumn = '0'

-- Default to treesitter folding
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

--
-- vim.opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
-- vim.opt.pumheight = 10 -- pop up menu height
-- vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
-- vim.opt.expandtab = true -- convert tabs to spaces
-- vim.o.tabstop = 2 -- A TAB character looks like 4 spaces
-- vim.opt.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
-- vim.opt.shiftwidth = 2 -- Number of spaces inserted when indenting
-- vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
-- vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
-- vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
-- vim.opt.scrolloff = 8 -- Makes sure there are always eight lines of context
-- vim.opt.sidescrolloff = 8 -- Makes sure there are always eight lines of context
-- vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
-- vim.opt.title = true -- set the title of window to the value of the titlestring
-- vim.opt.confirm = true -- confirm to save changes before exiting modified buffer

-- vim: ts=2 sts=2 sw=2 et
