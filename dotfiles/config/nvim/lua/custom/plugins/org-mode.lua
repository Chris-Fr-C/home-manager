-- https://nvim-orgmode.github.io/plugins.html
vim.pack.add({
	"https://github.com/nvim-orgmode/orgmode",

	-- bullets
	"https://github.com/nvim-orgmode/org-bullets.nvim",

	-- Org roam
	"https://github.com/chipsenkbeil/org-roam.nvim",

	-- Table mode
	"https://github.com/dhruvasagar/vim-table-mode",

	-- For agenda
	"https://github.com/danilshvalov/org-modern.nvim",

	-- Super agenda
	"https://github.com/hamidi-dev/org-super-agenda.nvim",

	-- Org telescope
	"https://github.com/nvim-orgmode/telescope-orgmode.nvim",
})

local containers = require("custom.config.keymap-containers")
require("org-bullets").setup()
require("org-super-agenda").setup({})

local Menu = require("org-modern.menu")

-- Check if a local project config exists in the current directory
local has_local_config = vim.fn.filereadable(".nvim.lua") == 1

-- if not has_local_config then
require("orgmode").setup({
	org_agenda_files = "~/orgfiles/**/*",
	org_default_notes_file = "~/orgfiles/refile.org",

	ui = {
		menu = {
			handler = function(data)
				Menu:new({
					window = {
						margin = { 1, 0, 1, 0 },
						padding = { 0, 1, 0, 1 },
						title_pos = "center",
						border = "single",
						zindex = 1000,
					},
					icons = {
						separator = "➜",
					},
				}):open(data)
			end,
		},
	},
})

require("org-roam").setup({
	directory = "~/org_roam",
	-- Additional directories.
	org_files = {
		vim.fn.expand("./**/*.org"),
	},
	bindings = {
		prefix = containers.org.key,
	},
})
-- end
-- Keymap: <Leader>of to find nodes using Telescope
vim.keymap.set("n", containers.org.key .. "f", function()
	require("org-roam").api.find_node()
end, { desc = "Org-Roam Find Node" })

vim.keymap.set({ "i", "n" }, containers.org.key .. "d", "", {
	desc = "daily",
})

vim.keymap.set("n", containers.org.key .. "o", "<cmd>OrgSuperAgenda<cr>", { silent = true, desc = "Super agenda" })

-- https://nvim-orgmode.github.io/configuration
vim.api.nvim_create_autocmd("FileType", {
	pattern = "org",
	callback = function(args)
		-- vim.g.table_mode_disable_mappings = 1
		-- Configure vim-table-mode to use Org-compatible separators
		vim.g.table_mode_corner = "+"
		vim.g.table_mode_separator = "|"
		vim.g.table_mode_fillchar = "-"

		-- vim.keymap.set('n', containers.org.key..'TT', '<cmd>TableModeToggle<CR>', {
		--   silent = true,
		--   desc = 'Toggle Table Mode'
		-- })
		--
		--
		-- Navigate between headlines / nodes with J and K
		vim.keymap.set("n", "J", function()
			require("orgmode").action("org_mappings.next_visible_heading")
		end, { buffer = args.buf, silent = true, desc = "Next Org Heading" })

		vim.keymap.set("n", "K", function()
			require("orgmode").action("org_mappings.previous_visible_heading")
		end, { buffer = args.buf, silent = true, desc = "Previous Org Heading" })

		vim.keymap.set(
			{ "i", "n" },
			containers.root.key .. "<S-CR>",
			'<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>',
			{
				silent = true,
				buffer = true,
			}
		)

		vim.keymap.set({ "n" }, containers.org.key .. "i", "", {
			desc = "insert",
		})

		vim.keymap.set({ "n" }, containers.org.key .. "l", "", {
			desc = "link",
		})

		vim.keymap.set({ "n" }, containers.org.key .. "x", "", {
			desc = "set",
		})
		vim.keymap.set({ "n" }, containers.org.key .. "n", "", {
			desc = "note",
		})
		-- Map 'gd' in org buffers to open orgmode links
		vim.keymap.set("n", containers.root.key .. "gd", function()
			require("orgmode").action("org_mappings.open_at_point")
		end, { buffer = args.buf, silent = true, desc = "Org Open Link" })

		vim.keymap.set("n", containers.root.key .. "<CR>", function()
			require("orgmode").action("org_mappings.open_at_point")
		end, { buffer = args.buf, silent = true, desc = "Org Open Link" })
	end,
})

-- Those dont need to be only for org files as they are accessible everywhere.
local tom = require("telescope-orgmode")
tom.setup({ adapter = "fzf-lua" })
vim.keymap.set("n", containers.org.key .. "fh", tom.search_headings, { desc = "Org headlines" })
vim.keymap.set("n", containers.org.key .. "ft", tom.search_tags, { desc = "Org tags" })
vim.keymap.set("n", containers.org.key .. "r", tom.refile_heading, { desc = "Org refile" })
vim.keymap.set("n", containers.org.key .. "li", tom.insert_link, { desc = "Org insert link" })
-- Experimental LSP support
vim.lsp.enable("org")
return {}
