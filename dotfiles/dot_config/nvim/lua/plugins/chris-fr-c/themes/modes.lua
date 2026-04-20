-- Colored modes
-- lua/plugins/mode_line_colors.lua
-- -- Colored modes
-- lua/plugins/mode_line_colors.lua
-- Colored modes
-- lua/plugins/mode_line_colors.lua
if false then
	return {}
end

return {
	{
		"rasulomaroff/reactive.nvim",
		lazy = false,
		config = function()
			local reactive = require("reactive")
			reactive.add_preset({
				name = "custom-mode-line",
				init = function()
					vim.opt.termguicolors = true

					vim.opt.guicursor:append("n-v-c:block-Cursor,i-ci-ve:block-Cursor,r-cr:hor20-Cursor,o:hor50-Cursor")
					-- vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#C1E1C1" })
				end,

				modes = {
					-- Normal mode
					n = {
						winhl = {
							-- Line number keeps background
							CursorLineNr = { bg = "#C1E1C1" },
							-- Text side gets underline only
							CursorLine = {
								underline = false,
								sp = "#C1E1C1",
								bg = "NONE",
							},
						},
						hl = {
							Cursor = { fg = "#FFFFFF", bg = "#C1E1C1" },
							ModeCursor = { bg = "#C1E1C1" },
						},
					},

					-- Insert mode
					i = {
						winhl = {
							CursorLineNr = { bg = "#FF746C" },
							CursorLine = {
								underline = false,
								sp = "#FF746C",
								bg = "NONE",
							},
						},

						hl = {
							Cursor = { fg = "#111111", bg = "#FF746C" },
							ModeCursor = { bg = "#FF746C" },
						},
					},

					-- Replace mode (R)
					R = {
						winhl = {
							CursorLineNr = { bg = "#FF746C" },
							CursorLine = {
								underline = true,
								sp = "#FF746C",
								bg = "NONE",
							},
						},

						hl = {
							Cursor = { fg = "#111111", bg = "#FF746C" },
							ModeCursor = { bg = "#d2691e" },
						},
					},

					-- Command replace (c)
					c = {
						winhl = {
							CursorLineNr = { bg = "#d2691e" },
							CursorLine = {
								underline = true,
								sp = "#d2691e",
								bg = "NONE",
							},
						},
						hl = {
							Cursor = { fg = "#111111", bg = "#d2691e" },
							ModeCursor = { bg = "#d2691e" },
						},
					},

					-- Visual modes
					[{ "v", "V", "\x16" }] = {
						winhl = {
							CursorLineNr = { bg = "#5a2e80" },
							CursorLine = {
								underline = true,
								sp = "#e6d6f5",
								bg = "NONE",
							},
						},
						Cursor = { fg = "#111111", bg = "#5a2e80" },

						hl = {
							ModeCursor = { bg = "#5a2e80" },
						},
					},
				},
			})

			reactive.setup({
				configs = { ["custom-mode-line"] = true },
				builtin = {
					cursorline = true,
					cursor = false,
					modemsg = false,
				},
			})
		end,
	},
}
