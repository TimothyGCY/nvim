local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local browser_actions = require("telescope._extensions.file_browser.actions")

telescope.setup({
	defaults = {
		mappings = { n = { q = actions.close } },
		preview = { treesitter = false },
		file_ignore_patterns = { "%.fvm[/\\]" },
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			-- Oil remains the default directory browser.
			hijack_netrw = false,
			mappings = {
				n = {
					N = browser_actions.create,
					h = browser_actions.goto_parent_dir,
					["/"] = function()
						vim.cmd.startinsert()
					end,
				},
			},
		},
	},
})
telescope.load_extension("file_browser")

local map = function(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map("ff", function()
	builtin.find_files({ hidden = true })
end, "Telescope find files")
map("<C-f>", builtin.live_grep, "Telescope live grep")
map("<leader><C-f>", function()
	builtin.grep_string({ search = vim.fn.input("grep > ") })
end, "Telescope grep")
map("<leader>gS", builtin.git_status, "Telescope Git status")
map("<leader>gc", builtin.git_commits, "Telescope Git commits")
map("<leader>fb", function()
	local dir = vim.fn.expand("%:p:h")
	telescope.extensions.file_browser.file_browser({
		path = dir,
		cwd = dir,
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
	})
end, "Telescope file browser")
