vim.cmd("set noexpandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=0")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.o.number = true
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	command = "MinimapToggle",
})
vim.api.nvim_set_keymap("n", "<leader>bn", ":bnext<CR>", { remap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bp", ":bprevious<CR>", { remap = true, silent = true })
