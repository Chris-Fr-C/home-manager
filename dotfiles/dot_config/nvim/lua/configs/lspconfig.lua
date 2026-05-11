require("nvchad.configs.lspconfig").defaults()


local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require ("lspconfig")

local servers = { "html", "cssls" ,  "none-ls", "lua-ls", "python-lsp-server", "gopls", "clangd"}

vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers 
--
--
-- Custom config for clangd (C++)
lspconfig.clangd.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--offset-encoding=utf-16", -- Required to stop encoding warnings in some setups
  },
  -- This replaces the "root_markers" from the doc you found
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git", "CMakeLists.txt"),
}
