-- To vizualise json and yaml stuff.
local containers = require 'custom.config.keymap-containers'

vim.pack.add {
          "https://github.com/Owen-Dechow/graph_view_yaml_parser", -- Optional: add YAML support
        "https://github.com/Owen-Dechow/graph_view_toml_parser", -- Optional: add TOML support
        "https://github.com/a-usr/xml2lua.nvim", -- Optional | Experimental: add XML support
  'https://github.com/Owen-Dechow/videre.nvim'
}

require('videre').setup {}
vim.keymap.set('n', containers.open.key .. 'v', '<cmd>Videre<cr>', { desc = '[V]iz yaml or json' })
