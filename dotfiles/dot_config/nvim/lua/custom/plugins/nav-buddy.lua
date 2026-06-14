local containers = require("custom.config.keymap-containers")

vim.pack.add {
  'https://github.com/SmiteshP/nvim-navic',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/SmiteshP/nvim-navbuddy',
}

local navbuddy = require 'nvim-navbuddy'
navbuddy.setup({lsp={auto_attach=true}})


vim.keymap.set("n", containers.open.key .. "n", navbuddy.open, {desc="[n]avbuddy"}) 
vim.keymap.set("n", containers.root.key .. "Q", navbuddy.open, {desc="navbuddy"}) 
