local status, colors = pcall(require, "lsp-colors")
if (not status) then return end

colors.setup{
  Error = "#e33400",
  Warning = "#e39400",
  Information = "#b3a1e6",
  Hint = "#5ccc96"
}
