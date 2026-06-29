return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				window = {
					width = 40, -- Sidebar width
					mappings = {
						["<space>"] = "none", -- Disable space trigger inside neo-tree so it doesn't break leader keys
						["f"] = "none",
						["/"] = "none",
					},
					position = "right",
				},
				filesystem = {
					filtered_items = {
						visible = true, -- Show hidden files (like .gitignore or .config) by default
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					follow_current_file = {
						enabled = true, -- Focuses the active file in the sidebar automatically
					},
				},
			})

			-- Your new toggle shortcut: Press Ctrl+N to open/close the sidebar
			vim.keymap.set("n", "<C-n>", "<CMD>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
		end,
	},
}
