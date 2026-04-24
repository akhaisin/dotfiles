-- Options are loaded before lazy.nvim startup
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.relativenumber = false  -- absolute line numbers (VSCode default)
vim.opt.scrolloff = 8           -- keep context lines when scrolling
vim.opt.sidescrolloff = 8
vim.opt.cursorline = true       -- highlight current line

-- Indent: 2 spaces (matches common VSCode defaults for web/TS/Lua)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Keep sign column always visible (avoids layout shifts on diagnostics)
vim.opt.signcolumn = "yes"
