return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  opts = {
    winopts = {
      height = 0.85,
      width = 0.80,
      preview = {
        layout = "vertical",
      },
    },
    keymap = {
      fzf = {
        ["tab"] = "down",
        ["shift-tab"] = "up",
      },
    },
  },
  config = function(_, opts)
    local fzf_lua = require("fzf-lua")

    local winbuf_custom_action = function(selected, fzf_opts)
      local file_entry = fzf_lua.path.entry_to_file(selected[1], fzf_opts)
      if file_entry and file_entry.path then
        vim.cmd("edit " .. vim.fn.fnameescape(file_entry.path))
        if file_entry.line and file_entry.line > 0 then
          pcall(vim.api.nvim_win_set_cursor, 0, { file_entry.line, (file_entry.col or 1) - 1 })
        end
        pcall(function()
          require("winbuf").cycle(0)
        end)
      end
    end

    opts.actions = {
      files = {
        ["default"] = winbuf_custom_action,
      },
      grep = {
        ["default"] = winbuf_custom_action,
      },
    }

    opts.blines = {
      actions = {
        ["default"] = fzf_lua.actions.file_edit,
      },
    }

    fzf_lua.setup(opts)
  end,
}
