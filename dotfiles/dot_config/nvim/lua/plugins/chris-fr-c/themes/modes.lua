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
            "n-v-c:block-ModeCursor,i-ci-ve:ver25-ModeCursor,r-cr:hor20-ModeCursor,o:hor50-ModeCursor"
          )
        end,

        modes = {
          -- Normal mode
          n = {
            winhl = {
              -- Line number keeps background
              CursorLineNr = { bg = "#00FF00" },

              -- Text side gets underline only
              CursorLine = {
                underline = true,
                sp = "#00FF00",
                bg = "NONE",
              },
            },
            hl = {
              ModeCursor = { bg = "#00FF00" },
            },
          },

          -- Insert mode
          i = {
            winhl = {
              CursorLineNr = { bg = "#800000" },
              CursorLine = {
                underline = true,
                sp = "#800000",
                bg = "NONE",
              },
            },
            hl = {
              ModeCursor = { bg = "#800000" },
            },
          },

          -- Replace mode (R)
          R = {
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
