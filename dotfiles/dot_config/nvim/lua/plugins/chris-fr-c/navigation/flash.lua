-- Equivalent of surround, to quickly move accross  things.
return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			-- labels = "abcdefghijklmnopqrstuvwxyz",
			labels = "asdfghjkliqw",
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			-- The following would conflict with blink
			-- {
			--   "<c-s>",
			--   mode = { "c" },
			--   function()
			--     require("flash").toggle()
			--   end,
			--   desc = "Toggle Flash Search",
			-- },
		},
	},
}
