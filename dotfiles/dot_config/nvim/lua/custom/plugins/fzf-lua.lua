local containers = require 'custom.config.keymap-containers'

vim.pack.add {
  -- Optional dep:
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/ibhagwan/fzf-lua',
}

local fzf = require 'fzf-lua'
vim.keymap.set('n', containers.find.key .. 'f', function() fzf.files() end, { desc = '[f]ile' })
vim.keymap.set('n', containers.find.key .. 'w', function() fzf.grep_cWORD() end, { desc = '[w]ord' })

return {}
