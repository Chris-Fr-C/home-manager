-- This changes often based on my tastes. So we make it a variable that we can use and
-- append based on the organisation we want.
local containers = {
  config = { key = '<leader>C', desc = '[C]onfig' },
  config_vim = { key = '<leader>Cv', desc = '[v]im' },
  quit = { key = '<leader>q', desc = '[q]uit' },
  find = { key = '<leader>f', desc = '[f]ind' },
  git = { key = '<leader>g', desc = '[g]it' },
  lsp = {key="<leader>l", desc="[l]sp"},
  goto = {key="g", desc="[g]oto"},
  code = {key="<leader>c", desc="[c]ode"},
  open = {key="<leader>o", desc="[o]pen"},
  build = {key="<leader>ob", desc="[b]uild"},
  execute = {key="<leader>x", desc="E[x]ecute"},
  diagnostic = {key="<leader>ct", desc="[t]roubles diagnostic"},
  root = {key="", desc=""}, -- just here so the linter helps us to know where it is used.
}

-- Automatically register the root descriptions for UI menus
for _, target in pairs(containers) do
  if target.key ~= "" then  
    vim.keymap.set('n', target.key, '', { desc = target.desc })
  end

end

return containers
