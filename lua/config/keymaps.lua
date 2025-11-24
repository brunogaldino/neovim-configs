-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local keymap = vim.keymap.set
local opts = { silent = true }

keymap("n", "<C-.>", "<cmd> lua vim.lsp.buf.code_action()<CR>", opts)
