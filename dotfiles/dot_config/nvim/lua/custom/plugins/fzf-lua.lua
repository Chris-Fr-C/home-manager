local containers = require("custom.config.keymap-containers")
local style = require("custom.config.style")

vim.pack.add({
	-- Optional dep:
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/ibhagwan/fzf-lua",
})

local fzf = require("fzf-lua")
fzf.setup({
	winopts = {
		-- Adding a border helps separate the overlapping text visually
		border = style.border_style,
	},
})

vim.keymap.set("n", containers.find.key .. "f", function()
	fzf.files()
end, { desc = "[f]ile" })
vim.keymap.set("n", containers.root.key .. "<leader><leader>", function()
	fzf.files()
end, { desc = "[f]ile" })

vim.keymap.set('n', containers.find.key .. 'b', fzf.buffers, { desc = 'Find existing [b]uffers' })

vim.keymap.set("n", containers.find.key .. "w", function()
	fzf.grep_cWORD()
end, { desc = "[w]ord" })

return {}
