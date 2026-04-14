require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Keeping in selection afteri ncrement or decrement.
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })
vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
--
--
-- Making sure that x deletes without putting it to the register.
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })

-- Overseer template

vim.keymap.set("n", "<leader>ot", function()
	require("overseer").run_task({}, nil)
end, { desc = "Run Overseer Task Template" })

-- Prevent paste from overwriting the clipboard
-- Especially useful when pasting over visual selections

local opts = { noremap = true, silent = true }

-- Visual mode: paste without yanking replaced text
vim.keymap.set("x", "p", '"_dP', opts)

-- Optional: also handle capital P
vim.keymap.set("x", "P", '"_dP', opts)

-- If you use Ctrl+Shift+V inside Neovim to paste,
-- make it behave the same way in visual mode
vim.keymap.set("x", "<C-S-v>", '"_dP', opts)

-- Removing the delete goes into register that is super annoying
-- Remap d to delete without putting in register
vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("x", "d", '"_d', { noremap = true })

-- Also remap c (change) if you want the same behavior
vim.keymap.set("n", "c", '"_c', { noremap = true })
vim.keymap.set("x", "c", '"_c', { noremap = true })

-- Hotkey to choose SQL dialect for current buffer
vim.keymap.set("n", "<leader>cL", function()
	local dialects = {
		"ansi",
		"bigquery",
		"clickhouse",
		"db2",
		"duckdb",
		"hive",
		"mariadb",
		"mysql",
		"plsql",
		"postgresql",
		"redshift",
		"snowflake",
		"spark",
		"sqlite",
		"sql",
		"transactsql",
		"tsql",
		"vertica",
	}

	vim.ui.select(dialects, { prompt = "Select SQLFluff dialect:" }, function(choice)
		if choice then
			vim.b.sql_dialect = choice
			vim.notify("SQLFluff dialect set to: " .. choice, vim.log.levels.INFO)
		end
	end)
end, { desc = "Set SQLFluff SQL dialect" })

-- Adding surrounding quotes.
vim.keymap.set("v", '"', 'c"<C-r>""<Esc>')
vim.keymap.set("v", "'", "c'<C-r>\"'<Esc>")
vim.keymap.set("v", "(", 'c(<C-r>")<Esc>')
vim.keymap.set("v", "[", 'c[<C-r>"]<Esc>')
vim.keymap.set("v", "{", 'c{<C-r>"}<Esc>')

-- Moving up and down
-- Move line up
vim.keymap.set("n", "<A-k>", function()
	vim.cmd("move .-2")
end, { desc = "Move line up" })

-- Move line down
vim.keymap.set("n", "<A-j>", function()
	vim.cmd("move .+1")
end, { desc = "Move line down" })

-- FILES
vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "Find files" })

-- SPACE SPACE → file search
vim.keymap.set("n", "<leader><leader>", function()
	require("fzf-lua").files()
end, { desc = "Find files" })

-- LIVE GREP
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "Live grep" })

-- BUFFERS
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "Buffers" })

-- RECENT FILES
vim.keymap.set("n", "<leader>fr", function()
	require("fzf-lua").oldfiles()
end, { desc = "Recent files" })

-- GIT FILES
vim.keymap.set("n", "<leader>fG", function()
	require("fzf-lua").git_files()
end, { desc = "Git files" })

vim.keymap.set("n", "q", "<Nop>", { desc = "Disable macro recording" })
vim.keymap.set("n", "Q", "<Nop>", { desc = "Disable Ex mode" })

-- prompt for a refactor to apply when the remap is triggered
vim.keymap.set({ "n", "x" }, "<leader>rr", function()
	require("refactoring").select_refactor()
end, { desc = "Refactor" })

-- Terminal

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.keymap.set("n", "<Leader>ft", function()
	require("toggleterm").toggle()
end, { silent = true, desc = "Open terminal" })
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Navigation

vim.keymap.set("n", "<A-q>", ":qa!<CR>", { noremap = true, silent = true, desc = "Quit all without saving" })

-- Navigate jump list (previous/next location)
-- Alt+h or Alt+Left to go back
vim.keymap.set("n", "<A-h>", "<C-o>", { noremap = true, silent = true, desc = "Jump to previous location" })
vim.keymap.set("n", "<A-Left>", "<C-o>", { noremap = true, silent = true, desc = "Jump to previous location" })

-- Alt+l or Alt+Right to go forward
vim.keymap.set("n", "<A-l>", "<C-i>", { noremap = true, silent = true, desc = "Jump to next location" })
vim.keymap.set("n", "<A-Right>", "<C-i>", { noremap = true, silent = true, desc = "Jump to next location" })

vim.keymap.set("n", "H", "<cmd>bprevious<CR>", {
	noremap = true,
	silent = true,
	desc = "Previous buffer",
})

vim.keymap.set("n", "L", "<cmd>bnext<CR>", {
	noremap = true,
	silent = true,
	desc = "Next buffer",
})

-- Split window.
vim.keymap.set("n", "<leader>-", "<cmd>split<CR>", {
	noremap = true,
	silent = true,
	desc = "Horizontal split",
})

vim.keymap.set("n", "<leader>|", "<cmd>vsplit<CR>", {
	noremap = true,
	silent = true,
	desc = "Vertical split",
})

-- Accept suggestions.
local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(), -- trigger completion (LSP + others)
		["<C-y>"] = cmp.mapping.confirm({ select = true }), -- accept with Ctrl+y
		["<CR>"] = cmp.mapping(function(fallback)
			fallback() -- disable Enter from confirming
		end, { "i", "s" }),
	}),
})
