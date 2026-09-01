-- This is for the tree view on the side.
-- Declare Neo-tree and its required dependencies using the native framework.
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  "https://github.com/s1n7ax/nvim-window-picker",
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
}


local picker = require 'window-picker'
picker.setup({
    -- type of hints you want to get
    -- following types are supported
    -- 'statusline-winbar' | 'floating-big-letter' | 'floating-letter'
    -- 'statusline-winbar' draw on 'statusline' if possible, if not 'winbar' will be
    -- 'floating-big-letter' draw big letter on a floating window
    -- 'floating-letter' draw letter on a floating window
    -- used
    hint = 'floating-big-letter',

    -- when you go to window selection mode, status bar will show one of
    -- following letters on them so you can use that letter to select the window
    selection_chars = 'adfhjklqi',



	include_current=false,
    filter_rules = {
        bo = {
            filetype = { "neo-tree", "neo-tree-popup", "notify", "minifiles" },
            buftype = { "terminal", "quickfix", "minifiles" },
        },
    },
    other_win_hl_color = "#900000",
  }
)

-- Quick keymap to toggle the sidebar tree view
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle File [E]xplorer' })

require('neo-tree').setup({
  filesystem = {
    window = {
      mappings = {
        ['\\'] = 'close_window',

        ["<cr>"] = function(state)
          local node = state.tree:get_node()

          -- 1. Toggle directory if it's a folder
          if node.type == "directory" then
            require("neo-tree.sources.filesystem.commands").toggle_node(state)
            return
          end

          -- 2. Safely pick a window using window-picker
          local picked_window_id = picker.pick_window()

          -- 3. If a window was picked, set focus to it and open the file
          if picked_window_id then
            vim.api.nvim_set_current_win(picked_window_id)
            require("neo-tree.sources.filesystem.commands").open(state)
          else
            -- Fallback: If no pickable window exists (only Neo-tree is open),
            -- standard 'open' will automatically split into a new main pane.
            require("neo-tree.sources.filesystem.commands").open(state)
          end
        end,
      },
    },
  },
})


-- We return true to let Kickstart know the file successfully parsed
return true
