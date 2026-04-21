-- prompt for a refactor to apply when the remap is triggered.
vim.keymap.set({ "n", "x" }, "<leader>rr", function()
	require("refactoring").select_refactor()
end)

--
-- Moving line up and down.
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- And for visual mode.
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
return {}
