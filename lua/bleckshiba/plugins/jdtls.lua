return {
	"mfussenegger/nvim-jdtls",
	ft = { 'java', 'kotlin' },
	config = function()
		local status, jdtls = pcall(require, 'jdtls')
		if not status then return end

		local jdtls_dir = vim.fn.stdpath('data') .. "/mason/packages/jdtls"
		local config_dir = jdtls_dir .. '/config_win'
		local plugin_dir = jdtls_dir .. '/plugins/'
		local path_to_jar = plugin_dir .. 'org.eclipse.equinox.launcher_1.6.500.v20230622-2056.jar'
		local path_to_lombok = jdtls_dir .. '/lombok.jar'

		local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
		local root_dir = require('jdtls.setup').find_root(root_markers)
		if root_dir == "" then return end

		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
		local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace_root/' .. project_name
		os.execute("mkdir", workspace_dir)

		local config = {
			cmd = {
				'C:/Program Files/Java/jdk-17.0.2/bin/java',
				'-Declipse.application=org.eclipse.jdt.ls.core.id1',
				'-Dosgi.bundles.defaultStartLevel=4',
				'-Declipse.product=org.eclipse.jdt.ls.core.product',
				'-Dlog.protocol=true',
				'-Dlog.level=ALL',
				'-javaagent:' .. path_to_lombok,
				'-Xms1g',
				'--add-modules=ALL-SYSTEM',
				'--add-opens', 'java.base/java.util=ALL_UNNAMED',
				'--add-opens', 'java.base/java.lang=ALL_UNNAMED',
				'-jar', path_to_jar,
				'-configuration', config_dir,
				'-data', workspace_dir,
			},
			root_dir = root_dir,
			settings = {
				java = {
					home = 'C:/Program Files/Java/jdk-17.0.2',
					eclipse = {
						downloadSources = true,
					},
					configuration = {
						updateBuildConfiguration = 'interactive',
						runtimes = {
							{
								name = "JavaSE-17",
								path = "C:/Program Files/Java/jdk-17.0.2",
							},
						},
					},
					maven = {
						downloadSources = true,
					},
					implementationCodeLens = { enabled = true },
					referencesCodeLens = { enabled = true },
					references = { includeDecompiledSources = true },
					format = {
						enabled = true,
						settings = {
							url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
							profile = "GoogleStyle",
						}
					},
				},
				signatureHelp = { enabled = true },
				completion = {
					favouriteStaticMembers = {
						"org.junit.jupiter.api.Assertions.*",
						"org.mockito.Mockito.*",
					},
					importOrder = {
						"java", "javax", "com", "org"
					},
				},
				sources = {
					organizeImports = {
						starThreshold = 9999,
						staticStartThreshold = 9999,
					},
				},
				codeGeneration = {
					useBlocks = true,
				},
				flags = {
					allow_incremental_sync = true,
				},
				init_options = {
					bundles = {},
				},
			},
		}

		-- config['on_attach'] = function(client, bufnr)
		-- end

		require('jdtls').start_or_attach(config)
	end
}
