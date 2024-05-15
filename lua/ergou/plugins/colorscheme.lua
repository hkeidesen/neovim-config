return {
  {
    'catppuccin/nvim',
    lazy = false,
    enabled = true,
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        integrations = {
          aerial = true,
          diffview = true,
          neotree = true,
          mason = true,
          noice = true,
          notify = true,
          navic = {
            enabled = true,
          },
          which_key = true,
          lsp_trouble = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
          },
        },
      })

      vim.cmd.colorscheme('catppuccin-frappe')
    end,
  },
}
