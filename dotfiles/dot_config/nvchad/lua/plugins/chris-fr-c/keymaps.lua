-- prompt for a refactor to apply when the remap is triggered.
-- vim.keymap.set({ "n", "x" }, "<leader>", function()
-- 	require("refactoring").select_refactor()
-- end)

--
-- Moving line up and down.
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- And for visual mode.
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })



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

-- Exit Neovim completely without saving when press Alt+Q
vim.keymap.set("n", "<A-q>", ":qa!<CR>", { noremap = true, silent = true, desc = "Quit all without saving" })

-- Navigate jump list (previous/next location)
-- Alt+h or Alt+Left to go back
vim.keymap.set("n", "<A-h>", "<C-o>", { noremap = true, silent = true, desc = "Jump to previous location" })
vim.keymap.set("n", "<A-Left>", "<C-o>", { noremap = true, silent = true, desc = "Jump to previous location" })

-- Alt+l or Alt+Right to go forward
vim.keymap.set("n", "<A-l>", "<C-i>", { noremap = true, silent = true, desc = "Jump to next location" })
vim.keymap.set("n", "<A-Right>", "<C-i>", { noremap = true, silent = true, desc = "Jump to next location" })
-- Next buffer (Shift + Right)
vim.keymap.set("n", "<S-Right>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
-- Previous buffer (Shift + Left)
vim.keymap.set("n", "<S-Left>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "q", "<Nop>", { desc = "Disable macro recording" })
vim.keymap.set("n", "Q", "<Nop>", { desc = "Disable Ex mode" })



-- ============== LSP ===============
-- Definitions & navigation (Telescope)
vim.keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", {
  noremap = true,
  silent = true,
  desc = "LSP: Go to definition",
})

vim.keymap.set("n", "<leader>lD", "<cmd>Telescope lsp_declarations<CR>", {
  noremap = true,
  silent = true,
  desc = "LSP: Go to declaration",
})

vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", {
  noremap = true,
  silent = true,
  desc = "LSP: References",
})

vim.keymap.set("n", "<leader>lI", "<cmd>Telescope lsp_implementations<CR>", {
  noremap = true,
  silent = true,
  desc = "LSP: Implementations",
})

vim.keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", {
  noremap = true,
  silent = true,
  desc = "LSP: Type definitions",
})

-- Info & actions
vim.keymap.set("n", "<leader>li", vim.lsp.buf.hover, {
  noremap = true,
  silent = true,
  desc = "LSP: Hover info",
})

vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {
  noremap = true,
  silent = true,
  desc = "LSP: Code actions",
})

vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, {
  noremap = true,
  silent = true,
  desc = "LSP: Rename symbol",
})

-- Diagnostics (Telescope + built-in)
vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, {
  noremap = true,
  silent = true,
  desc = "LSP: Line diagnostics",
})

vim.keymap.set("n", "<leader>lq", "<cmd>Telescope diagnostics<CR>", {
  noremap = true,
  silent = true,
  desc = "LSP: Workspace diagnostics",
})


-- Formatting
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, {
  noremap = true,
  silent = true,
  desc = "LSP: Format file",
})


-- Just a shortcut to open da terminal.
-- 
-- Ensure your leader key is set (usually Space or Backslash)
vim.g.mapleader = " " 

-- Quick terminal
vim.keymap.set('n', '<leader>ft', ':split | terminal <CR>', { noremap = true, silent = true , desc="Terminal (horizontal)"})

vim.keymap.set('n', '<leader>|', ':vsplit <CR>',{desc="Vertical split"})
vim.keymap.set('n', '<leader>wsv', ':vsplit <CR>', {desc="Vertical split"})

-- Horizontal split terminal
vim.keymap.set('n', '<leader>-', ':split <CR>', {desc="Horizontal split"})
vim.keymap.set('n', '<leader>wsh', ':split <CR>', {desc="Horizontal split"})

-- Exit terminal mode with jj
vim.keymap.set('t', 'jj', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Navigate windows from terminal mode
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })


-- Indentation
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Navigate Location List (Standard)
-- Might be duplicated with init.lua cause it seems a bit broken on nvchad.
-- Jump to older location
-- vim.keymap.map("n", "<A-h>", "<C-o>", { desc = "Jump older" })
-- Jump to newer location
-- vim.keymap.map("n", "<A-l>", "<C-i>", { desc = "Jump newer" })

-- Another way to accept suggestion
vim.keymap.set("i", "<C-y>", function()
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.confirm({ select = true })
  else
    -- Fallback: just act like a normal keypress or do nothing
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-y>", true, false, true), "n", true)
  end
end, { desc = "Confirm selection with Ctrl + y" })

return {}
