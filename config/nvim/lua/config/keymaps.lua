-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "df", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gd", "<nop>", {})
