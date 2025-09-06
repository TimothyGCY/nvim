local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Split windows
keymap.set('n', 'ss', ':split<Return>', opts)
keymap.set('n', 'sv', ':vsplit<Return>', opts)

-- New tab
keymap.set('n', 'te', ':tabedit<Return>', opts)
keymap.set('n', 'tn', ':tabnew<Return>', opts)
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

keymap.set('n', 'K', "<cmd>lua vim.lsp.buf.hover({ border = 'rounded' })<cr>", opts)
keymap.set('n', 'gd', '<cmd>tab split | lua vim.lsp.buf.definition()<cr>', opts)
keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
keymap.set('n', 'gs', "<cmd>lua vim.lsp.buf.signature_help({ border = 'rounded' })<cr>", opts)
keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
keymap.set('n', 'fm', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
keymap.set('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

keymap.set('n', '<leader>b', '<Cmd>BlamerShow<CR>', opts)
