return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Using cmd ensures the plugin lazy-loads cleanly when you call it
  cmd = "FzfLua",
  opts = {
    winopts = {
      height = 0.85,
      width = 0.80,
      preview = {
        layout = "vertical",
      },
    },
    -- FIX: We define the keymaps safely as strings rather than executing the require directly
    keymap = {
      fzf = {
        ["tab"] = "down",     -- Tab moves down to next match
        ["shift-tab"] = "up", -- Shift+Tab moves up to prev match
      },
    },
  },
  -- Use the config function to safely bind actions after loading
  config = function(_, opts)
    local fzf_lua = require("fzf-lua")
    
    -- Inject the file action handlers smoothly now that the module is safe
    opts.actions = {
      files = {
        ["default"] = fzf_lua.actions.file_edit,
      },
    }
    
    fzf_lua.setup(opts)
  end,
}
