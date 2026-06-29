return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"mason-org/mason.nvim",
		"stevearc/overseer.nvim", -- VS Code Task Runner engine for pre-launch tasks
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = "mason-org/mason.nvim",
			opts = {
				ensure_installed = {
					"delve", -- Go
					"python", -- Python
					"codelldb", -- C/C++ & Rust
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
			templates = { "builtin" }, -- Loads standard VS Code task runners
		})

		-- Tell nvim-dap to map configurations directly from your local .vscode/launch.json
		-- It maps VS Code types to our configured adapters
		require("dap.ext.vscode").load_launchjs(nil, {
			codelldb = { "c", "cpp" },
			delve = { "go" },
			python = { "python" },
		})

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

		-- 1. CodeLLDB (C / C++)
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				-- Mason installs it to this specific internal location automatically
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
				args = { "--port", "${port}" },
			},
		}

		-- 2. Delve (Go)
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
