-- init.lua or appropriate plugin setup file
local null_ls = require('null-ls')
local lspconfig = require('lspconfig')

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint.with({
            command = 'eslint',
            filetypes = { 'javascript', 'typescript', 'vue' },
        }),
        null_ls.builtins.formatting.prettier.with({
            command = 'prettier',
            filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'html', 'css', 'scss', 'json', 'yaml', 'markdown' },
        }),
    },
})

-- Hook null-ls into the LSP client
lspconfig['null-ls'].setup({
    on_attach = function(client)
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd([[
        augroup LspAutocommands
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]])
        end
    end,
})
