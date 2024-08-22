return {
	"Glench/Vim-Jinja2-Syntax",
	config = function()
		vim.cmd([[
            augroup JinjaInYaml
                autocmd!
                autocmd FileType yaml syntax match jinjaBlock /{%.*%}/
                autocmd FileType yaml syntax match jinjaVariable /{{.*}}/
                autocmd FileType yaml hi def link jinjaBlock Statement
                autocmd FileType yaml hi def link jinjaVariable Identifier
            augroup END
        ]])
		local au = vim.api.nvim_create_augroup("jinja", { clear = true })

		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			group = au,
			pattern = { "*.yaml.jinja" },
			callback = function()
				vim.bo.filetype = "yaml"
			end,
		})
	end,
}
