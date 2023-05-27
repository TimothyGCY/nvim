local status, lsp = pcall(require, 'lsp-zero')
if not status then return end

lsp.preset('recommended')

lsp.ensure_installed({
	'jdtls',
	'tsserver',
	'eslint',
	'lua_ls',
	'rust_analyzer',
	'gopls'
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

local on_attach = function (_, bufnr)
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
	on_attach = function (client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_save(client, bufnr)
	end
})

lsp.configure('tsserver', {
	on_attach = function (client, bufnr)
		on_attach(client, bufnr)
	end,
	filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
	capabilities = capabilities
})

lsp.configure('jdtls', {
	cmd = {
		'jdtls-win.cmd',
		'-configuration',
		'/Users/USER/AppData/Local/nvim-data/mason/packages/jdtls/config_win/',
		'-jar',
		'/Users/USER/AppData/Local/nvim-data/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
		'-data',
		'E:\\devenv\\Java',
	},

	root_dir = function()
		return vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw', 'build.gradle', 'pom.xml' }, { upward = true })[1])
	end,

	flags = { debounce_text_changes = 150 },

	on_attach = function (client, bufnr)
		on_attach(client, bufnr)
	end,
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['C-y'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})

lsp.nvim_workspace()

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

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
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


