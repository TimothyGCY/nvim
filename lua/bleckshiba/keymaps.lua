local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Split windows
keymap.set('n', 'ss', ':split<Return>', opts)
keymap.set('n', 'sv', ':vsplit<Return>', opts)

-- New tab
keymap.set('n', 'te', ':tabedit<Return>', opts)
keymap.set('n', '<tab>', ':tabnext<Return>', opts)
keymap.set('n', '<s-tab>', ':tabprev<Return>', opts)

-- Navigate window
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('n', '<C-left>', '<C-w>h')
keymap.set('n', '<C-right>', '<C-w>l')
keymap.set('n', '<C-up>', '<C-w>k')
keymap.set('n', '<C-down>', '<C-w>j')

-- Resize windows
keymap.set('n', '<A-left>', '<C-w><')
keymap.set('n', '<A-right>', '<C-w>>')
keymap.set('n', '<A-up>', '<C-w>+')
keymap.set('n', '<A-down>', '<C-w>-')

-- Delete a word
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Diagnostic
keymap.set('n', '<C-j>', function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set('n', 'K', '<Cmd> lua vim.lsp.buf.hover()<CR>', opts)
keymap.set('n', 'gd', '<Cmd> tab split | lua vim.lsp.buf.definition()<CR>', opts)
keymap.set('n', 'ca', '<Cmd> lua vim.lsp.buf.code_action()<CR>', opts)
keymap.set('n', 'fm', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
