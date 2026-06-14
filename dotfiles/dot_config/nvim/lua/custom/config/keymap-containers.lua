-- This changes often based on my tastes. So we make it a variable that we can use and
-- append based on the organisation we want.
local containers = {
  config = { key = '<leader>C', desc = '[C]onfig' },
  config_vim = { key = '<leader>Cv', desc = '[C]onfig [V]im' },
  quit = { key = '<leader>q', desc = '[q]uit ...' },
  find = { key = '<leader>f', desc = '[f]ind ...' },
  git = { key = '<leader>g', desc = '[g]it ...' },
}

-- Automatically register the root descriptions for UI menus
for _, target in pairs(containers) do
  vim.keymap.set('n', target.key, '', { desc = target.desc })
end

return containers
