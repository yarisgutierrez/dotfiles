local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
--  indent = {
--    enable = true,
--    disable = {},
 -- },
  ensure_installed = {
    "toml",
    "vim",
    "cpp",
    "c",
    "cpp",
    "json",
    "yaml",
    "swift",
    "lua",
    "python",
    "css",
    "html",
    "dockerfile",
    "go",
    "java",
    "javascript",
    "scss"
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
