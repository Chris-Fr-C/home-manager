-- Moving windows
return {
  "sindrets/winshift.nvim",
  config = function()
    require("winshift").setup({
      highlight_moving_win = true,
      focused_hl_group = "Visual",
      moving_win_options = {
        wrap = false,
        cursorline = false,
        cursorcolumn = false,
        colorcolumn = "",
      },
      keymaps = {
        disable_defaults = false,
        win_move_mode = {
          ["h"] = "left",
          ["j"] = "down",
          ["k"] = "up",
          ["l"] = "right",
          ["H"] = "far_left",
          ["J"] = "far_down",
          ["K"] = "far_up",
          ["L"] = "far_right",
        },
      },
      window_picker = function()
        return require("winshift.lib").pick_window({
          picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          filter_rules = { cur_win = true, floats = true },
        })
      end,
    })
  end,
}
