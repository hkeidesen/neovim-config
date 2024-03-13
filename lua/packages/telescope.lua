return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  requires = { 'nvim-lua/plenary.nvim' },

  -- Configure Telescope after it's loaded
  config = function()
    -- Require Telescope
    local telescope = require('telescope')

    -- Load default configurations (optional)
    telescope.setup {
      -- Defauly configuration options here
    }

    -- Key mappings for Telescope
    local set = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- File search mapping
    set("n", "<C-p>", "<CMD>lua require('telescope.builtin').find_files()<CR>", opts)

    -- Live grep mapping
    set("n", "<S-p>", "<CMD>lua require('telescope.builtin').live_grep()<CR>", opts)
    
    -- Fuzzy search in current buffer
    set("n", "?", "<CMD>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({ winblend = 0, previewer = false }))<CR>", { desc = "[/] fuzzily search in current buffer" })


    -- Additional mappings can be added here
  end
}
