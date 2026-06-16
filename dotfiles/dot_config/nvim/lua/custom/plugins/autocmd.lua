-- Create an autocommand group for macro notifications so I know when it's in that mode by accident.
local macro_group = vim.api.nvim_create_augroup("MacroNotifications", { clear = true })

local core = require("custom.config.core")

-- Notification on START recording
vim.api.nvim_create_autocmd("RecordingEnter", {
  group = macro_group,
  callback = function()
    local reg = vim.fn.reg_recording()

    if reg ~= "" then
      -- Manually choosing noice so i can specify the format for that and not interfere.
      core.notify("Macro", "Recording macro to @"..reg, "WARN", "notify")
      -- vim.notify("Recording macro to @" .. reg, vim.log.levels.INFO, {
      --   title = "Macro",
      --   timeout = 2000, -- Adjust how long you want the notification to stay (in ms)
      -- })
    end
  end,
})

-- Notification on STOP recording
vim.api.nvim_create_autocmd("RecordingLeave", {
  group = macro_group,
  callback = function()

    local noice = require("noice")
    core.notify("Macro", "Stopped recording macro", "WARN", "notify")

 
    -- vim.notify("Stopped recording macro", vim.log.levels.INFO, {
    --   title = "Macro",
    --   timeout = 2000,
    -- })
  end,
})


return {}
