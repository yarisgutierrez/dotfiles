local keymap = vim.keymap

-- Edit configuration files
keymap.set('n', ',ev', ':tabedit $MYVIMRC<CR>')
keymap.set('n', ',ez', ':vsp ~/.zshrc<CR>')
keymap.set('n', ',sv', ':source $MYVIMRC<CR>')

-- Open file under cursor in new tab
keymap.set('n', '<F2>', '<Esc><C-W>gF<CR>:tabm<CR>')

-- Base64 decode word under cursor (needs fixing)
keymap.set('n', ',b', ':!echo <C-R><C-W> \\| base64 -d<CR>')

-- Sort the buffer removing duplicates
keymap.set('n', ',s', ':%!sort -u --version-sort<CR>')

-- grep recursively for word under cursor
keymap.set('n', ',g', ":tabnew\\|read !grep -Hnr '<C-R><C-W>'<CR>")

-- Switch tabs
--keymap.set('n', '<C-Left>', ':tabprevious<CR>', { noremap = true })
--keymap.set('n', '<C-Right>', ':tabnext<CR>', { noremap = true })

-- Clear search highlights
keymap.set('n', ',<space>', ':noh<CR>')
