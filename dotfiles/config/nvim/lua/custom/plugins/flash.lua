local containers = require("custom.config.keymap-containers")
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


-- Custom bindings:
-- vim.keymap.set({"n", "x", "o"}, containers.root.key .. "f", function() require("flash").jump() end, {desc = "jump [f]lash" })
-- vim.keymap.set({"n", "x", "o"}, containers.root.key .. "ss", function() require("flash").treesitter() end, {desc = "Flash Treesitter (visual select block)" })
-- Jump on a search result with ctrl save.
-- vim.keymap.set({"c"}, containers.root.key .. "<c-s>",function() require("flash").toggle() end, {desc = "Toggle Flash Search" })
-- vim.keymap.set({"o"}, containers.root.key .. "sR",function() require("flash").remote() end, {desc = "Remote Flash" })

return {}
