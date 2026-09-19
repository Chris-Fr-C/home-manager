vim.pack.add({
  "https://github.com/nvim-orgmode/orgmode",

  -- Colors highlight:
  "https://github.com/lukas-reineke/headlines.nvim",

  -- Org roam
  "https://github.com/chipsenkbeil/org-roam.nvim",
})

require("headlines").setup({})


-- Check if a local project config exists in the current directory
local has_local_config = vim.fn.filereadable(".nvim.lua") == 1

if not has_local_config then
    require('orgmode').setup({
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',
    })

    require("org-roam").setup({
      directory = "~/org_roam",
    })
end

-- And the org roam mode


-- Experimental LSP support
vim.lsp.enable('org')
return {}
