return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        winopts = {
          height = 0.85,
          width = 0.80,
          row = 0.35,
          col = 0.50,
          border = "rounded",
          preview = {
            layout = "right", -- 👈 this gives you file preview
            horizontal = "right:50%",
          },
        },

        previewers = {
          builtin = {
            extensions = {
              ["png"] = { "chafa",  },
              ["jpg"] = { "chafa",  },
              ["jpeg"] = { "chafa",  },
            },
          },
        },

        files = {
          prompt = "Files❯ ",
          previewer = "builtin",
        },

        grep = {
          prompt = "Grep❯ ",
          previewer = "builtin",
        },
      })
    end,
  },
}
