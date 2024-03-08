local present, catppuccin = pcall(require, "catppuccin")
if not present then
    return
end

local c = require("catppuccin.core.integrations").get_colors()

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup Colorscheme                                        │
-- ╰──────────────────────────────────────────────────────────╯
catppuccin.setup({
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    -- color_overrides = {
    --     all = {
    --         text = "#ffffff",
    --     },
    --     latte = {
    --         base = "#ff0000",
    --         mantle = "#242424",
    --         crust = "#474747",
    --     },
    --     frappe = {},
    --     macchiato = {},
    --     mocha = {},
    -- }
})
