return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = function() vim.cmd([['TSUpdate']]) end,
		config = function()
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = { 'javascript', 'typescript', 'lua', 'c', 'java', 'css', 'html' },
				sync_install = false,
				auto_install = true,

				highlight = {
					enable = false,
					additional_vim_regex_highlighting = false,
				},

				autopairs = { enable = true },

				indent = { enable = true },

				context_commentstring = { enable = true, enable_autocmd = true },
			}
		end
	},
}
