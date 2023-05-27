local status, tools = pcall(require, 'flutter-tools')
if not status then return end

tools.setup({

	widget_guides = { enabled = true },

	closing_tags = {
		highlight = "ErrorMsg",
		prefix = "//",
		enabled = true,
	},

	lsp = {
		color = {
			enabled = true,
			background = false,
			foreground = false,
			virtual_text = true,
			virtual_text_string = "■",
		},
		settings = {
			showTodos = true,
			completeFuntionCalls = true,
			enableSnippets = true,
		},
		on_attach = function(client, bufnr)
			print('flutter lsp attached')
			vim.cmd('DartToggleFormatOnSave<CR>')
		end,
	},

})
