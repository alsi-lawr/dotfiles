-- Function to close nvim-tree if it's the last window
-- local function close_nvim_tree_if_last()
-- 	vim.defer_fn(function()
-- 		local wins = vim.api.nvim_tabpage_list_wins(0)
-- 		if #wins == 1 then
-- 			local buf_ft = vim.bo[vim.api.nvim_win_get_buf(wins[1])].filetype
-- 			if buf_ft == "NvimTree" then
-- 				vim.cmd("quit")
-- 			end
-- 		end
-- 	end, 50)
-- end

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended nvimtree settings
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 35,
				relativenumber = true,
			},
			-- folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "",
							arrow_open = "",
						},
					},
				},
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- -- Create an autocommand group
		-- vim.api.nvim_create_augroup("CloseNvimTreeIfLast", { clear = true })
		--
		-- -- Set up the autocommand
		-- vim.api.nvim_create_autocmd("WinLeave", {
		-- 	group = "CloseNvimTreeIfLast",
		-- 	callback = close_nvim_tree_if_last,
		-- })
		-- keymaps
		local keymap = vim.keymap -- brevity

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
