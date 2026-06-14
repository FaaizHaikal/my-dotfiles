return {
	"saghen/blink.cmp",
	version = "*",

	dependencies = {
		"rafamadriz/friendly-snippets",
	},

	opts = {
		keymap = {
			preset = "default",
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
		},

		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
			providers = {
				lsp = {
					-- For LaTeX / texlab, don't spam suggestions on a single raw trigger character
					min_keyword_length = function(ctx)
						-- Wait for one more char after '\' in latex
						if
							vim.bo.filetype == "tex"
							and ctx.line:sub(ctx.bounds.start_col - 1, ctx.bounds.start_col - 1) == "\\"
						then
							return 2
						end
						return 0 -- Default instantly for Go, C++, Python, etc.
					end,
				},
				snippets = {
					min_keyword_length = 2,
				},
			},
		},

		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	},
}
