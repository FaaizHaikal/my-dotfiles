return {
  "saghen/blink.cmp",
  version = "*",

  dependencies = {
    "rafamadriz/friendly-snippets",
  },

  opts = {
    keymap = {
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      -- Accept selection with Enter
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      -- Snippet navigation support (if a snippet has jump placeholders)
      ['<C-f>'] = { 'snippet_forward', 'fallback' },
      ['<C-b>'] = { 'snippet_backward', 'fallback' },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
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
          min_keyword_length = function(ctx)
            if
              vim.bo.filetype == "tex"
              and ctx.line:sub(ctx.bounds.start_col - 1, ctx.bounds.start_col - 1) == "\\"
            then
              return 2
            end
            return 0
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
