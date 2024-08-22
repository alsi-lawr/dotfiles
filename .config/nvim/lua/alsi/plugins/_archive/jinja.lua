return {
	"lepture/vim-jinja",
	init = function()
		local au = vim.api.nvim_create_augroup("jinja", { clear = true })

		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			group = au,
			pattern = { "*.yaml.jinja" },
			callback = function()
				vim.bo.filetype = "yaml.jinja"
			end,
		})
	end,
}
