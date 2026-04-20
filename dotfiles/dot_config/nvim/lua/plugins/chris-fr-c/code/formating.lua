return {
  "stevearc/conform.nvim",

  event = "BufWritePre",

  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        fish = { "fish_indent" },
      },

      format_on_save = {
        timeout_ms = 3000,
        lsp_format = "fallback",
      },
    })

    -- manual format keymap (NvChad style)
    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      require("conform").format({ async = true })
    end, { desc = "Format file" })
  end,
}
