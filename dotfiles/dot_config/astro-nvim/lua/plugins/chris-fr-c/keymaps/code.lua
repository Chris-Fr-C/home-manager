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

return {}
