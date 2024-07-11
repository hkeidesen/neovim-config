local Util = require('ergou.util')
local signs = Util.icons.diagnostics

return {
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        event = 'LazyFile',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            { 'folke/neodev.nvim',       config = true },
            {
                'utilyre/barbecue.nvim',
                name = 'barbecue',
                version = '*',
                dependencies = {
                    { 'SmiteshP/nvim-navic' },
                },
                opts = { attach_navic = false },
            },
            { 'b0o/schemastore.nvim' },
        },
        opts = {
            inlay_hints = { enabled = true },
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = 'if_many',
                    prefix = function(diagnostic)
                        if diagnostic.severity == vim.diagnostic.severity.ERROR then
                            return signs.Error
                        elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                            return signs.Warn
                        elseif diagnostic.severity == vim.diagnostic.severity.HINT then
                            return signs.Hint
                        elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                            return signs.Info
                        end
                        return '●'
                    end,
                },
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = signs.Error,
                        [vim.diagnostic.severity.WARN] = signs.Warn,
                        [vim.diagnostic.severity.HINT] = signs.Hint,
                        [vim.diagnostic.severity.INFO] = signs.Info,
                    },
                },
            },
        },
        config = function(_, opts)
            local servers = Util.lsp.get_servers()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            -- FIXME: For trouble v2 only
            -- Remove after v3 is released
            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            local mason_lspconfig = require('mason-lspconfig')
            Util.lsp.lsp_autocmd()

            mason_lspconfig.setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            })
            -- Omnifunc configuration for Go
            local on_attach = function(client, bufnr)
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:vim.lsp.omnifunc')
                if client.name == 'ruff' then
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
            end
            -- ruff for python
            require('lspconfig').ruff.setup {
                on_attach = on_attach,
            }
            -- Configure Go LSP
            require('lspconfig').gopls.setup({
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            })


            require('lspconfig').gopls.setup({
                on_attach = on_attach,
            })

            -- htmx
            require('lspconfig').htmx.setup {}
        end,
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
            local servers = Util.lsp.get_servers()
            local ensure_installed = vim.list_extend(vim.tbl_keys(servers),
                { 'stylua', 'eslint_d', 'phpcbf', 'cspell', 'phpcs', 'prettierd', 'gopls' })
            require('mason-tool-installer').setup({
                ensure_installed = ensure_installed,
            })
        end,
    },
}
