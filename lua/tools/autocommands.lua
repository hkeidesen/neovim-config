-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 375 })
	end,
})

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
    command = 'echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None',
    pattern = { "*" }, })