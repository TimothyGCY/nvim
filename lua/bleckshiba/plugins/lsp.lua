require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"tree-sitter-cli",
		"lua-language-server",
		"prettier",
		"prettierd",
		"stylua",
		"eslint-lsp",
		"oxlint",
		"oxfmt",
		"tailwindcss-language-server",
		"vtsls",
		"rust-analyzer",
		"jdtls",
		"gopls",
	},
	auto_update = false,
	run_on_start = true,
})

local capabilities = {
	workspace = {
		fileOperations = {
			didRename = true,
			willRename = true,
		},
	},
}
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(capabilities),
})

-- JAVA
local jdk17 = "C:/Program Files/Microsoft/jdk-17.0.21.21-hotspot"
local jdk21 = "C:/Program Files/Microsoft/jdk-21.0.13.21-hotspot"
-- The installed JDTLS build requires Java 25; project JDKs can remain 17/21.
local jdtls_java = vim.env.JDTLS_JAVA_HOME or "D:/JetBrains/IntelliJ IDEA/jbr"

local lsp_dir = vim.fn.stdpath("data") .. "/mason/packages"
local jdtls_dir = lsp_dir .. "/jdtls"

local config_dir = ""
if vim.fn.has("mac") == 1 then
	config_dir = "config_mac"
elseif vim.fn.has("unix") == 1 then
	config_dir = "config_linux"
else
	config_dir = "config_win"
end

local java_workspace = vim.fn.stdpath("data") .. "/jdtls-workspace"

vim.lsp.config.jdtls = {
	-- Advertise hover in the initialize response instead of waiting for the
	-- workspace import to dynamically register it. Requests can then queue.
	capabilities = { textDocument = { hover = { dynamicRegistration = false } } },
	-- JDTLS must know the Gradle JVM before importing the workspace. Applying it
	-- only via didChangeConfiguration can synchronously reimport every module.
	before_init = function(params, config)
		params.initializationOptions = params.initializationOptions or {}
		params.initializationOptions.settings = vim.deepcopy(config.settings)
	end,
	-- Resolve the root for each Java buffer, including projects opened after startup.
	root_markers = {
		{ "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts", ".git" },
		{ "pom.xml", "build.gradle", "build.gradle.kts", "build.xml" },
	},
	cmd = function(dispatchers, config)
		-- Check at launch so Neovim and Mason can start before JDTLS is installed.
		-- nosuf=true bypasses 'wildignore', which hides *.jar in our editor options.
		local launcher = vim.fn.glob(jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar", true, true)[1]
		assert(launcher and vim.fn.filereadable(launcher) == 1, "JDTLS launcher not found. Run :MasonInstall jdtls")
		assert(
			vim.fn.executable(jdtls_java .. "/bin/java.exe") == 1,
			"Set JDTLS_JAVA_HOME to your Java 25 installation"
		)
		local root = config.root_dir or vim.fn.getcwd()
		local workspace = vim.fs.joinpath(
			java_workspace,
			vim.fs.basename(root) .. "-" .. vim.fn.sha256(vim.fs.normalize(root)):sub(1, 12)
		)
		-- A JdtWipeDataAndRestart must not remove the configuration used to relaunch.
		local configuration = vim.fs.joinpath(java_workspace .. "-config", vim.fs.basename(workspace))
		vim.fn.mkdir(configuration, "p")
		local config_ini = vim.fs.joinpath(configuration, "config.ini")
		if vim.fn.filereadable(config_ini) == 0 then
			vim.fn.writefile(vim.fn.readfile(jdtls_dir .. "/" .. config_dir .. "/config.ini", "b"), config_ini, "b")
		end
		local cmd = {
			jdtls_java .. "/bin/java.exe",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-javaagent:" .. jdtls_dir .. "/lombok.jar",
			"-Xms1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",
			"-jar",
			launcher,
			"-configuration",
			configuration,
			"-data",
			workspace,
		}
		-- nvim-jdtls helpers inspect the active client's cmd table for -data.
		-- Native LSP passes a per-client config copy, so other projects keep the factory.
		config.cmd = cmd
		return vim.lsp.rpc.start(cmd, dispatchers, {
			cwd = config.cmd_cwd,
			env = config.cmd_env,
			detached = config.detached,
		})
	end,
	settings = {
		java = {
			-- Avoid rebuilding and running annotation processors across every module
			-- on startup/save. Use Gradle or :JdtCompile when a build is needed.
			autobuild = { enabled = false },
			-- Eclipse output is not a source tree. Refreshing generated files in bin
			-- caused thousands of build-path errors during workspace diagnostics.
			project = { resourceFilters = { "node_modules", "\\.git", "\\.gradle", "bin" } },
			diagnostic = { filter = { "**/bin/**" } },
			eclipse = { downloadSources = true },
			configuration = {
				runtimes = {
					{
						name = "JavaSE-17",
						path = jdk17,
					},
					{
						name = "JavaSE-21",
						path = jdk21,
						default = true,
					},
				},
			},
			-- Run Gradle with the project JDK rather than the server's Java 25.
			import = {
				gradle = {
					java = { home = jdk21 },
					-- Use Gradle for MapStruct/JPA generation instead of running
					-- processors for every module inside the language server.
					annotationProcessing = { enabled = false },
				},
			},
			maven = { downloadSources = true },
			implementationCodeLens = "none",
			referencesCodeLens = { enabled = false },
			references = { includeDecompiledSources = true },
			format = {
				enabled = true,
				settings = {
					url = vim.uri_from_fname(vim.fs.joinpath(vim.fn.stdpath("config"), "GoogleStyle.xml")),
				},
				tabSize = 2,
			},
			signatureHelp = { enabled = true },
			["jdt.ls.lombokSupport"] = { enabled = false },
			completion = {
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"org.mockito.Mockito.*",
				},
				importOrder = {
					"java",
					"javax",
					"com",
					"org",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = { useBlocks = true },
			inlayHints = {
				parameterNames = { enabled = "all" },
			},
		},
	},
	-- nvim-jdtls registers its own LspAttach handler.
	init_options = {
		bundles = vim.fn.glob(
			lsp_dir .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
			true,
			true
		),
	},
	flags = { allow_incremental_sync = true },
}

-- Dart
require("flutter-tools").setup({
	fvm = false,
	widget_guides = { enabled = true },
	ui = { border = "rounded" },
	debugger = {
		enabled = true,
		exception_breakpoints = {},
		evaluate_to_string_in_debug_views = true,
	},
	closing_tags = {
		highlight = "ErrorMsg",
		prefix = "--",
		enabled = true,
	},
	lsp = {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
		on_attach = function(_, bufnr)
			vim.lsp.document_color.enable(true, { bufnr = bufnr })
		end,
		settings = {
			showTodos = false,
			completeFunctionCalls = true,
			enableSnippets = true,
			analysisExcludedFolders = {},
			updateImportsOnRename = true,
		},
	},
})

-- Telescope must be configured before loading the Flutter extension.
require("telescope").load_extension("flutter")
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope flutter commands<cr>", {
	silent = true,
	desc = "Flutter commands",
})

vim.lsp.enable({
	"eslint",
	"oxlint",
	"lua_ls",
	"cssls",
	"vtsls",
	"tailwindcss",
	"glsl_analyzer",
	"rust_analyzer",
	"jdtls",
	"gopls",
})
