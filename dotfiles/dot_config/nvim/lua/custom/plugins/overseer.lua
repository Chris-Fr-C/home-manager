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
vim.keymap.set("n",containers.build.key .. "t", "<cmd>OverseerToggle<cr>", {desc="[t]oggle task"})
vim.keymap.set("n",containers.build.key .. "s", "<cmd>OverseerShell<cr>", {desc="[s]hell"})
vim.keymap.set("n",containers.build.key .. "r", "<cmd>OverseerRun<cr>", {desc="[r]un"})
vim.keymap.set("n",containers.build.key .. "a", "<cmd>OverseerTaskAction<cr>", {desc="[a]ction"})
vim.keymap.set("n",containers.build.key .. "i", "<cmd>OverseerInfo<cr>", {desc="[i]nfo"})


return {}
