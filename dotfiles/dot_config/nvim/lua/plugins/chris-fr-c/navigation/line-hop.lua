-- lazy.nvim
return {
  lazy=false,
  "johnpmitsch/vai.nvim",
  config = function()
    require("vai").setup({ trigger = "qq", keys = "asdfewqh" })
  end,
}
