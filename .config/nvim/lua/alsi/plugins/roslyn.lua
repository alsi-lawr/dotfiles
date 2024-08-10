return {
	"seblj/roslyn.nvim",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	config = function()
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			group = vim.api.nvim_create_augroup("CSharp", { clear = true }),
			pattern = { "*.csx" },
			callback = function()
				vim.bo.filetype = "cs"
			end,
		})

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- shared on attach
		local on_attach = require("alsi.core.lsp_keymaps").on_attach

		require("roslyn").setup({
			config = {
				cmd = {},
				on_attach = on_attach,
			},
			exe = {
				"dotnet",
				"/usr/share/config/custom-lsp/roslyn/Microsoft.CodeAnalysis.LanguageServer.dll",
			},
			filewatching = true,
		})

		require("rzls").setup({
			on_attach = on_attach,
			capabilities = capabilities,
			path = "/usr/share/config/custom-lsp/rzls",
		})
	end,
}
