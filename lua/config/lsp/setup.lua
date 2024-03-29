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
    },
    automatic_installation = { exclude = { "vuels" } },
})

local lspconfig = require("lspconfig")

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

        -- Check if tsserver should be disabled
        if require("neoconf").get(server_name .. ".disable") then
            return
        end

        -- Add TypeScript to the filetypes for volar
        if server_name == "volar" then
            server_config.filetypes = { 'vue', 'typescript', 'javascript' }
        end

        -- Setup the server
        lspconfig[server_name].setup(server_config)
    end,

    ["tsserver"] = function()
        -- Skip since we use typescript-tools.nvim
    end,

    ["tailwindcss"] = function()
        lspconfig.tailwindcss.setup({
            capabilities = require("config.lsp.servers.tailwindcss").capabilities,
            filetypes = require("config.lsp.servers.tailwindcss").filetypes,
            handlers = handlers,
            init_options = require("config.lsp.servers.tailwindcss").init_options,
            on_attach = require("config.lsp.servers.tailwindcss").on_attach,
            settings = require("config.lsp.servers.tailwindcss").settings,
        })
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
        lspconfig.eslint.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = require("config.lsp.servers.eslint").on_attach,
            settings = require("config.lsp.servers.eslint").settings,
        })
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

-- Ensure Volar and tsserver are installed
-- mason_lspconfig.setup({
-- })

require("ufo").setup({
    fold_virt_text_handler = ufo_config_handler,
    close_fold_kinds = { "imports" },
})
