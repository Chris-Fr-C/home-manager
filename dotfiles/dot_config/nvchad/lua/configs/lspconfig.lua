-- Load NvChad's default LSP handler settings safely
require("nvchad.configs.lspconfig").defaults()

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Standard servers list
local servers = { "html", "cssls", "gopls", "pylsp" }

-- Loop through and configure standard servers using the modern native API
for _, server in ipairs(servers) do
	vim.lsp.config(server, {
		on_attach = on_attach,
		on_init = on_init,
		capabilities = capabilities,
	})
	vim.lsp.enable(server)
end

-- Custom config for clangd (C++) configured natively
vim.lsp.config("clangd", {
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--offset-encoding=utf-16",
	},
	-- Replaced legacy root_pattern with the modern native vim.fs alternative
	root_dir = function(bufnr, on_dir)
		on_dir(vim.fs.root(bufnr, { "compile_commands.json", ".git", "CMakeLists.txt" }))
	end,
})

-- Activate clangd
vim.lsp.enable("clangd")
