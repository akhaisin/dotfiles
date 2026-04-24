-- Keymaps are loaded on the VeryLazy event
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- ── VSCode-like shortcuts ─────────────────────────────────────────────────────

-- Save from any mode (Ctrl+S)
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- File picker (Ctrl+P → like VSCode)
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })

-- Live grep across project (Ctrl+Shift+F → terminal sends Ctrl+F, use leader as fallback)
-- <leader>sg is LazyVim default; add <C-f> as an alias for normal mode
map("n", "<C-f>", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })

-- Toggle file explorer (Ctrl+B → like VSCode sidebar)
map("n", "<C-b>", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })

-- Comment toggle (Ctrl+/ in terminal sends Ctrl+_ = 0x1F)
map("n", "<C-_>", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<C-_>", "gc", { desc = "Toggle Comment", remap = true })

-- Close current buffer (like VSCode Ctrl+W closes a tab)
map("n", "<leader>bx", "<cmd>bd<cr>", { desc = "Close Buffer" })

-- ── lazygit ───────────────────────────────────────────────────────────────────

map("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "Lazygit" })
