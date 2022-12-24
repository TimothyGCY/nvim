local status, commented = pcall(require, 'commented')
if not status then return end

commented.setup({
	hooks = {
		before_comment = require('ts_context_commentstring.internal').update_commentstring
	}
})
