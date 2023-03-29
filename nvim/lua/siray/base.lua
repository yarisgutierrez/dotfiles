vim.cmd('autocmd!')

--vim.cmd('colorscheme decay')
require('decay').setup({
  style = 'dark',
  nvim_tree = {
    contrast = true
  }
})

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true
vim.opt.syntax = 'on'

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.wrap = false
vim.opt.backspace = { 'indent', 'eol', 'start' }

vim.cmd[[
"let base16colorspace=256
au BufNewFile,BufRead *.har set filetype=json
]]
