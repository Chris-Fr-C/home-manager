--- @param title string
--- @param msg string
--- @param level "DEBUG"|"INFO"|"WARN"|"ERROR"
--- @param view "cmdline_popup"|"mini"|"notify"|"virtualtext"|"split"
function notify(title, msg, level, view)
  require("noice").notify(
    msg,
    level,
    {
      title=title,
      view=view,
    }
  )
end

return {
  notify = notify,

}
