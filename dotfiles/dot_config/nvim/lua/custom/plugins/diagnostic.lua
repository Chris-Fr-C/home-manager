local container = require 'custom.config.keymap-containers'
vim.pack.add {
  'https://github.com/Kurama622/clean-diagnostic',
}

local diag = require 'clean-diagnostic'
diag.setup {
  border = 'rounded',
  min_severity = 4,
  max_width = 78,
}
vim.keymap.set('n', container.open.key .. 'd', diag.show, { desc = 'Show [d]iagnostic' })
return {}
