require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Navigate Location List (Standard)
-- Jump to older location
map("n", "<A-h>", "<C-o>", { desc = "Jump older" })
-- Jump to newer location
map("n", "<A-l>", "<C-i>", { desc = "Jump newer" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
