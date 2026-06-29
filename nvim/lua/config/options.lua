vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.signcolumn = "yes"

vim.opt.cursorline = false

vim.opt.undofile = true

vim.opt.timeoutlen = 300

vim.opt.completeopt = { "menu", "menuone", "noselect" }

local latex_group = vim.api.nvim_create_augroup("LatexAutoCompile", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = latex_group,
	pattern = "*.tex",
	callback = function()
		local current_file = vim.fn.expand("%:p")
		local current_dir = vim.fn.expand("%:p:h")

		-- Added -silent and -f flags to prevent minor non-breaking warnings 
		-- from triggering a non-zero exit code from latexmk
		vim.fn.jobstart({ "latexmk", "-pdf", "-silent", "-f", "-interaction=nonstopmode", current_file }, {
			cwd = current_dir,
			stdout_buffered = true,
			stderr_buffered = true,
			on_exit = function(_, exit_code)
				if exit_code == 0 then
					vim.notify("LaTeX & BibTeX Build Successful!", vim.log.levels.INFO, { title = "Compiler" })
				else
					vim.notify("LaTeX Build Failed!", vim.log.levels.ERROR, { title = "Compiler" })
				end
			end,
		})
	end,
})
