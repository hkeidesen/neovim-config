-- ide-like?

vim.opt.cmdheight = 0

return {
  {
    "noice.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        presets = {
          bottom_search = false,
          inc_rename = true,
        },
        messages = {
          enabled = true,
        },
      })
    end,
  },

  {
    "smjonas/inc-rename.nvim",
    opts = function(_, opts)
      opts.input_buffer_type = nil
    end,
  },
}
