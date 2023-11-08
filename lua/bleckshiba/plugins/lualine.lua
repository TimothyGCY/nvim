return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local lualine = require('lualine')
		local lazy_status = require('lazy.status')

		local colors = {
			blue = '#65D1FF',
			green = '#3EFFDC',
			violet = '#FF61EF',
			yellow = '#FFDAB7',
			red = '#FF4A4A',
			fg = '#C3CCDC',
			bg = '#112638',
			inactive_bg = '#2C3043',
			semilightgray = '#AEAEAE',
		}

		local theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = 'bold' },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = 'bold' },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = 'bold' },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = 'bold' },
				b = { bg = colors.bg, fg = colors.semilightgray },
				c = { bg = colors.bg, fg = colors.semilightgray },
			},
		}

		lualine.setup({
			options = {
				theme = theme,
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = '#FF9E64' },
					},
					{ 'encoding' },
					{ 'fileformat' },
					{ 'filetype' },
				},
			},
		})
	end
}
