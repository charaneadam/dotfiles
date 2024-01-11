-- Saving
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- Move lines
vim.keymap.set("n", "<M-j>", ":m .+1<CR>")
vim.keymap.set("n", "<M-k>", ":m .-2<CR>")
vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>")
vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>")
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>")

-- Move between windows
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")

-- Terminal
vim.keymap.set("n", "<M-/>", ":ToggleTerm 1 direction=float<CR>")
vim.keymap.set("t", "<M-/>", "<C-\\><C-n>:ToggleTerm 1 direction=float<CR>")
vim.keymap.set("n", "<M-.>", ":ToggleTerm 2 direction=horizontal<CR>")
vim.keymap.set("t", "<M-.>", "<C-\\><C-n>:ToggleTerm 2 direction=horizontal<CR>")
-- vim.keymap.set("n", "<M-,>", ":ToggleTerm direction=vertical<CR>")
-- vim.keymap.set("t", "<M-,>", "<C-\\><C-n>:ToggleTerm direction=vertical<CR>")

vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>")

vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
