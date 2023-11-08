return {
	{
		'akinsho/nvim-bufferline.lua',
		config = function()
			local bufferline = require('bufferline')

			bufferline.setup({
				options = {
					mode = "tabs",
					separator_style = 'slant',
					always_show_bufferline = false,
					show_buffer_close_icons = false,
					show_close_icon = false,
					color_icons = true
				},
				highlights = {
					separator = {
						fg = '#073642',
						bg = '#002b36',
					},
					separator_selected = {
						fg = '#073642',
					},
					background = {
						fg = '#657b83',
						bg = '#002b36'
					},
					buffer_selected = {
						fg = '#fdf6e3',
						bold = true,
					},
					fill = {
						bg = '#073642'
					}
				},
			})

			vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
			vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
		end,
	},
	{
		'akinsho/flutter-tools.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		ft = { 'dart' },
		config = function()
			local tools = require('flutter-tools')
			tools.setup({
				widget_guides = { enabled = true },
				closing_tags = {
					highlight = 'ErrorMsg',
					prefix = '//',
					enabled = true,
				},
				lsp = {
					color = {
						enabled = true,
						background = false,
						foreground = false,
						virtual_text = true,
						virtual_text_string = '■',
					},
					settings = {
						showTodos = true,
						completeFunctionCalls = true,
						enableSnippets = true,
					},
					on_attach = function(client, bufnr)
						print('flutter lsp attached')
						vim.cmd('DartToggleFormatOnSave<CR>')
					end,
				},
			})
		end
	},
	{ 'dart-lang/dart-vim-plugin', ft = { 'dart' } },
}
