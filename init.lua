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

-- -- vue 3 with volar
-- require'lazy'.setup {
--     {'neoclide/coc.nvim', branch = 'release'},
--     {'yaegassy/coc-volar', { ['do'] = 'yarn install --frozen-lockfile' }},
--     {'yaegassy/coc-volar-tools', { ['do'] = 'yarn install --frozen-lockfile'}}
-- }

