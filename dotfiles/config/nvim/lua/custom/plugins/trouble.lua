local containers = require("custom.config.keymap-containers")
vim.pack.add({"https://github.com/folke/trouble.nvim"})

require("trouble").setup({})

vim.keymap.set("n",containers.diagnostic.key .. "t", "<cmd>Trouble diagnostics toggle<cr>", {desc="[t]oggle"})
vim.keymap.set("n",containers.diagnostic.key .. "b", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {desc="open in [b]uffer"})
vim.keymap.set("n",containers.diagnostic.key .. "l", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", {desc="[l]sp definition"})
vim.keymap.set("n",containers.diagnostic.key .. "L", "<cmd>Trouble loclist toggle<cr>", {desc="[L]oclist toggle"})
vim.keymap.set("n",containers.diagnostic.key .. "q", "<cmd>Trouble qflist toggle<cr>", {desc="[q]uick list toggle"})


return {}
