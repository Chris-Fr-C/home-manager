return {'akinsho/toggleterm.nvim', version = "*", config = function() 
    require("toggleterm").setup({})
      -- Toggleterm has default mappings that are conflicting.    
      -- Alt+h or Alt+Left to go back
      vim.keymap.set("n", "<A-h>", "<C-o>", { noremap = true, silent = true, desc = "Jump to previous location" })
      vim.keymap.set("n", "<A-Left>", "<C-o>", { noremap = true, silent = true, desc = "Jump to previous location" })

      -- Alt+l or Alt+Right to go forward
      vim.keymap.set("n", "<A-l>", "<C-i>", { noremap = true, silent = true, desc = "Jump to next location" })
      vim.keymap.set("n", "<A-Right>", "<C-i>", { noremap = true, silent = true, desc = "Jump to next location" })
end, lazy=false}
