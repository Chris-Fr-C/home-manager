require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" , "null-ls", "lua-language-server", "python-lsp-server", "gopls"}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
