local containers = require("custom.config.keymap-containers")

vim.pack.add({
  "https://github.com/kkoomen/vim-doge",
})

local function install_doge()
  vim.fn['doge#install']()
end
vim.g.doge_enable_mappings = 0

-- You can expose it as a user command so you can just type `:DogeInstall`
vim.api.nvim_create_user_command('DogeInstall', function()
  vim.fn['doge#install']()
  print("Vim-Doge dependencies installed.")
end, {})



-- Generate comment for current line
vim.keymap.set('n', containers.generate.key .. "d", '<Plug>(doge-generate)', {desc="[d]ocumentation"})

-- Interactive mode comment todo-jumping
vim.keymap.set('n', containers.root.key .. '<TAB>', '<Plug>(doge-comment-jump-forward)')
vim.keymap.set('n', containers.root.key .. '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
vim.keymap.set('i', containers.root.key .. '<TAB>', '<Plug>(doge-comment-jump-forward)')
vim.keymap.set('i', containers.root.key .. '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
vim.keymap.set('x', containers.root.key .. '<TAB>', '<Plug>(doge-comment-jump-forward)')
vim.keymap.set('x', containers.root.key .. '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
