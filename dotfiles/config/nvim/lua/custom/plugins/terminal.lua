local containers = require 'custom.config.keymap-containers'

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Terminal mappings under <leader>t
map("n", "<leader>tj", ":belowright split | terminal<CR>", vim.tbl_extend("force", opts, { desc = "Terminal (Bottom)" }))
map("n", "<leader>tk", ":aboveleft split | terminal<CR>",  vim.tbl_extend("force", opts, { desc = "Terminal (Top)" }))
map("n", "<leader>th", ":leftabove vsplit | terminal<CR>", vim.tbl_extend("force", opts, { desc = "Terminal (Left)" }))
map("n", "<leader>tl", ":rightbelow vsplit | terminal<CR>", vim.tbl_extend("force", opts, { desc = "Terminal (Right)" }))
map("n", "<leader>tt", ":tabnew | terminal<CR>",           vim.tbl_extend("force", opts, { desc = "Terminal (New Tab)" }))
