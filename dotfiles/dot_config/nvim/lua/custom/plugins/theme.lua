vim.pack.add {
  'https://github.com/embark-theme/vim',
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/ellisonleao/gruvbox.nvim',
  'https://github.com/edeneast/nightfox.nvim',
  'https://github.com/catppuccin/nvim',
}



-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-hues.md#bundled-color-schemes
--- @alias Mini "miniwinter"|"minispring"|"miniautumn"
--- @alias Kanagawa "kanagawa"|"kanawaga-wave"
--- @alias Catppuccin "catppuccin-latte"|"catppuccin-frappe"|"catppuccin-macchiato"|"catppuccin-mocha"
--- @alias Carbonfox "carbonfox"|"nightfox"
---@type "embark"|"tokyonight" | Mini | Kanagawa | Catppuccin |"gruvbox"
local selected = 'catppuccin'


if (selected == "catppuccin") then
    require("catppuccin").setup({
        flavour = "auto", -- auto, latte, frappe, macchiato, mocha
        background = { -- :h background
            light = "latte",
            dark = "macchiato",
        },
        transparent_background = false, -- disables setting the background color.
        float = {
            transparent = false, -- enable transparent floating windows
            solid = false, -- use solid styling for floating windows, see |winborder|
        },
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
            functions = { "italic"},
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
        lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        auto_integrations = true,
        integrations = {
            blink_cmp={
                enabled=true,
                style="bordered",
            },
            overseer = true,
            lsp_trouble = true,
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            notify = true,
            mini = {
                enabled = true,
                indentscope_color = "",
            },
            which_key=true,
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
    })
end

vim.cmd.colorscheme(selected)

return {}
