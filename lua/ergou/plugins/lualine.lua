local function short_file_path()
  local path = vim.fn.expand('%')  -- Get the relative path to the file
  local segments = {}
  for segment in string.gmatch(path, "[^/]+") do
    table.insert(segments, segment)
  end
  local n = #segments
  if n > 2 then
    -- Show last two directories and the file name
    return segments[n-2] .. '/' .. segments[n-1] .. '/' .. segments[n]
  else
    -- Just return the path (less than 3 segments)
    return path
  end
end

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'UIEnter',
    opts = function()
      local icons = require('ergou.util.icons')
      local ui = require('ergou.util.ui')
      return {
        options = {
          theme = 'catppuccin',
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'starter' } },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {{ short_file_path, icon = '' }},
          lualine_x = {
            {
              function()
                return vim.t.maximized and icons.others.maximize or ''
              end,
            },
            {
              function()
                return require('noice').api.status.search.get()
              end,
              cond = function()
                return package.loaded['noice'] and require('noice').api.status.search.has()
              end,
              color = ui.fg('PreProc'),
            },
            {
              function()
                return require('noice').api.status.command.get()
              end,
              cond = function()
                return package.loaded['noice'] and require('noice').api.status.command.has()
              end,
              color = ui.fg('Statement'),
            },
            {
              function()
                return require('noice').api.status.mode.get()
              end,
              cond = function()
                return package.loaded['noice'] and require('noice').api.status.mode.has()
              end,
              color = ui.fg('Constant'),
            },
            {
              function()
                return '  ' .. require('dap').status()
              end,
              cond = function()
                return package.loaded['dap'] and require('dap').status() ~= ''
              end,
              color = ui.fg('Debug'),
            },
            {
              require('lazy.status').updates,
              cond = require('lazy.status').has_updates,
              color = ui.fg('Special'),
            },
            {
              'copilot',
            },
            'diagnostics',
          },
          lualine_y = {
            { 'progress', separator = ' ', padding = { left = 1, right = 1 } },
          },
        },
        extensions = { 'neo-tree', 'lazy' },
      }
    end,
  },
}
