local keymap = vim.keymap.set
local silent = { silent = true }
local builtin = require("telescope.builtin")

-- ****************************************
-- ************** KEYBINDINGS *************
-- ****************************************



-- source vim config with <leader> enter
vim.keymap.set("n", "<leader><CR>", "<cmd>lua Reload()<cr>")

-- delete highlights on escape
vim.keymap.set("n", "<ESC>", ":noh<CR>", { silent = true })


-- Telescope
keymap("n", "<C-p>", "<CMD>lua require('plugins.telescope').project_files()<CR>")
keymap("n", "<S-p>", "<CMD>lua require('plugins.telescope.pickers.multi-rg')()<CR>")
keymap("n", "?", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 0,
		previewer = false,
	}))
end, { desc = "[/] fuzzily search in current buffer" })