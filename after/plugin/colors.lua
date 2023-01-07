function TransparentBG()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function ChangeTheme(color)
	color = color or 'default'
	local theme = string.format('colorscheme %s', color)
	vim.cmd(theme)
end

ChangeTheme('github_dark_colorblind')
-- TransparentBG()
