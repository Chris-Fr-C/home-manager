-- Docstring generator
return {
  "kkoomen/vim-doge",
  config = function()
    vim.cmd(":call doge#install()")
    vim.keymap.set("n", "<Leader>cg", "::DogeGenerate<CR>")
    vim.g.vdoge_enable_mapping = false
    vim.g.doge_python_settings = {
      single_quotes = false,
      omit_redundant_param_types = false,
    }
    vim.g.doge_doc_standard_python = "google"
  end,
}
