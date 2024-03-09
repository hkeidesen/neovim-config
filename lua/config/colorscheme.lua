local present, catppuccin = pcall(require, "catppuccin")
ads 
dsf 
aif not present then
  print("‼ Tried loading colorizer ... unsuccessfully.")
end

local c = require("catppuccin.colors").setup()
print(c)
-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup Colorscheme                                        │
-- ╰──────────────────────────────────────────────────────────╯
catppuccin.setup({
    flavour = "frappe",
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- Set Colorscheme
vim.cmd.colorscheme "catppuccin"


-- Ecovim Colors
vim.api.nvim_set_hl(0, "EcovimPrimary", { fg = "#488dff" })
vim.api.nvim_set_hl(0, "EcovimSecondary", { fg = "#FFA630" })

vim.api.nvim_set_hl(0, "EcovimPrimaryBold", { bold = true, fg = "#488DFF" })
vim.api.nvim_set_hl(0, "EcovimSecondaryBold", { bold = true, fg = "#FFA630" })

vim.api.nvim_set_hl(0, "EcovimHeader", { bold = true, fg = "#488DFF" })
vim.api.nvim_set_hl(0, "EcovimHeaderInfo", { bold = true, fg = "#FFA630" })
vim.api.nvim_set_hl(0, "EcovimFooter", { bold = true, fg = "#FFA630" })

vim.api.nvim_set_hl(0, "EcovimNvimTreeTitle", { bold = true, fg = "#FFA630", bg = "#16161e" })

-- Tokyonight Colorscheme Specific Config
if EcoVim.colorscheme == "tokyonight" then
  -- Lines
  vim.api.nvim_set_hl(0, "CursorLineNR", { link = "EcovimSecondary" })
  vim.api.nvim_set_hl(0, "LineNr", { link = "Comment" })

  -- Floats/Windows
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None", fg = "None" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "None", fg = "#488DFF" })
  vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "None", fg = "#488DFF" })
  vim.api.nvim_set_hl(0, "BufferTabpageFill", { fg = "None" })
  vim.api.nvim_set_hl(0, "VertSplit", { bg = "#16161e", fg = "#16161e" })
  vim.api.nvim_set_hl(0, "BqfPreviewBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "BufferInactiveIndex", { link = "BufferInactive" })
  vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })

  -- Tree
  vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { bg = "None", fg = "None" })

  -- Misc
  vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" })
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "None" })
  vim.api.nvim_set_hl(0, "rainbowcol1", { fg = c.blue, ctermfg = 9 })
  vim.api.nvim_set_hl(0, "TSRainbowRed", { fg = c.blue, ctermfg = 9 })
  vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = c.blue, ctermfg = 9 })
  vim.api.nvim_set_hl(0, "Boolean", { fg = "#F7768E" })
  vim.api.nvim_set_hl(0, "BufferOffset", { link = "EcovimSecondary" })
  vim.api.nvim_set_hl(0, "LspInlayHint", { link = "LspCodeLens" })

  -- Bufferline
  vim.api.nvim_set_hl(0, "BufferCurrentSign", { fg = c.cyan0 })
  vim.api.nvim_set_hl(0, "BufferInactiveSign", { bg = "#202331", fg = c.dark3 })
  vim.api.nvim_set_hl(0, "BufferInactiveMod", { bg = "NONE", fg = c.yellow })

  vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { bg = "#16161e", fg = "#16161e" })

  -- Completion Menu Colors
  local highlights = {
    CmpItemAbbr = { fg = c.dark3, bg = "NONE" },
    CmpItemKindClass = { fg = c.orange },
    CmpItemKindConstructor = { fg = c.purple },
    CmpItemKindFolder = { fg = c.blue2 },
    CmpItemKindFunction = { fg = c.blue },
    CmpItemKindInterface = { fg = c.teal, bg = "NONE" },
    CmpItemKindKeyword = { fg = c.magneta2 },
    CmpItemKindMethod = { fg = c.red },
    CmpItemKindReference = { fg = c.red1 },
    CmpItemKindSnippet = { fg = c.dark3 },
    CmpItemKindVariable = { fg = c.cyan, bg = "NONE" },
    CmpItemKindText = { fg = "LightGrey" },
    CmpItemMenu = { fg = "#C586C0", bg = "NONE" },
    CmpItemAbbrMatch = { fg = "#569CD6", bg = "NONE" },
    CmpItemAbbrMatchFuzzy = { fg = "#569CD6", bg = "NONE" },
  }

  vim.api.nvim_set_hl(0, "CmpBorderedWindow_FloatBorder", { fg = c.blue0 })

  for group, hl in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, hl)
  end
end
