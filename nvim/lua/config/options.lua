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

vim.opt.cursorline = true

vim.opt.undofile = true

vim.opt.timeoutlen = 300

vim.opt.completeopt = { "menu", "menuone", "noselect" }

local latex_group = vim.api.nvim_create_augroup("LatexAutoCompile", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = latex_group,
  pattern = "*.tex", -- Fires strictly when saving a LaTeX file
  callback = function()
    -- Get the absolute path of the current file being saved
    local current_file = vim.fn.expand("%:p")
    
    -- Runs pdflatex non-interactively 
    vim.fn.jobstart({ "pdflatex", "-interaction=nonstopmode", current_file }, {
      stdout_buffered = true,
      stderr_buffered = true,
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          vim.notify("LaTeX Build Successful!", vim.log.levels.INFO, { title = "Compiler" })
        else
          vim.notify("LaTeX Build Failed!", vim.log.levels.ERROR, { title = "Compiler" })
        end
      end,
    })
  end,
})
