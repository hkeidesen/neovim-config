local M = {}

M.setup = function(options)
    -- Your current setup logic goes here.
    -- Since it looks like you're not actually using the `options` parameter in your setup,
    -- you can keep your current configuration logic as is.

    -- Example:
    vim.opt.backup = false
    vim.opt.writebackup = false
    vim.opt.signcolumn = "yes"

    -- Rest of your configuration...
end

return M