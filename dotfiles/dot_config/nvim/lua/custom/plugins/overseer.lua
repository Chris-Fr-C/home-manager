local containers = require("custom.config.keymap-containers")


vim.pack.add { 'https://github.com/stevearc/overseer.nvim' }
require("overseer").setup({})
-- require('overseer').setup {
--   dap = false,
--   templates = {
--     'builtin',
--     'task',
--   },
--   task_list = {
--     bindings = {
--       ['<C-h>'] = false,
--       ['<C-j>'] = false,
--       ['<C-k>'] = false,
--       ['<C-l>'] = false,
--     },
--   },
--   form = {
--     win_opts = {
--       winblend = 0,
--     },
--   },
--   confirm = {
--     win_opts = {
--       winblend = 0,
--     },
--   },
--   task_win = {
--     win_opts = {
--       winblend = 0,
--     },
--   },
-- }
--
vim.keymap.set("n",containers.build.key .. "t", "<cmd>OverseerToggle<cr>", {desc="[t]ask"})
vim.keymap.set("n",containers.build.key .. "r", "<cmd>OverseerRun<cr>", {desc="[r]un"})
vim.keymap.set("n",containers.build.key .. "b", "<cmd>OverseerBuild<cr>", {desc="[b]uild"})
vim.keymap.set("n",containers.build.key .. "c", "<cmd>OverseerClearCache<cr>", {desc="[c]lear cache"})
vim.keymap.set("n",containers.build.key .. "i", "<cmd>OverseerInfo<cr>", {desc="[i]nfo"})


return {}
