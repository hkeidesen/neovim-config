require('config.EcoVim')

require('utils.globals')
require('utils.functions')

require('config.options')
require('config.lazy')
require('config.keymappings')
require('config.autocmds')
require('config.lsp.config')
require('config.lsp.setup')
require('config.lsp.functions')

require('internal.winbar')
require('internal.cursorword')

-- -- vue folding
-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--     pattern = {"*.vue"},
--     callback = function()
--         -- Set Treesitter folding
--         vim.wo.foldmethod = "expr"
--         vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
--     end,
-- })