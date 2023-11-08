return {
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		config = function()
			local autopair = require('nvim-autopairs')
			autopair.setup({
				disable_filetype = { 'TelescopePrompt', 'vim' },
			})
		end
	},
	{
		'windwp/nvim-ts-autotag',
		event = 'InsertEnter',
		config = true,
	},
}
