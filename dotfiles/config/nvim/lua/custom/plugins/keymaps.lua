local containers = require 'custom.config.keymap-containers'

local core = require("custom.config.core")
-- Save
vim.keymap.set('n', '<C-s>', function()
  vim.cmd 'w!'
  core.notify("Saved", "Saved file", "INFO", "virtualtext")
end, { desc = '[S]ave (force)' })

-- Concatenate the prefix with "u" (Resulting in for example '<leader>cu')
vim.keymap.set('n', containers.config_vim.key .. 'u', function() vim.pack.update() end, { desc = '[U]pdate vim.pack packages' })
vim.keymap.set('n', containers.config_vim.key .. 'r', ":source $MYVIMRC<CR>", { desc = '[r]eload' })



-- Quit shortcuts
vim.keymap.set('n', containers.quit.key .. 'a', '<cmd>qa!<cr>', { desc = '[a]ll' })
vim.keymap.set('n', containers.quit.key .. 'b', '<cmd>q!<cr>', { desc = '[b]uffer' })
vim.keymap.set('n', containers.quit.key .. 'q', '<cmd>qa!<cr>', { desc = '[q]uit vim' })
vim.keymap.set('n', containers.quit.key .. 'o', '<cmd>only!<cr>', { desc = '[o]thers' })

-- Root shortcuts:
vim.keymap.set('n', containers.root.key .. '<C-q>', '<cmd>q!<cr>', { desc = '[b]uffer' })
vim.keymap.set('n', containers.root.key .. '<A-q>', '<cmd>qa!<cr>', { desc = '[a]ll' })
vim.keymap.set('n', containers.root.key .. '<leader>-', '<cmd>split<cr>', { desc = 'Up/Down split' })
vim.keymap.set('n', containers.root.key .. '<leader>|', '<cmd>vsplit<cr>', { desc = 'Left/Right split' })

-- Global search (forward + backward) using 'f'
vim.keymap.set({ 'n', 'x', 'o' }, containers.root.key ..'f', function() require('flash').jump() end, { desc = 'Flash Jump (Forward/Backward)' })

--  Map 'F' to do a Treesitter scope jump if i want to reuse the key
vim.keymap.set({ 'n', 'x', 'o' }, containers.root.key ..'F', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })


vim.keymap.set('n', containers.buffer.key .. 'l', '<cmd>vsplit<cr>', { desc = 'Left/Right split' })
vim.keymap.set('n', containers.buffer.key .. 'j', '<cmd>split<cr>', { desc = 'Up/Down split' })
vim.keymap.set('n', containers.buffer.key .. 'n', '<cmd>enew<cr>', { desc = '[n]ew buffer' })
vim.keymap.set('n', containers.buffer.key .. 't', '<cmd>tabnew<cr>', { desc = '[t]ab' })

-- Recording with q is super annoying so changing it.
-- Deactivate 'q' from recording macros
vim.keymap.set('n', containers.root.key .. 'q', '<Nop>', { desc = 'Disable default macro recording' })
vim.keymap.set('n', containers.root.key .. '<C-A-r>', 'q', { desc = 'Record macro' })

-- Clipboard is annoying when pasting. Only using X to cut.
-- Remap 'd' (and visual 'd') to delete to the blackhole register
vim.keymap.set({'n', 'v'}, 'd', '"_d', { noremap = true })
vim.keymap.set({'n', 'v'}, 'D', '"_D', { noremap = true })
vim.keymap.set({'n', 'v'}, 'dd', '"_dd', { noremap = true })

-- Ensure 'x' explicitly cuts to the system clipboard / default register
vim.keymap.set({'n', 'v'}, 'x', '""x', { noremap = true })

-- Buffer navigation
-- -- Navigate buffers using Shift + H and Shift + L
vim.keymap.set('n', containers.root.key .. 'H', ':bprevious<CR>', { silent = true, desc="Previous buffer" })
vim.keymap.set('n', containers.root.key .. 'L', ':bnext<CR>', { silent = true, desc="Next buffer"})

-- Tab navigation
vim.keymap.set('n', containers.root.key .. '<Tab>', ':tabnext<CR>', { silent = true, desc="Next tab"})
vim.keymap.set('n', containers.root.key .. '<S-Tab>', ':tabprevious<CR>', { silent = true, desc="Previous tab"})

return {}
