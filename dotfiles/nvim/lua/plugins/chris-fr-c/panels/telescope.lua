return {
  "nvim-telescope/telescope.nvim",

  config = function()
    require("telescope").setup({
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    })
  end,
}
