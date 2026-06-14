local BUFFERLINE="bufferline"
local MINI="mini"
local tabline=BUFFERLINE

if tabline==BUFFERLINE then
  vim.pack.add({"https://github.com/akinsho/bufferline.nvim"})
  require("bufferline").setup({})


elseif tabline==MINI then
  require("mini.tabline").setup({})


end
