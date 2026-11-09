local M = {}

function M.root_dir()
	return function()
		local root = vim.fs.root(0, { ".git", "pubspec.yaml", "package.json", "Cargo.toml", "go.mod" })
		return vim.fn.fnamemodify(root or vim.fn.getcwd(), ":t")
	end
end

function M.pretty_path(opts)
	opts = opts or {}
	return function()
		local path = vim.fn.expand(opts.relative == "cwd" and "%:." or "%:~")
		if path == "" then
			return "[No Name]"
		end
		-- Escape statusline control characters in file names.
		path = path:gsub("%%", "%%%%")
		local directory, filename = path:match("^(.*[/\\])([^/\\]+)$")
		directory, filename = directory or "", filename or path
		local function highlight(text, group)
			if not group or group == "" then
				return text
			end
			return "%#" .. group .. "#" .. text .. "%*"
		end
		local filename_hl = vim.bo.modified and opts.modified_hl or opts.filename_hl
		return highlight(directory, opts.directory_hl)
			.. highlight(filename, filename_hl)
			.. (vim.bo.modified and (opts.modified_sign or " [+]") or "")
			.. (vim.bo.readonly and (opts.readonly_icon or " [RO]") or "")
	end
end

function M.macro_recording()
	return function()
		local register = vim.fn.reg_recording()
		return register ~= "" and ("Recording @" .. register) or ""
	end
end

return M
