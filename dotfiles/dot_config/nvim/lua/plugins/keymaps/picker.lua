-- FILES
vim.keymap.set("n", "<leader>ff", function()
  require("fzf-lua").files()
end, { desc = "Find files" })

-- SPACE SPACE → file search
vim.keymap.set("n", "<leader><leader>", function()
  require("fzf-lua").files()
end, { desc = "Find files" })

-- LIVE GREP
vim.keymap.set("n", "<leader>fg", function()
  require("fzf-lua").live_grep()
end, { desc = "Live grep" })

-- BUFFERS
vim.keymap.set("n", "<leader>fb", function()
  require("fzf-lua").buffers()
end, { desc = "Buffers" })

-- RECENT FILES
vim.keymap.set("n", "<leader>fr", function()
  require("fzf-lua").oldfiles()
end, { desc = "Recent files" })

-- GIT FILES
vim.keymap.set("n", "<leader>fG", function()
  require("fzf-lua").git_files()
end, { desc = "Git files" })


return {}

