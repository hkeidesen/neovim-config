local bufferline_util = require('ergou.util.bufferline')
local icons = require('ergou.util.icons')

return {
    'akinsho/bufferline.nvim',
    opts = {
        options = {
            close_command = function(n)
                require('mini.bufremove').delete(n, false)
            end,
            right_mouse_command = function(n)
                require('mini.bufremove').delete(n, false)
            end,
            diagnostics = 'nvim_lsp',
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local s = ' '
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == 'error' and icons.diagnostics.Error
                        or (e == 'warning' and icons.diagnostics.Warn
                            or (e == 'info' and icons.diagnostics.Info or icons.diagnostics.Hint))
                    s = s .. n .. sym
                end
                return s
            end,
            separator_style = { "|", "|" },
            always_show_bufferline = true,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "EcovimNvimTreeTitle",
                    text_align = "center",
                    separator = true,
                },
            },
        },
    },
    --     config = function(_, opts)
    --         require('bufferline').setup(opts)
    --         vim.api.nvim_create_autocmd('BufAdd', {
    --             callback = function()
    --                 vim.schedule(function()
    --                     local ok, _ = pcall(require('bufferline').refresh)
    --                     if not ok then
    --                         print("Bufferline refresh failed")
    --                     end
    --                 end)
    --             end,
    --         })
    --     end,
}
