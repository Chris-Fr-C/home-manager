vim.pack.add({
  "https://github.com/nvim-orgmode/orgmode",

  -- Colors highlight:
  "https://github.com/lukas-reineke/headlines.nvim",

  -- Org roam
  "https://github.com/chipsenkbeil/org-roam.nvim",
})

require("headlines").setup({})

require('orgmode').setup({
  org_agenda_files = '~/orgfiles/**/*',
  org_default_notes_file = '~/orgfiles/refile.org',
})

require("org-roam").setup({
    directory = "~/org_roam",
})
-- And the org roam mode


-- Experimental LSP support
vim.lsp.enable('org')
return {}
