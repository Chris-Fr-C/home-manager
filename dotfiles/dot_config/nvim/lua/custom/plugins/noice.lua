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
    -- Normal errors and wars take too much space. Changing that to be on the bottom right.
    {
      filter = {
        any = {
          { error = true },
          { warning = true },
          { event = "msg_show", kind = { "error", "warning" } },
          { find = "ERROR" },
        },
      },
      view = "mini",
    },
    -- Put long notifications into splits so they don't block the screen.
    {
      filter = {
        event = "notify",
        min_height = 15
      },
      view = 'split'
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
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
})


return {}
