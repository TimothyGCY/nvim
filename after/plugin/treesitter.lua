require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {"help", "javascript", "typescript", "lua", "c", "java", "css", "html"},
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false,
  },

	autopairs = { enable = true },

	indent = { enable = true },

	context_commentstring = {
		enable = true,
		enable_autocmd = true
	}
}
