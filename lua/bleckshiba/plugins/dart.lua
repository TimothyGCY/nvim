-- Flutter Tools starts dartls itself; do not also vim.lsp.enable("dartls").
require("flutter-tools").setup({
	fvm = false,
	widget_guides = { enabled = true },
	ui = { border = "rounded" },
	debugger = {
		enabled = true,
		exception_breakpoints = {},
		evaluate_to_string_in_debug_views = true,
	},
	closing_tags = {
		highlight = "ErrorMsg",
		prefix = "--",
		enabled = true,
	},
	lsp = {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
		on_attach = function(_, bufnr)
			vim.lsp.document_color.enable(true, { bufnr = bufnr })
		end,
		settings = {
			showTodos = false,
			completeFunctionCalls = true,
			enableSnippets = true,
			analysisExcludedFolders = {},
			updateImportsOnRename = true,
		},
	},
})

-- Telescope must be configured before loading the Flutter extension.
require("telescope").load_extension("flutter")
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope flutter commands<cr>", {
	silent = true,
	desc = "Flutter commands",
})
