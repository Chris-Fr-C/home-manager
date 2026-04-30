-- snacks livegrep is bugged on 0.12 as it changed cursor to init when writing./
return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({})
		end,
	},
}
