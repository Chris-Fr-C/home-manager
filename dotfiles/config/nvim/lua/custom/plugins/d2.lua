local containers = require 'custom.config.keymap-containers'


vim.pack.add({
  "https://github.com/terrastruct/d2-vim"
})


--require("d2").setup({})

local d2_key=containers.visualize.key .. 'd'
vim.keymap.set('n',d2_key , '', { desc = '[d]2 diagram' })
vim.keymap.set('n',d2_key .."t" , '<cmd>D2PreviewToggle<cr>', { desc = '[t]oggle' })
vim.keymap.set('n',d2_key .."u" , '<cmd>D2PreviewUpdate<cr>', { desc = '[u]pdate' })
vim.keymap.set('n',d2_key .."v" , '<cmd>D2PreviewSelection<cr>', { desc = 'Pre[v]iew selection' })
vim.keymap.set('n',d2_key .."r" , '<cmd>D2ReplaceSelection<cr>', { desc = '[r]eplace selection with ascii' })
vim.keymap.set('n',d2_key .."a" , '<cmd>D2AsciiToggle<ce>', { desc = '[a]utomatic ASCII rendering on save' })
vim.keymap.set('n',d2_key .."a" , '<cmd>D2Playground<ce>', { desc = '[a]utomatic ASCII rendering on save' })

-- Enable/disable auto format on save (default: 1)
vim.g.d2_fmt_autosave = 1

-- Customize the format command (default: "d2 fmt")
vim.g.d2_fmt_command = "d2 fmt"

-- Fail silently when formatting fails (default: 0)
vim.g.d2_fmt_fail_silently = 0


-- Enable/disable auto ASCII render on save (default: 1)
vim.g.d2_ascii_autorender = 1

-- Customize the ASCII render command (default: "d2")
vim.g.d2_ascii_command = "d2"

-- Set preview window width for vertical split (default: half screen)
vim.g.d2_ascii_preview_width = math.floor(vim.o.columns / 2)

-- Set ASCII mode: "extended" (Unicode) or "standard" (basic ASCII)
vim.g.d2_ascii_mode = "extended"

-- Enable/disable auto validate on save (default: 0)
vim.g.d2_validate_autosave = 0

-- Customize the validate command (default: "d2 validate")
vim.g.d2_validate_command = "d2 validate"

-- Use quickfix or locationlist for errors (default: "quickfix")
vim.g.d2_list_type = "quickfix"

-- Fail silently when validation fails (default: 0)
vim.g.d2_validate_fail_silently = 0

-- Customize the play command (default: "d2 play")
vim.g.d2_play_command = "d2 play"

-- Set the theme ID (default: 0)
vim.g.d2_play_theme = 0

-- Enable sketch mode (default: 0)
vim.g.d2_play_sketch = 0




return {}
