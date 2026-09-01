-- My mapping to open with visidata the files such as csv etc...
-- -- Automatically open tabular files in VisiData using Neovim's embedded terminal
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.parquet", "*.csv", "*.tsv", "*.xls", "*.xlsx" , "*.sqlite"},
  callback = function(args)
    local file = vim.fn.fnameescape(args.file)
    local buf = args.buf

    -- Wipe the unread empty buffer and open VisiData in a terminal buffer
    vim.cmd("terminal vd " .. file)

    -- Clean up buffer settings for a smooth terminal experience
    vim.bo.buflisted = true
    vim.cmd("startinsert")
  end,
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.duckdb" },
  callback = function(args)
    local file = vim.fn.fnameescape(args.file)
    local buf = args.buf

    -- Wipe the unread empty buffer and open VisiData in a terminal buffer
    vim.cmd("terminal duckdb " .. file)

    -- Clean up buffer settings for a smooth terminal experience
    vim.bo.buflisted = true
    vim.cmd("startinsert")
  end,
})

return {}
