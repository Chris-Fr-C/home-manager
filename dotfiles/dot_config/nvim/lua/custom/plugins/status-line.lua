local MINI = 'mini'
local LUA = 'lua'
local line = LUA

if line == LUA then
  vim.pack.add {
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim',
  }
  require('lualine').setup {
    sections = {
      lualine_x = { 'overseer' },
    },
  }
elseif line == MINI then
  -- Simple and easy statusline.
  --  You could remove this setup call if you don't like it,
  --  and try some other statusline plugin
  local statusline = require 'mini.statusline'
  -- Set `use_icons` to true if you have a Nerd Font
  statusline.setup {
    use_icons = vim.g.have_nerd_font,
    -- Set content structure manually for a cleaner look
    content = {
      -- Custom active statusline layout
      active = function()
        local mode, mode_hl = statusline.section_mode {}
        local git = statusline.section_git { tracing = true }
        local diagnostics = statusline.section_diagnostics { tracing = true }
        local filename = statusline.section_filename { tracing = true }
        local fileinfo = statusline.section_fileinfo { tracing = true }
        local location = statusline.section_location { tracing = true }

        -- Helper to elegantly parse active LSP servers
        local lsp_status = ''
        local buf_clients = vim.lsp.get_clients { bufnr = 0 }
        if next(buf_clients) ~= nil then
          local names = {}
          for _, c in pairs(buf_clients) do
            table.insert(names, c.name)
          end
          lsp_status = ' 󰄭 ' .. table.concat(names, ', ') .. ' '
        end

        -- Assemble components with sharp bar separators (│) and spacing
        return statusline.combine_groups {
          { hl = mode_hl, strings = { ' ' .. mode .. ' ' } },
          { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
          '%<', -- Mark where text cuts off if the window gets too small
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          '%=', -- Separation point (pushes everything below to the right side)
          { hl = 'MiniStatuslineFileinfo', strings = { lsp_status, fileinfo } },
          { hl = mode_hl, strings = { ' ' .. location .. ' ' } },
        }
      end,
    },
  }

  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l:%-2v' end
end

return {}
