return {
  {
    "folke/snacks.nvim",
    opts = {
      -- Dashboard / startup screen
      dashboard = {
        enabled = true,
      },

      -- Big file optimizations
      bigfile = {
        enabled = false,
      },

      -- Quick file picker (like telescope)
      picker = {
        enabled = true,
      },

      explorer = { enabled = true },
      -- Notifications
      notifier = {
        enabled = false,
      },

      -- Terminal integration
      terminal = {
        enabled = false,
      },

      -- Git tools
      git = {
        enabled = false,
      },

      -- Lazygit integration
      lazygit = {
        enabled = false,
      },

      -- Scratch buffers
      scratch = {
        enabled = false,
      },

      -- Rename utility
      rename = {
        enabled = false,
      },

      -- Input UI (better vim.ui.input)
      input = {
        enabled = false,
      },

      -- Scope highlighting
      scope = {
        enabled = false,
      },

      -- Scroll animations
      scroll = {
        enabled = false,
      },

      -- Indent guides
      indent = {
        enabled = false,
      },

      -- Zen mode
      zen = {
        enabled = false,
      },

      -- Words highlight
      words = {
        enabled = false,
      },
    },
  },
  { "folke/noice.nvim", enabled = false },
}
