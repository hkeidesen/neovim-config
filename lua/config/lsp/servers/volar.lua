local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'

-- Function to get the TypeScript server path
local function get_typescript_server_path(root_dir)
    local project_root = util.find_node_modules_ancestor(root_dir)
    return project_root and (util.path.join(project_root, 'node_modules', 'typescript', 'lib')) or ''
end


local volar_init_options = {
    typescript = {
        tsdk = '',
    },
}


local M = {}

M.default_config = {
    cmd = { 'vue-language-server', '--stdio' },
    filetypes = { 'vue', 'typescript', 'javascript' }, -- Add 'typescript' and 'javascript' here
    root_dir = util.root_pattern('package.json'),
    init_options = volar_init_options,
    on_new_config = function(new_config, new_root_dir)
        if
            new_config.init_options
            and new_config.init_options.typescript
            and new_config.init_options.typescript.tsdk == ''
        then
            new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
        end
    end,
}

-- You can add any additional setup, like on_attach, capabilities here
M.setup = function(on_attach, capabilities, handler)
    M.default_config.on_attach = on_attach
    M.default_config.capabilities = capabilities
    M.default_config.handlers = handler

    lspconfig.volar.setup(M.default_config)
end

return M
