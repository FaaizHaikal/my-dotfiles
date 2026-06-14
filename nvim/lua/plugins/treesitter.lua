return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  opts = {
    ensure_installed = {
      -- Neovim
      "lua",
      "vim",
      "vimdoc",

      -- Robotics
      "c",
      "cpp",
      "cmake",

      -- Backend
      "go",

      -- Scripting
      "python",
      "bash",

      -- Java
      "java",

      -- Docker
      "dockerfile",

      -- Documents
      "latex",
      "markdown",
      "markdown_inline",

      -- Config
      "json",
      "yaml",
      "toml",

      -- Misc
      "gitignore",
      "regex",
      "query",
    },

    auto_install = true,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
    },
  },
}
