return {
  "brenton-leighton/multiple-cursors.nvim",
  version = "*",

  lazy = false,
  config = function()
    require("multiple-cursors").setup()

    -- Alt + Up
    vim.keymap.set("n", "<A-Up>", "<Cmd>MultipleCursorsAddUp<CR>", {
      desc = "Add cursor up",
    })

    vim.keymap.set("x", "<A-Up>", "<Cmd>MultipleCursorsAddUp<CR>", {
      desc = "Add cursor up",
    })

    -- Alt + Down
    vim.keymap.set("n", "<A-Down>", "<Cmd>MultipleCursorsAddDown<CR>", {
      desc = "Add cursor down",
    })

    vim.keymap.set("x", "<A-Down>", "<Cmd>MultipleCursorsAddDown<CR>", {
      desc = "Add cursor down",
    })

    -- Mouse support
    vim.keymap.set({ "n", "x" }, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", {
      desc = "Toggle cursor with mouse",
    })

    -- Visual block / word selection
    vim.keymap.set("x", "<leader>m", "<Cmd>MultipleCursorsAddVisualArea<CR>", {
      desc = "Add cursors to visual area",
    })

    vim.keymap.set({ "n", "x" }, "<leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", {
      desc = "Add cursors to word",
    })

    vim.keymap.set({ "n", "x" }, "<leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", {
      desc = "Add cursors in previous area",
    })
  end,
}
