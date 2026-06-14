return {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre', -- uncomment for format on save
		opts = require("configs.conform"),
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig") -- Loads NvChad defaults
			require("configs.lspconfig") -- Loads YOUR file (lua/configs/lspconfig.lua)
		end,
	},
	{ import = "plugins.chris-fr-c.keymaps" },
	{ import = "plugins.chris-fr-c.git" },
	{ import = "plugins.chris-fr-c.panels" },
	{ import = "plugins.chris-fr-c.navigation" },
	{ import = "plugins.chris-fr-c.code" },
	{ import = "plugins.chris-fr-c.lsp" },

	-- test new blink
	-- { import = "nvchad.blink.lazyspec" },

	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	opts = {
	-- 		ensure_installed = {
	-- 			"vim", "lua", "vimdoc",
	--      "html", "css"
	-- 		},
	-- 	},
	-- },
}
