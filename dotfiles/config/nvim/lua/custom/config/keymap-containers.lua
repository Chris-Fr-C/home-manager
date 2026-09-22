local local_leader=",";

-- This changes often based on my tastes. So we make it a variable that we can use and
-- append based on the organisation we want.
local containers = {
  local_leader = {key=local_leader, desc="Local leader", alias=true},
  config = { key = '<leader>C', desc = '[C]onfig' },
  config_vim = { key = '<leader>Cv', desc = '[v]im' },
  quit = { key = '<leader>q', desc = '[q]uit' },
  find = { key = '<leader>f', desc = '[f]ind' },
  generate = {key="<leader>g", desc="[g]enerate or [g]it"},
  git = { key = '<leader>g', desc = '[g]it', alias= true},
  lsp = {key="<leader>c", desc="[c]ode"},
  code = {key="<leader>c", desc="[c]ode", alias=true},
  evaluate = {key=local_leader.."e", desc="[e]valuate"},
  diagnostic = {key="<leader>ct", desc="[t]roubles diagnostic"},
  open = {key="<leader>v", desc="[v]isualize", alias=true},
  build = {key="<leader>b", desc="[b]uild"},
  execute = {key="<leader>x", desc="E[x]ecute"},
  debug = {key="<leader>d", desc="[d]ebug"},
  visualize = {key="<leader>v", desc="[v]isualize"}, -- just here so the linter helps us to know where it is used.

  -- Not using obsidian for the moment
  -- obsidian = {key=local_leader.."o", desc="[o]bsidian"}, -- just here so the linter helps us to know where it is used.
  terminal = {key="<leader>t", desc="[t]erminal"}, -- just here so the linter helps us to know where it is used.
  org = {key="<leader>o", desc="[o]rg"},
  window = { key = '<leader>w', desc = '[w]indow' },
  root = {key="", desc=""}, -- just here so the linter helps us to know where it is used.

}

-- Automatically register the root descriptions for UI menus
for _, target in pairs(containers) do
  if target.key ~= "" and not target.alias then
    vim.keymap.set('n', target.key, '', { desc = target.desc })
  end

end

return containers
