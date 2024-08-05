return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"tsserver",
				"html",
				"cssls",
				"tailwindcss",
				"dockerls",
				"lua_ls",
				"graphql",
				"docker_compose_language_service",
				"jsonls",
				"marksman",
				"spectral",
				"phpactor",
				"powershell_es",
				"sqlls",
				"somesass_ls",
				"bashls",
				"pyright",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint",
				"eslint_d",
				"csharpier",
				"netcoredbg",
				"chrome-debug-adapter",
				"firefox-debug-adapter",
				"yamllint",
				"markdownlint",
				"editorconfig-checker",
			},
		})
	end,
}
