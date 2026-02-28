-- Tips when I am not being vimesque enough
if true then
  return {}
end
return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {

    disable_mouse = false,
    restriction_mode = "hint",
    disabled_keys = {},
  },
}
