function ReplaceAll()
	local target = vim.fn.input('Enter the text to replace: ')
  local replacement = vim.fn.input('Enter the replacement text: ')
	vim.cmd("%s/" .. vim.fn.escape(target, '/') .. "/" .. vim.fn.escape(replacement, '/') .. "/g")
end

vim.api.nvim_set_keymap('n', 'ra', '<cmd>lua ReplaceAll()<CR>', { noremap = true, silent = true })

