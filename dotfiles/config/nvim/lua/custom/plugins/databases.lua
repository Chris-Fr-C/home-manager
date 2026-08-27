vim.pack.add({
	"https://github.com/tpope/vim-dadbod",
	"https://github.com/kristijanhusak/vim-dadbod-ui",
})


local containers = require("custom.config.keymap-containers")

vim.keymap.set("n", containers.open.key .. "dd", "<cmd>DBUIToggle<cr>", {desc="[d]atabase toggle"})
vim.keymap.set("n", containers.open.key .. "dn", "<cmd>DBUIAddConnection<cr>", {desc="[n]ew connection"})
