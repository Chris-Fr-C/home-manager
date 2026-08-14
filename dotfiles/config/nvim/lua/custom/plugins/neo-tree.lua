-- This is for the tree view on the side.
-- Declare Neo-tree and its required dependencies using the native framework.
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  "https://github.com/s1n7ax/nvim-window-picker",
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
}


require 'window-picker'.setup({
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

  }
)

-- Quick keymap to toggle the sidebar tree view
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle File [E]xplorer' })

require('neo-tree').setup {
  filesystem = {
    window = {
      mappings = {
        ['\\'] = 'close_window',
        -- I want something like nvchad where when i select a file it lets me choose
        -- on which pane it goes.
        -- Overwrite the standard 'open' (Enter) command with the window picker
          ["<cr>"] = "open_with_window_picker",
      },
    },
  },
}



-- We return true to let Kickstart know the file successfully parsed
return true
