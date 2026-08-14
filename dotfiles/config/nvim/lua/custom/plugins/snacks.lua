vim.pack.add({
  "https://github.com/folke/snacks.nvim"
})


local containers = require 'custom.config.keymap-containers'

vim.keymap.set('n', containers.open.key .. 's', function() require("snacks").scratch() end, { desc = '[s]cratchpad toggle' })
vim.keymap.set('n', containers.open.key .. 'S', function() require("snacks").scratch.select() end, { desc = '[S]cratchpad select' })

