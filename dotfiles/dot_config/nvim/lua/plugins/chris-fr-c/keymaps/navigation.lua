-- Exit Neovim completely without saving when press Alt+Q
vim.keymap.set("n", "<A-q>", ":qa!<CR>", { noremap = true, silent = true, desc = "Quit all without saving" })

-- Navigate jump list (previous/next location)
-- Alt+h or Alt+Left to go back
vim.keymap.set("n", "<A-h>", "<C-o>", { noremap = true, silent = true, desc = "Jump to previous location" })
vim.keymap.set("n", "<A-Left>", "<C-o>", { noremap = true, silent = true, desc = "Jump to previous location" })

-- Alt+l or Alt+Right to go forward
vim.keymap.set("n", "<A-l>", "<C-i>", { noremap = true, silent = true, desc = "Jump to next location" })
vim.keymap.set("n", "<A-Right>", "<C-i>", { noremap = true, silent = true, desc = "Jump to next location" })
-- Next buffer (Shift + Right)
vim.keymap.set("n", "<S-Right>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
-- Previous buffer (Shift + Left)
vim.keymap.set("n", "<S-Left>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
return {}
