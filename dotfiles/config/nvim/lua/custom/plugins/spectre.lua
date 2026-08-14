-- Search and replace, sometimes useful.
-- 
local containers = require("custom.config.keymap-containers")
vim.pack.add({
  "https://github.com/nvim-pack/nvim-spectre",
})
local spectre = require("spectre")
spectre.setup({})
vim.keymap.set("n", containers.open.key .. "/", spectre.toggle, {desc="[/] search and replace"})
return {}
