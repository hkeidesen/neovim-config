-- Setup installer & lsp configs
local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
local ufo_config_handler = require("plugins.nvim-ufo").handler



if not mason_ok or not mason_lsp_ok then
    print('Could not load mason or mason-lspconfig')
    return
end

local lspconfig = require("lspconfig")
local neodev = require("neodev")
neodev.setup({})

mason.setup({
    ui = {
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = EcoVim.ui.float.border or "rounded",
    },
})

mason_lsp.setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = {
        "bashls",
        "cssls",
        "eslint",
        "graphql",
        "html",
        "jsonls",
        "lua_ls",
        "prismals",
        "tailwindcss",
        "tsserver",
        "volar",
    },
    automatic_installation = { exclude = { "vuels" } },
})

-- Setup for tsserver with vue/typescript-plugin
local mason_registry = require('mason-registry')
local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
    '/node_modules/@vue/language-server'

lspconfig.tsserver.setup {
    init_options = {
        plugins = {
            {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'vue' },
            },
        },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

lspconfig.volar.setup {
    on_attach = function(client, bufnr)
        -- other setup code
        vim.diagnostic.config({
            virtual_text = true,   -- Display diagnostics as inline text
            signs = true,          -- Show signs in the sign column
            underline = true,      -- Underline text where diagnostics occur
            update_in_insert = false, -- Update diagnostics in insert mode
        })
    end,
    -- additional setup options
}


local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        silent = true,
        border = EcoVim.ui.float.border,
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = EcoVim.ui.float.border }),
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = EcoVim.lsp.virtual_text }
    ),
}

local function on_attach(client, bufnr)
    -- set up buffer keymaps, etc.
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    -- ensure_installed = {"volar", "tsserver"}

    function(server_name)
        local server_config = {}
        -- Setup the server
        lspconfig[server_name].setup(server_config)
    end,

    ["tsserver"] = function()
        local mason_registry = require('mason-registry')
        local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
            '/node_modules/@vue/language-server'

        lspconfig.tsserver.setup {
            init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vue_language_server_path,
                        languages = { 'vue' },
                    },
                },
            },
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        }
    end,

    ["tailwindcss"] = function()
        -- disabled
    end,

    ["cssls"] = function()
        lspconfig.cssls.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = require("config.lsp.servers.cssls").on_attach,
            settings = require("config.lsp.servers.cssls").settings,
        })
    end,

    ["eslint"] = function()
        -- disabled
    end,

    ["emmet_ls"] = function()
        -- Disable emmet setup
    end,

    ["jsonls"] = function()
        lspconfig.jsonls.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
            settings = require("config.lsp.servers.jsonls").settings,
        })
    end,

    ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
            settings = require("config.lsp.servers.lua_ls").settings,
        })
    end,
}

require("ufo").setup({
    fold_virt_text_handler = ufo_config_handler,
    -- auto fold all imoprts
    -- close_fold_kinds_for_ft = { "imports" },
})
