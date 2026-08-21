local containers = require("custom.config.keymap-containers")

vim.pack.add({ "https://github.com/ThePrimeagen/99" })

require("99").setup({})

-- Manual setup to be sure of the keymaps.
vim.keymap.set("v", containers.code.key .. "9v", function()
	require("99").visual({})
end, {desc="Visual"})

--- if you have a request you dont want to make any changes, just cancel it
vim.keymap.set("n", containers.code.key .."9x", function()
	require("99").stop_all_requests()
end, {desc="Stop all requests"})

vim.keymap.set("n", containers.code.key .. "9s", function()
	require("99").search({})
end, {desc="[s]search"})

vim.keymap.set("n", containers.code.key .. "9m", function()
  require("99.extensions.telescope").select_model()
end, {desc="Select [m]odel"})

vim.keymap.set("n", containers.code.key .. "9v", function()
  require("99").vibe()
end, {desc="[v]ibe question about the code"})
