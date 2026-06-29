return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"mason-org/mason.nvim", -- Kept as mason-org to match your LSP
		"stevearc/overseer.nvim",
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = "mason-org/mason.nvim", -- Kept as mason-org
			opts = {
				ensure_installed = {
					"delve",
					"python",
					"codelldb",
				},
				automatic_installation = true,
			},
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("nvim-dap-virtual-text").setup()
		dapui.setup()
		require("overseer").setup({
			templates = { "builtin" },
		})

		-- Updated ext.vscode syntax
		local vscode = require("dap.ext.vscode")
		vscode.json_decode = function(str)
			return vim.json.decode(str, { lstrip_comments = true })
		end

		vscode.type_to_filetypes = {
			codelldb = { "c", "cpp" },
			delve = { "go" },
			python = { "python" },
		}

		-- Auto UI toggles
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_initialized.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.after.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Adapters
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.adapters.delve = {
			type = "server",
			port = "${port}",
			executable = {
				command = "dlv",
				args = { "adapter" },
			},
		}
	end,
}
