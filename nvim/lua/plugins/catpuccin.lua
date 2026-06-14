return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Critical: Load this first before all other plugins initialize!
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true, -- Set to true if you use a transparent terminal
      term_colors = true,
      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        -- Automatically theme your winbuf UI layout and side-by-side tabs smoothly
        navic = { enabled = true, custom_bg = "NONE" },
      },
    })

    -- Tell Neovim to instantly activate the colorscheme
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
