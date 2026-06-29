return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end
		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = hide_in_width,
		}
		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			cond = hide_in_width,
		}
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "neo-tree" },
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", diff },
				lualine_c = {
					{
						"filename",
						path = 0,
					},
				},
				lualine_x = { diagnostics, { "encoding", cond = hide_in_width }, { "filetype", cond = hide_in_width } },
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
