  -- [[ mini.nvim ]]
  --  A collection of various small independent plugins/modules
vim.pack.add {  'https://github.com/nvim-mini/mini.nvim' }

-- If a nerd font is available, load the icons module for pretty icons in various plugins.
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
  MiniIcons.mock_nvim_web_devicons()
end

  -- Ai has NOTHING to do with artificial intellicrap.
  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup {
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }


-- Surround has its own file
-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
-- removing the default so we can add our own documentation.
require("mini.surround").setup({ mappings = {} })
-- Normal Mode Maps
vim.keymap.set("n", "sa", function() require("mini.surround").add('normal') end, { desc = "Add Surrounding" })
vim.keymap.set("n", "sd", function() require("mini.surround").delete() end,      { desc = "Delete Surrounding" })
vim.keymap.set("n", "sr", function() require("mini.surround").replace() end,     { desc = "Replace Surrounding" })
vim.keymap.set("n", "sf", function() require("mini.surround").find() end,        { desc = "Find Surrounding (Right)" })
vim.keymap.set("n", "sF", function() require("mini.surround").find_left() end,   { desc = "Find Surrounding (Left)" })
vim.keymap.set("n", "sh", function() require("mini.surround").highlight() end,   { desc = "Highlight Surrounding" })

local status_ok, wk = pcall(require, "which-key")
if status_ok then
  wk.add({
    -- Normal Mode Menu Configuration
    { "sa", desc = "Add Surrounding", mode = "n" },
    { "sd", desc = "Delete Surrounding", mode = "n" },
    { "sr", desc = "Replace Surrounding", mode = "n" },
    { "sf", desc = "Find Surrounding (Right)", mode = "n" },
    { "sF", desc = "Find Surrounding (Left)", mode = "n" },
    { "sh", desc = "Highlight Surrounding", mode = "n" },

    -- Visual Mode Menu Configuration
    { "s", group = "Surround", mode = "x" },
    { "sa", desc = "Add Surrounding", mode = "x" },
  })
end
-- Note that init already has default mini as some things require it.
-- gcc comments are stable asf.
require("mini.comment").setup()


-- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
local statusline = require 'mini.statusline'
-- Set `use_icons` to true if you have a Nerd Font
statusline.setup { use_icons = vim.g.have_nerd_font }

-- You can configure sections in the statusline by overriding their
-- default behavior. For example, here we set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end


return {}
