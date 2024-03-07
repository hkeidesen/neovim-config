local present, catppuccin = pcall(require, "catppuccin")
if not present then
    return
end

local c = require("catppuccin.core.integrations").get_colors()

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup Colorscheme                                        │
-- ╰──────────────────────────────────────────────────────────╯
catppuccin.setup({
    -- Configure colorscheme-specific options here
    -- Refer to the catppuccin documentation for available settings
    -- Example:
    -- transparent_background = false,
    -- term_colors = true,
    -- styles = {
    --   comments = "italic",
    --   conditionals = "italic",
    --   loops = "NONE",
    --   functions = "NONE",
    --   keywords = "italic",
    --   strings = "NONE",
    --   variables = "NONE",
    --   numbers = "NONE",
    --   booleans = "NONE",
    --   properties = "NONE",
    --   types = "NONE",
    --   operators = "NONE",
    -- },
    -- integrations = {
    --   treesitter = true,
    --   native_lsp = {
    --     enabled = true,
    --     virtual_text = {
    --       errors = "italic",
    --       hints = "italic",
    --       warnings = "italic",
    --       information = "italic",
    --     },
    --     underlines = {
    --       errors = "underline",
    --       hints = "underline",
    --       warnings = "underline",
    --       information = "underline",
    --     },
    --   },
    --   -- Other integrations...
    -- },
})

-- Set Colorscheme
vim.cmd("colorscheme catppuccin")

-- Custom highlight groups for Catppuccin
-- Replace 'EcovimPrimary', 'EcovimSecondary', etc., with your own group names
-- and adjust the colors to match the Catppuccin palette

-- Example:
-- vim.api.nvim_set_hl(0, "YourCustomGroup", { fg = c.blue })
-- ... other custom highlight groups ...

-- Catppuccin Colorscheme Specific Config
if EcoVim.colorscheme == "catppuccin" then
    -- Customize specific highlights for Catppuccin
    -- Example:
    vim.api.nvim_set_hl(0, "CursorLineNR", { fg = c.peach })
    vim.api.nvim_set_hl(0, "LineNr", { fg = c.surface0 })
    -- ... other specific highlights ...
end
