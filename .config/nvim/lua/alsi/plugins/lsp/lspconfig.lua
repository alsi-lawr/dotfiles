return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		-- "seblj/roslyn.nvim",
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- shared on attach
		local on_attach = require("alsi.core.lsp_keymaps").on_attach

		-- Change the Diagnostic symbols in the sign column (gutter)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "󰠠",
				},
			},
			jump = { float = true },
			underline = { severity = vim.diagnostic.severity.INFO },
			update_in_insert = true,
		})

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,
			["docker_compose_language_service"] = function()
				lspconfig["docker_compose_language_service"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
							pattern = "docker-compose*",
							command = "set filetype=yaml.docker-compose",
						})

						on_attach(client, bufnr)
					end,
				})
			end,
			["graphql"] = function()
				-- configure graphql language server
				lspconfig["graphql"].setup({
					capabilities = capabilities,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
					on_attach = on_attach,
				})
			end,
			["emmet_ls"] = function()
				-- configure emmet language server
				lspconfig["emmet_ls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
			["bashls"] = function()
				lspconfig["bashls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					filetypes = { "sh", "zsh" },
				})
			end,
			["dockerls"] = function()
				lspconfig["dockerls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						docker = {
							languageserver = {
								formatter = {
									ignoreMiltilineInstructions = true,
								},
							},
						},
					},
				})
			end,
		})

		-- manually installed servers
		-- require("roslyn").setup({
		-- 	config = {
		-- 		capabilities = capabilities,
		-- 		on_attach = on_attach,
		-- 		filetypes = { "cs", "razor", "cshtml" },
		-- 	},
		-- 	exe = {
		-- 		"dotnet",
		-- 		"/usr/share/config/custom-lsp/roslyn/Microsoft.CodeAnalysis.LanguageServer.dll",
		-- 	},
		-- 	filewatching = true,
		-- })
	end,
}
