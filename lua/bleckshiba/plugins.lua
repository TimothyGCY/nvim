vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = {{'nvim-lua/plenary.nvim'}}
	}
	use 'nvim-telescope/telescope-file-browser.nvim'

	use 'folke/tokyonight.nvim'

	use(
	'nvim-treesitter/nvim-treesitter',
	{ run = ':TSUpdate' }
	)
	use 'nvim-treesitter/playground'
	use 'JoosepAlviste/nvim-ts-context-commentstring'

	use 'mbbill/undotree'

	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}

	use {
		'akinsho/flutter-tools.nvim',
		requires = 'nvim-lua/plenary.nvim'
	}
	use 'dart-lang/dart-vim-plugin'

	use({
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
	})

	use 'mfussenegger/nvim-jdtls'

	use({
		'winston0410/commented.nvim',
		config = function()
			require('commented').setup({
				codetags_keybindings = {
					fixme         = '<leader>f',
					fixme_line    = '<leader>ff',
					todo          = '<leader>t',
					todo_line     = '<leader>tt',
					bug           = '<leader>b',
					bug_line      = '<leader>bb',
					note          = '<leader>n',
					note_line     = '<leader>nn',
					wont_fix      = '<leader>w',
					wont_fix_line = '<leader>ww',
				}
			})
		end
	})
end
)
