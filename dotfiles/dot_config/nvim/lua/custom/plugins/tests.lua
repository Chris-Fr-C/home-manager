vim.pack.add {
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/antoinemadec/FixCursorHold.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-neotest/neotest',

  -- Language specifics
  'https://github.com/nvim-neotest/neotest-python',
  'https://github.com/alfaix/neotest-gtest',
}


require("neotest").setup({})

return {}
