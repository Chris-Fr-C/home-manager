local containers = require("custom.config.keymap-containers")

vim.pack.add({
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/antoinemadec/FixCursorHold.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-neotest/neotest",

	-- Language specifics
	"https://github.com/nvim-neotest/neotest-python",
	"https://github.com/alfaix/neotest-gtest",
})

local neotest = require("neotest")
neotest.setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
		}),
	},
})
vim.keymap.set("n", containers.open.key .. "T", function() 
	neotest.summary.toggle()
end , { desc = "[T]ests" })


return {}
