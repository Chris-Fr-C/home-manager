return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		preset = "helix",
		spec = {
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git" },
			{ "<leader>o", group = "Tasks (Overseer)" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>m", group = "Marks" },
			{ "<leader>r", group = "Refactor" },
			{ "<leader>S", group = "Setup" },
		},
	},
	-- keys = {
	-- 	{
	-- 		"<leader>?",
	-- 		function()
	-- 			require("which-key").show({ global = false })
	-- 		end,
	-- 		desc = "Buffer Local Keymaps (which-key)",
	-- 	},
	-- },
}
