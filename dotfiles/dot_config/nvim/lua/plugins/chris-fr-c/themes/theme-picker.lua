return {
  "propet/colorscheme-persist.nvim",
  lazy = false, -- Required: Load on startup to set the colorscheme
  config = true, -- Required: call setup() function
  dependencies = {
    "nvim-telescope/telescope.nvim",
    -- NOTE: Add your colorscheme plugins here if you want lazy.nvim
    -- to manage them directly within this plugin specification.
    -- Oterwise, ensure they are installed elsewhere in your config.
    -- Example:
    "folke/tokyonight.nvim",
    "rebelot/kanagawa.nvim",
    "Th3Whit3Wolf/space-nvim",
    "bluz71/vim-moonfly-colors",
    "protesilaos/modus-themes",
    "catppuccin/nvim",
  },
  -- Set a keymap to open the picker
  keys = {
    {
      "<leader>Sc", -- Or your preferred keymap
      function()
        require("colorscheme-persist").picker()
      end,
      mode = "n",
      desc = "Choose colorscheme",
    },
    {
      "<leader>Sp",
      function()
        require("telescope.builtin").colorscheme()
      end,
      mode = "n",
      desc = "Preview colorscheme",
    },
  },
  -- Optional: Configure the plugin (see Configuration section below)
  opts = {
    -- Add custom options here, for example:
    -- fallback = "space-nvim",
    picker_opts = require("telescope.themes").get_dropdown(),
  },
}
