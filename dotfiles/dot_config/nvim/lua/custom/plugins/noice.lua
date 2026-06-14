-- Mini doesnt have automatic cleanup for instance, and packages
-- seem to depend on noice anyway.
vim.pack.add({
    -- Dependencies:
    "https://github.com/MunifTanjim/nui.nvim",
    -- and for the notification view:
    "https://github.com/rcarriga/nvim-notify",
    -- Core:
    "https://github.com/folke/noice.nvim",
  }
)

require("noice").setup({
    -- Force general notifications (like vim.notify) to use mini view cuw less intrusive.
    notify = {
      view = "mini",
    },

    routes = {
      {
        -- To put long notifications into splits so it's easier to read.
        filter = {
          event = "notify",
          min_height = 15
        },
        view = 'split'
      },
      {
        filter={find="ERROR"},
        view="split",
      },

    },
  



  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})


return {}
