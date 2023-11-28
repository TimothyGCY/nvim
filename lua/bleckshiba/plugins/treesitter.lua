return {
	{
		'nvim-treesitter/playground',
		cmd = "TSPlaygroundToggle",
	},
	{
		'nvim-treesitter/nvim-treesitter',
		opts = {
			ensure_installed = {
				'astro',
				'cmake',
				'cpp',
				'css',
				'gitignore',
				'go',
				'graphql',
				'http',
				'java',
				'rust',
				'scss',
				'sql',
				'svelte',
			},
			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_event = { 'BufWrite', 'CursorHold' },
			},
			playground = {
				enable = true,
				diable = {},
				updateTime = 25,
				persist_queries = true,
				keybindings = {
					toggle_query_editor = 'o',
					toggle_hl_groups = 'i',
					toggle_injected_languages = 't',
					toggle_anonymous_nodes = 'a',
					toggle_language_display = 'I',
					focus_language = 'f',
					unfocus_language = 'F',
					update = 'R',
					goto_node = '<CR>',
					show_help = '?',
				},
			},
		},
		config = function(_, opts)
			require 'nvim-treesitter.configs'.setup(opts)
			-- {
			-- 	ensure_installed = { 'javascript', 'typescript', 'lua', 'c', 'java', 'css', 'html' },
			-- 	sync_install = false,
			-- 	auto_install = true,

			-- 	highlight = {
			-- 		enable = false,
			-- 		additional_vim_regex_highlighting = false,
			-- 	},

			-- 	autopairs = { enable = true },

			-- 	indent = { enable = true },

			-- 	context_commentstring = { enable = true, enable_autocmd = true },
			-- }

			vim.filetype.add({
				extension = { mdx = 'mdx' },
			})

			vim.treesitter.language.register('markdown', 'mdx')
		end
	},
}
