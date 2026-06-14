  -- Useful plugin to show you pending keybinds.
vim.pack.add { 'https://github.com/folke/which-key.nvim' }
require('which-key').setup {
  -- Delay between pressing a key and opening which-key (milliseconds)
  delay = 0,
---@type false | "classic" | "modern" | "helix"
  preset = "helix",
  icons = { mappings = vim.g.have_nerd_font },
    -- This section forces which-key to listen to the 's' key for the surround commands.
    triggers = {
      { "<leader>", mode = { "n", "v" } },
      { "g", mode = { "n", "v" } },
      { "s", mode = { "n", "x" } },
    },
  -- Document existing key chains
  spec = {
    -- { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    -- { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
    { 's', group = '[s]urround', mode = { 'n', "x"} },
  },
}

return {}
