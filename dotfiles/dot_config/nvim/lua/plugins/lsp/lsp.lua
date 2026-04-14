return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Diagnostics
			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					prefix = "●",
				},
				severity_sort = true,
			})

			-- Keymaps
			local on_attach = function(_, bufnr)
				local map = vim.keymap.set
				local opts = { buffer = bufnr, silent = true }

				map("n", "gd", vim.lsp.buf.definition, opts)
				map("n", "gr", vim.lsp.buf.references, opts)
				map("n", "gI", vim.lsp.buf.implementation, opts)
				map("n", "gD", vim.lsp.buf.declaration, opts)
				map("n", "K", vim.lsp.buf.hover, opts)
				map("n", "<C-k>", vim.lsp.buf.signature_help, opts)

				map("n", "<leader>rn", vim.lsp.buf.rename, opts)
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			end

			-- Mason setup
			mason.setup()

			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					-- add more servers here
					-- "tsserver",
					-- "pyright",
				},
				automatic_installation = true,
			})

			-- Server configs
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
							hint = {
								enable = true,
							},
						},
					},
				},
			}

			-- Setup handlers (auto-apply to all servers)
			mason_lspconfig.setup_handlers({
				function(server_name)
					local server_opts = servers[server_name] or {}

					lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
						on_attach = on_attach,
						capabilities = capabilities,
					}, server_opts))
				end,
			})
		end,
	},
}
