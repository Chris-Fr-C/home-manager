vim.pack.add {
  'https://github.com/nvim-zh/colorful-winsep.nvim',
}

require('colorful-winsep').setup {
  -- choose between "single", "rounded", "bold" and "double".
  border = 'bold',
  highlight = nil, -- nil|string|function. See the docs's Highlights section
  animate = {
    ---@type "shift"|"progressive"|false
    enabled = 'shift', -- false to disable or choose a option below (e.g. "shift") and set option for it if needed
    shift = {
      delay = 16, -- about 60fps
      frames = 15, -- how many frames are required to complete the animation
      easing = 'ease_out_cubic', -- available algorithms: linear, ease_out_cubic, ease_in_out_sine, ease_out_quad, ease_out_expo
    },
    progressive = {
      delay = 16,
      vertical_lerp_factor = 0.15, -- between 0 and 1
      horizontal_lerp_factor = 0.15, -- between 0 and 1
    },
  },
  indicator_for_2wins = {
    -- only work when the total of windows is two
    position = 'both', -- false to disable or choose between "center", "start", "end" and "both"
    symbols = {
      -- the meaning of left, down ,up, right is the position of separator
      start_left = '󱞬',
      end_left = '󱞪',
      start_down = '󱞾',
      end_down = '󱟀',
      start_up = '󱞢',
      end_up = '󱞤',
      start_right = '󱞨',
      end_right = '󱞦',
    },
  },
  -- Add a custom color array. Single color applies statically, multiple colors will create a marquee effect.
  colors = {
    '#a6d189',
    -- "#e5c890",
    -- "#e78284",
    -- "#ca9ee6",
    '#8caaee',
  },
}

return {}
