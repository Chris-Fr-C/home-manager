-- Colored modes
-- lua/plugins/mode_line_colors.lua
-- -- Colored modes
-- lua/plugins/mode_line_colors.lua
-- Colored modes
-- lua/plugins/mode_line_colors.lua
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

          vim.opt.guicursor:append(
            "n-v-c:block-ModeCursor,i-ci-ve:block-ModeCursor,r-cr:hor20-ModeCursor,o:hor50-ModeCursor"
          )
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
