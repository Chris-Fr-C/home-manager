local containers = require 'custom.config.keymap-containers'


vim.pack.add({"https://github.com/kdheepak/lazygit.nvim"})


vim.keymap.set('n', containers.git.key .. 'g', '<cmd>LazyGit<cr>', { desc = '[g]it (lazy)' })

return {}
