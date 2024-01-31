return {
	"VonHeikemen/lsp-zero.nvim",
	event = "InsertEnter",
	dependencies = {
		-- LSP Support
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- Autocomplete
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"saadparwaiz1/cmp_luasnip",
		-- Snippet
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local status, lsp = pcall(require, 'lsp-zero')
		if not status then return end

		lsp.preset('recommended')

		require('mason').setup({})

		require('mason-lspconfig').setup({
			ensure_installed = {
				'jdtls',
				'tsserver',
				'eslint',
				'lua_ls',
				'rust_analyzer',
				'gopls',
        -- 'kotlin-language-server',
			},
			handlers = {
				lsp.default_setup,
				lua_ls = function()
					local lua_opts = lsp.nvim_lua_ls()
					require('lspconfig').lua_ls.setup(lua_opts)
				end,
			},
		})

		local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

		local enable_format_on_save = function(_, bufnr)
			vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup_format,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end

		local on_attach = function(_, bufnr)
			local function buf_set_keymap(...)
				vim.api.nvim_buf_set_keymap(bufnr, ...)
			end

			local opts = { noremap = true, silent = true }

			buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
			buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
		end

		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		-- Fix Undefined global 'vim'
		lsp.configure('lua_ls', {
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' }
					}
				}
			},
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				enable_format_on_save(client, bufnr)
			end
		})

		lsp.configure('tsserver', {
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
			end,
			filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
			capabilities = capabilities
		})

		lsp.set_preferences({
			suggest_lsp_servers = true,
			setup_servers_on_start = true,
			set_lsp_keymaps = true,
			configure_diagnostics = true,
			cmp_capabilities = true,
			manage_nvim_cmp = true,
			sign_icons = {
				error = 'E',
				warn = 'W',
				hint = 'H',
				info = 'I'
			}
		})

		local cmp = require('cmp')
		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				['<CR>'] = cmp.mapping.confirm({ select = true }),
			})
		})

		lsp.setup()

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			update_in_insert = false,
			underline = true,
			severity_sort = false,
			float = true,
		})
	end
}
