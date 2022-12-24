local config = {
	cmd = { 'java' },
	root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', '.gradlew'}),
	settings = {
		java = {
		}
	},
	init_options = {
		bundles = {
		}
	},
}

require('jdtls').start_or_attach(config)
