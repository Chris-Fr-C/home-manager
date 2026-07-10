local containers = require("custom.config.keymap-containers")
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

local core = require("custom.config.core")
--- @type "cmdline_popup"|"mini"|"notify"|"virtualtext"|"split"
local view_type="mini"
require("noice").setup({
    -- Force general notifications (like vim.notify) to use mini view cuw less intrusive.
    notify = {
      view = view_type,
    },

  routes = {
    -- Custom notification modes to select where it goes
    {
            filter = {
                event = "notify",
                cond = function(msg)
                    return msg.opts and msg.opts.view == "cmdline_popup"
                end,
            },
            view = "cmdline_popup",
    },
    {
            filter = {
                event = "notify",
                cond = function(msg)
                    return msg.opts and msg.opts.view == "mini"
                end,
            },
            view = "mini",
    },

    {
            filter = {
                event = "notify",
                cond = function(msg)
                    return msg.opts and msg.opts.view == "notify"
                end,
            },
            view = "notify",
    },
    {
            filter = {
                event = "notify",
                cond = function(msg)
                    return msg.opts and msg.opts.view == "virtualtext"
                end,
            },
            view = "virtualtext",
    },


    {
            filter = {
                event = "notify",
                cond = function(msg)
                    return not msg.opts
                end,
            },
            view = "mini",
    },


    -- Normal errors and wars take too much space. Changing that to be on the bottom right.
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

vim.keymap.set("n", containers.open.key .. "n","", {desc="[n]otifications"})
vim.keymap.set("n", containers.open.key .. "nl", function()
  require("noice").cmd("last")
end, {desc="[l]ast"})

vim.keymap.set("n", containers.open.key .. "nh", function()
  require("noice").cmd("history")
end, {desc="[h]istory"} )

return {}

