return {
	{
		'windwp/nvim-autopairs',
		config = function()
			local autopair = require('nvim-autopairs')
			autopair.setup({
				disable_filetype = { 'TelescopePrompt', 'vim' },
			})
		end
	},
	{
		'windwp/nvim-ts-autotag',
		config = function()
			local autotag = require('nvim-ts-autotag')
			autotag.setup({})
		end,
	},
}
