return {
  "e-sigs/winbuf.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.bufremove" },
  config = function()
    require("winbuf").setup({
      style = "thin",       -- "thin", "thick", "slant", "slope", "round"
      diagnostics = "nvim_lsp",
      -- no_buffer_text = "",
      buf_delete = function(buf)
        require("mini.bufremove").delete(buf, false) -- Wire cleanly into mini.bufremove
      end,
    })
  end,
}
