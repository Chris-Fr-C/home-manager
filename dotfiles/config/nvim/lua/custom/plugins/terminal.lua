local containers = require 'custom.config.keymap-containers'

vim.pack.add { 'https://github.com/akinsho/toggleterm.nvim' }
local toggleterm = require 'toggleterm'
toggleterm.setup {}
vim.keymap.set('n', containers.open.key .. 't', function()  toggleterm.toggle(1) end, { desc = '[t]erminal toggle' })
