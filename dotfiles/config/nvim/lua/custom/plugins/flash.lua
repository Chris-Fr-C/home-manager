-- quick jump system.
vim.pack.add({"https://github.com/folke/flash.nvim"})

-- I setup cause i want to search before and after with the same key.
require("flash").setup({
  modes = {
    char = {
      -- Turn this off so 'f' doesn't get locked into line-only, forward-only mode
      enabled = false, 
    },
  },
})
return {}
