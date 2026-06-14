local containers = require("custom.config.keymap-containers")

vim.pack.add({"https://github.com/sQVe/sort.nvim"})
require("sort").setup({})

vim.keymap.set("v", containers.code.key .. "s", "<cmd>Sort<cr>", {desc="[s]ort"} )

return {}

