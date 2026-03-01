-- ~/.config/nvim/lua/plugins/hop.lua
return {
  "smoka7/hop.nvim",
  keys = {
    {
      "s",
      function()
        require("hop").hint_char1({
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = false,
        })
      end,
      mode = { "n", "v" },
      desc = "Hop forward",
    },
    {
      "S",
      function()
        require("hop").hint_char1({
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = false,
        })
      end,
      mode = { "n", "v" },
      desc = "Hop backward",
    },
  },
  config = function()
    require("hop").setup({
      keys = "asdfghjklqwertyuiopzxcvbnm",
    })
  end,
}
