vim.pack.add({  "https://github.com/hedyhli/outline.nvim"})


-- Configure outline.nvim to open on the right
require("outline").setup({
  outline_window = {
    position = "right",
    width = 30,
  },
})

local containers = require("custom.config.keymap-containers")

-- Toggle LSP Outline on the right
vim.keymap.set("n", containers.code.key .. "o", "<cmd>Outline<CR>", {
  desc = "Toggle LSP [o]utline Sidebar",
  silent = true,
})
vim.keymap.set("n", containers.find.key .. "c", function()
  require("telescope.builtin").lsp_document_symbols()
end, { desc = "[c]ode search" })
