-- Capture the returned table of prefix variables
local containers = require 'custom.config.keymap-containers'

local core = require("custom.config.core")
-- Save
vim.keymap.set('n', '<C-s>', function()
  vim.cmd 'w!'
  core.notify("Saved", "Saved file", "INFO", "virtualtext")
end, { desc = '[S]ave (force)' })

-- Concatenate the prefix with "u" (Resulting in for example '<leader>cu')
vim.keymap.set('n', containers.config_vim.key .. 'u', function() vim.pack.update() end, { desc = '[U]pdate vim.pack packages' })

-- Quit shortcuts
vim.keymap.set('n', containers.quit.key .. 'a', '<cmd>qa!<cr>', { desc = '[a]ll' })
vim.keymap.set('n', containers.quit.key .. 'b', '<cmd>q!<cr>', { desc = '[b]uffer' })
vim.keymap.set('n', containers.quit.key .. 'q', '<cmd>qa!<cr>', { desc = '[q]uit vim' })
vim.keymap.set('n', containers.quit.key .. 'o', '<cmd>only!<cr>', { desc = '[o]thers' })

-- Root shortcuts:
vim.keymap.set('n', '<C-q>', '<cmd>q!<cr>', { desc = '[b]uffer' })
vim.keymap.set('n', '<A-q>', '<cmd>qa!<cr>', { desc = '[a]ll' })
vim.keymap.set('n', '<leader>-', '<cmd>split<cr>', { desc = 'Horizontal split' })
vim.keymap.set('n', '<leader>|', '<cmd>vsplit<cr>', { desc = 'Vertical split' })

-- Global search (forward + backward) using 'f'
vim.keymap.set({ 'n', 'x', 'o' }, 'f', function() require('flash').jump() end, { desc = 'Flash Jump (Forward/Backward)' })

--  Map 'F' to do a Treesitter scope jump if i want to reuse the key
vim.keymap.set({ 'n', 'x', 'o' }, 'F', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })

local fzf=require("fzf-lua")
vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })

return {}
