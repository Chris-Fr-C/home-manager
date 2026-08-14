local containers = require("custom.config.keymap-containers")


vim.pack.add(
  {
    "https://github.com/bloznelis/before.nvim"
  }
)
local before = require('before')
before.setup({})

-- Jump to previous entry in the edit history
vim.keymap.set('n', containers.root.key ..'gh', before.jump_to_last_edit, {desc="Go to next edition"})

-- Jump to next entry in the edit history
vim.keymap.set('n', containers.root.key..'gl', before.jump_to_next_edit, {desc="Go to previous edition"})

-- Look for previous edits in quickfix list
vim.keymap.set('n', containers.open.key..'q', before.show_edits_in_quickfix, {desc="Previous edit in [q]uickfix"})

-- Look for previous edits in telescope (needs telescope, obviously)
vim.keymap.set('n', containers.open.key.. 'e', before.show_edits_in_telescope, {desc="Show edits in [t]elescope"})


return {}
