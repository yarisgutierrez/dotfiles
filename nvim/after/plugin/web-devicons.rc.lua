local status, icons = pcall(require, "nvim-web-devicons")
if (not status) then return end

icons.setup {
  -- Personal icons go here (to override)
  -- DevIcon will be appended to `name`
  override = {
  },
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true
}
