local gh = function(x)
	return "https://github.com/" .. x
end

vim.pack.add({
	-- Shared dependency for Telescope and Flutter Tools
	{ src = gh("nvim-lua/plenary.nvim") },
	-- UI
	{ src = gh("craftzdog/solarized-osaka.nvim") },
	{ src = gh("thesimonho/kanagawa-paper.nvim"), version = "neovim" },
	{ src = gh("nvim-mini/mini.icons") },
	{ src = gh("folke/snacks.nvim") },
	{ src = gh("folke/trouble.nvim") },
	{ src = gh("nvim-lualine/lualine.nvim") },
	{ src = gh("b0o/incline.nvim") },
	{ src = gh("esmuellert/codediff.nvim") },
	{ src = gh("rachartier/tiny-cmdline.nvim") },
	-- Editor
	{ src = gh("stevearc/conform.nvim") },
	{ src = gh("nvim-treesitter/nvim-treesitter") },
	{ src = gh("mks-h/treesitter-autoinstall.nvim") },
	{ src = gh("nvim-mini/mini.pairs") },
	{ src = gh("craftzdog/mini.diff"), version = "feat/grouping" },
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("^1") },
	{ src = gh("folke/todo-comments.nvim") },
	{ src = gh("lewis6991/gitsigns.nvim") },
	{ src = gh("linrongbin16/gitlinker.nvim") },
	{ src = gh("tpope/vim-fugitive") },
	{ src = gh("brenoprata10/nvim-highlight-colors") },
	-- LSP
	{ src = gh("neovim/nvim-lspconfig") },
	{ src = gh("mfussenegger/nvim-jdtls") },
	{ src = gh("mason-org/mason.nvim") },
	{ src = gh("WhoIsSethDaniel/mason-tool-installer.nvim") },
	-- Util
	{ src = gh("stevearc/oil.nvim") },
	{ src = gh("zbirenbaum/copilot.lua") },
	{ src = gh("nvim-telescope/telescope.nvim") },
	{ src = gh("nvim-telescope/telescope-file-browser.nvim") },
	-- Dart / Flutter
	{ src = gh("dart-lang/dart-vim-plugin") },
	{ src = gh("mfussenegger/nvim-dap") },
	{ src = gh("nvim-flutter/flutter-tools.nvim") },
})

if #vim.api.nvim_get_runtime_file("lua/bleckshiba/plugins/local.lua", false) > 0 then
	require("bleckshiba.plugins.local")
end

require("bleckshiba.plugins.ui")
require("bleckshiba.plugins.treesitter")
require("bleckshiba.plugins.editor")
require("bleckshiba.plugins.lsp")
require("bleckshiba.plugins.utils")
require("bleckshiba.plugins.keymaps")
require("bleckshiba.plugins.telescope")
require("bleckshiba.plugins.dart")
