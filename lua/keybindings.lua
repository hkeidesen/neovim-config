local keymap = vim.keymap.set
local telescope = require('packages.telescope')
-- local builtin = require('packages.telescope.builtin')

-- ****************************************
-- ************** KEYBINDINGS *************
-- ****************************************



-- source vim config with <leader> enter
vim.keymap.set("n", "<leader><CR>", "<cmd>lua Reload()<cr>")

-- delete highlights on escape
vim.keymap.set("n", "<ESC>", ":noh<CR>", { silent = true })

