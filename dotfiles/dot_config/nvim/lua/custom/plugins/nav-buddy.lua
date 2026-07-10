local containers = require("custom.config.keymap-containers")

vim.pack.add {
  'https://github.com/SmiteshP/nvim-navic',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/SmiteshP/nvim-navbuddy',
}

local navbuddy = require 'nvim-navbuddy'
navbuddy.setup({lsp={auto_attach=true}})


vim.keymap.set("n", containers.root.key .. "<C-q>", navbuddy.open, {desc="navbuddy"})
