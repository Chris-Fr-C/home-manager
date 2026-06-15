local enable =false 

if enable then
  vim.pack.add {
    'https://github.com/nvim-focus/focus.nvim',
  }
  require('focus').setup {
    ui = {
      --I dont want to resize those type of panes:
      signalled_filetypes = { 'neo-tree', 'NvimTree', 'Outline', 'toggleterm' },
    },
  }
end

return {}
