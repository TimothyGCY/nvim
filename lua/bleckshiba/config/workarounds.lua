require("vim.treesitter._fold")
for _, au in ipairs(vim.api.nvim_get_autocmds({ event = "OptionSet" })) do
	if au.desc == "Refresh treesitter folds" then
		vim.api.nvim_del_autocmd(au.id)
	end
end
