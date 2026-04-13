return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewFileHistory",
  },
  keys = {
    -- Open diff against HEAD
    { "<leader>gco", "<cmd>DiffviewOpen<cr>", desc = "Git Diff (HEAD)" },

    -- Diff current file
    {
      "<leader>gcv",
      "<cmd>DiffviewOpen -- %<cr>",
      desc = "Git Diff (current file)",
    },

    -- File history
    {
      "<leader>gch",
      "<cmd>DiffviewFileHistory<cr>",
      desc = "Git File History",
    },

    -- Current file history
    {
      "<leader>gcf",
      "<cmd>DiffviewFileHistory %<cr>",
      desc = "Git File History (current file)",
    },
  },
}
