return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	{
		"mason-org/mason-lspconfig.nvim",

		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},

		opts = {
			ensure_installed = {
				"lua_ls",
				"clangd",
				"gopls",
				"jdtls",
				"pyright",
				--"dockerls",
				"texlab",
			},

			automatic_enable = true,
		},

		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				severity_sort = true,
			})

			local group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = group,

				callback = function(event)
					local opts = {
						buffer = event.buf,
						silent = true,
					}

					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				end,
			})
		end,
	},
}
