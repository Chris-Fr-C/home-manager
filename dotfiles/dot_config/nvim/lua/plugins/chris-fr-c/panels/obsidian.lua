return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "Axpo",
				path = vim.fn.expand("~/ObsidianVault/Axpo"),
				overrides = {
					daily_notes = {
						-- Optional, if you keep daily notes in a separate directory.
						folder = "Daily",
						-- Optional, if you want to change the date format for the ID of daily notes.
						date_format = "%Y-%m-%d",
						-- Optional, if you want to change the date format of the default alias of daily notes.
						-- alias_format = "%B %-d, %Y",
						-- Optional, default tags to add to each new daily note created.
						default_tags = { "daily" },
						-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
						template = "Templates/Daily notes template.md",
					},
				},
			},
			-- {
			-- 	name = "work",
			-- 	path = "~/vaults/work",
			-- },
		},
	},

	keys = {
		{
			"<leader>no",
			function()
				require("lazy").load({ plugins = { "obsidian.nvim" } })
				vim.cmd("ObsidianNew")
			end,
			desc = "Obsidian: new note",
		},
		{
			"<leader>ns",
			function()
				require("lazy").load({ plugins = { "obsidian.nvim" } })
				vim.cmd("ObsidianSearch")
			end,
			desc = "Obsidian: search notes",
		},
		{
			"<leader>nt",
			function()
				require("lazy").load({ plugins = { "obsidian.nvim" } })
				vim.cmd("ObsidianToday")
			end,
			desc = "Obsidian: today note",
		},
		{
			"<leader>na",
			function()
				require("lazy").load({ plugins = { "obsidian.nvim" } })
				vim.cmd("ObsidianLink")
			end,
			desc = "Obsidian: link note",
		},
		{
			"<leader>nf",
			function()
				require("lazy").load({ plugins = { "obsidian.nvim" } })
				vim.cmd("ObsidianFollowLink")
			end,
			desc = "Obsidian: follow link",
		},
		{
			"<leader>nb",
			function()
				require("lazy").load({ plugins = { "obsidian.nvim" } })
				vim.cmd("ObsidianBacklinks")
			end,
			desc = "Obsidian: backlinks",
		},
		{
			"<leader>nw",
			function()
				require("lazy").load({ plugins = { "obsidian.nvim" } })
				vim.cmd("ObsidianWorkspace")
			end,
			desc = "Obsidian: switch workspace",
		},
	},
}
