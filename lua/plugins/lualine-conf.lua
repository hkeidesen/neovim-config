-- Function to modify the file display in lualine
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

require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {{ short_file_path, icon = '' }},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }