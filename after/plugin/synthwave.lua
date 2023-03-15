local present, synthwave = pcall(require, 'synthwave84')
if not present then return end

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
