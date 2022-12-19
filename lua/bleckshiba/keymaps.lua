-- Split windows
vim.keymap.set('n', 'ss', ':split<Return><C-w>w')
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w>w')

-- Navigate window
vim.keymap.set('n', '<Space>', '<C-w>w')
vim.keymap.set('n', '<C-left>', '<C-w>h')
vim.keymap.set('n', '<C-right>', '<C-w>l')
vim.keymap.set('n', '<C-up>', '<C-w>k')
vim.keymap.set('n', '<C-down>', '<C-w>j')

-- Resize windows
vim.keymap.set('n', '<A-left>', '<C-w><')
vim.keymap.set('n', '<A-right>', '<C-w>>')
vim.keymap.set('n', '<A-up>', '<C-w>+')
vim.keymap.set('n', '<A-down>', '<C-w>-')

-- Delete a word
vim.keymap.set('n', 'dw', 'vb"_d')

-- Select all
vim.keymap.set('n', '<C-a>', 'gg<S-v>G')

