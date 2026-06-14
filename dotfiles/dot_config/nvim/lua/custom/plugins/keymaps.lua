-- Capture the returned table of prefix variables
local containers = require 'custom.config.keymap-containers'
-- Save
vim.keymap.set('n', '<C-s>', '<cmd>w!<cr>', { desc = '[S]ave (force)' })

-- Concatenate the prefix with "u" (Resulting in for example '<leader>cu')
vim.keymap.set('n', containers.config_vim.key .. 'u', function() vim.pack.update() end, { desc = '[U]pdate vim.pack packages' })

-- Root shortcuts:
vim.keymap.set('n', containers.quit.key .. 'b', '<cmd>q!<cr>', { desc = '[b]uffer' })
vim.keymap.set('n', containers.quit.key .. 'a', '<cmd>qa!<cr>', { desc = '[a]ll' })
vim.keymap.set('n', containers.quit.key .. 'q', '<cmd>qa!<cr>', { desc = '[q]uit vim' })
vim.keymap.set('n', containers.quit.key .. 'o', '<cmd>only!<cr>', { desc = '[o]thers' })

return {}
