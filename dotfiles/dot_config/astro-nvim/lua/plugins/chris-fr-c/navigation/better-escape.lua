-- Allowing to use jj and jk to escape
return {
  "max397574/better-escape.nvim",
  lazy = false,
  config = function()
    require("better_escape").setup({
      -- Add your custom configuration here if needed
      -- For example:
      mappings = {
        i = {
          j = { j = "<Esc>", k = "<Esc>" },
        },
      },
    })
  end,
}
