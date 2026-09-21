vim.pack.add({
	"https://github.com/nvim-orgmode/orgmode",

	-- Colors highlight:
	"https://github.com/lukas-reineke/headlines.nvim",

	-- Org roam
	"https://github.com/chipsenkbeil/org-roam.nvim",

	-- Table mode
	"https://github.com/dhruvasagar/vim-table-mode",
})

require("headlines").setup({})

local containers = require("custom.config.keymap-containers")

-- Check if a local project config exists in the current directory
local has_local_config = vim.fn.filereadable(".nvim.lua") == 1

if not has_local_config then
	require("orgmode").setup({
		org_agenda_files = "~/orgfiles/**/*",
		org_default_notes_file = "~/orgfiles/refile.org",
	})

	require("org-roam").setup({
		directory = "~/org_roam",
		bindings = {
			prefix = containers.orgroam.key,
		},
	})
end
-- Keymap: <Leader>of to find nodes using Telescope
vim.keymap.set("n", containers.org.key .. "f", function()
	require("org-roam").api.find_node()
end, { desc = "Org-Roam Find Node" })

vim.keymap.set({ "i", "n" }, containers.orgroam.key .. "d", "", {
	desc = "daily",
})
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
-- And the org roam mode

-- Experimental LSP support
vim.lsp.enable("org")
return {}
