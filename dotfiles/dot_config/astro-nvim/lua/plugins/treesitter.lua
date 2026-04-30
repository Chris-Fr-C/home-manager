-- Customize Treesitter
-- --------------------
-- Treesitter customizations are handled with AstroCore
-- as nvim-treesitter simply provides a download utility for parsers

---@type LazySpec
return {
	"AstroNvim/astrocore",
	---@type AstroCoreOpts
	opts = {
		treesitter = {
			ensure_installed = { "vim", "lua" },
			highlight = true,
			textobjects = {
				select = {
					select_textobject = {
						["ak"] = { query = "@block.outer", desc = "around block" },
					},
				},
			},
		},
	},
}
