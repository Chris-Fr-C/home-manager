-- lazy.nvim
return { {
  lazy=false,
  "johnpmitsch/vai.nvim",
  config = function()
    require("vai").setup({ trigger = "qq", keys = "asdfewqh" })
  end,
},


  {"tpope/vim-obsession"},
  {  "max397574/better-escape.nvim",
  lazy = false,
  config = function()
    require("better_escape").setup({
      -- Add your custom configuration here if needed
      -- For example:
      mappings = {
        i = {
          j = { j = "<Esc>", k = "<Esc>" },
        },
      },
    })
  end,
  },

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
