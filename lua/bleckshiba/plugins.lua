vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
	function(use)
		use 'wbthomason/packer.nvim'

		use {
			'nvim-telescope/telescope.nvim', tag = '0.1.4',
			requires = {{'nvim-lua/plenary.nvim'}}
		}
		use 'nvim-telescope/telescope-file-browser.nvim'

		use 'folke/tokyonight.nvim'
		use 'projekt0n/github-nvim-theme'
		use 'lunarvim/synthwave84.nvim'

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
		use 'windwp/nvim-autopairs'
		use 'windwp/nvim-ts-autotag'

		use 'akinsho/nvim-bufferline.lua'
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

		use 'numToStr/Comment.nvim'

		-- Git
		use 'lewis6991/gitsigns.nvim'
		use 'tpope/vim-fugitive'

		use 'andweeb/presence.nvim'
	end
)
