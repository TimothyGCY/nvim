local g = vim.g

local alpha = function ()
	local transparency_point = g.neovide_transparency_point or 0.7
	local transparency = 255 * transparency_point
	return string.format('%x', transparency)
end

g.neovide_transparency = 0.85
g.transparency = 0.85
-- g.neovide_background_color = '#0f1117'..alpha()

g.neovide_window_blurred = true
g.neovide_floating_blur_amount_x = 2.0
g.neovide_floating_blur_amount_y = 2.0

g.neovide_cursor_vfx_mode = 'sonicboom'

g.neovide_refresh_rate = 60

-- g.neovide_fullscreen = true

g.neovide_scale_factor = 0.7
g.neovide_padding_top = 0
g.neovide_padding_bottom = 0
g.neovide_padding_left = 0
g.neovide_padding_right = 0

