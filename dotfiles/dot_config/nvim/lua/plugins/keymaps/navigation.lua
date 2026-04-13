-- Nvchad has some mappings we dont want to keep.
--
--
vim.keymap.del({"n"}, "<leader>h")

vim.keymap.del({"n"}, "<leader>v")

vim.keymap.del({"n"}, "<leader>x")
-- Exit Neovim completely without saving when press Alt+Q
vim.keymap.set({"n", "x", "i", "v"}, "<A-q>", ":qa!<CR>", { noremap = true, silent = true, desc = "Quit all without saving" })

-- Navigate jump list (previous/next location)
-- Alt+h or Alt+Left to go back
vim.keymap.set("n", "<A-h>", "<C-o>", { noremap = true, silent = true, desc = "Jump to previous location" })
vim.keymap.set("n", "<A-Left>", "<C-o>", { noremap = true, silent = true, desc = "Jump to previous location" })

-- Alt+l or Alt+Right to go forward
vim.keymap.set("n", "<A-l>", "<C-i>", { noremap = true, silent = true, desc = "Jump to next location" })
vim.keymap.set("n", "<A-Right>", "<C-i>", { noremap = true, silent = true, desc = "Jump to next location" })



vim.keymap.set("n", "<leader>-", function()
  vim.cmd("split")
end, { desc = "Horizontal split" })

vim.keymap.set("n", "<leader>|", function()
  vim.cmd("vsplit")
end, { desc = "Vertical split" })


return {}
