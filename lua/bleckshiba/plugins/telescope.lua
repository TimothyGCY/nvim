return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			local status, telescope = pcall(require, 'telescope')
			if not status then return end

			-- telescope.load_extension('fzf')

			local builtin = require('telescope.builtin')
			local actions = require('telescope.actions')

			vim.keymap.set('n', 'ff', builtin.find_files, {})
			vim.keymap.set('n', 'gf', builtin.git_files, {})
			vim.keymap.set('n', '<C-F>', function()
				builtin.grep_string({ search = vim.fn.input("grep > ") })
			end)

			-- Telescope with File Browser extension
			local function telescope_buffer_dir()
				return vim.fn.expand('%:p:h')
			end

			local file_browser_actions = require 'telescope'.extensions.file_browser.actions

			telescope.setup {
				defaults = {
					mappings = {
						n = {
							["q"] = actions.close
						},
					},
				},
				extensions = {
					file_browser = {
						theme = "dropdown",
						hijack_netrw = true,
						mappings = {
							["i"] = {
								["<C-w>"] = function() vim.cmd('normal vbd') end,
							},
							["n"] = {
								["N"] = file_browser_actions.create,
								["h"] = file_browser_actions.goto_parent_dir,
								["/"] = function() vim.cmd('startinsert') end,
							},
						},
					},
				},
			}

			telescope.load_extension('file_browser')

			vim.keymap.set('n', 'sf', function()
				telescope.extensions.file_browser.file_browser({
					path = "%:p:h",
					cwd = telescope_buffer_dir(),
					respect_gitignore = false,
					hidden = true,
					group = true,
					previewer = false,
					initial_mode = "normal",
					layout_config = { height = 40 }
				})
			end)
		end
	},
	'nvim-telescope/telescope-file-browser.nvim',
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build =
		'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
	},
}
