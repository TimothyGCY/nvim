return {
	{
		'lunarvim/synthwave84.nvim',
		config = function()
			local synthwave = require('synthwave84')
			synthwave.setup({
				glow = {
					error_msg = true,
					type2 = true,
					func = true,
					keyword = true,
					operator = true,
					buffer_current_target = true,
					buffer_visible_target = true,
					buffer_inactive_target = true,
				}
			})

			vim.cmd([[colorscheme synthwave84]])
		end
	}
}
