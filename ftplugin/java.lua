local java17 = "C:\\Program Files\\Eclipse Adoptium\\jdk-17.0.14.7-hotspot"
local java21 = "C:\\Program Files\\Microsoft\\jdk-21.0.8.9-hotspot"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
local jdtls_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local plugin_dir = jdtls_dir .. '/plugins/'
local path_to_jar = vim.fn.glob(plugin_dir .. 'org.eclipse.equinox.launcher_*.jar')
local path_to_lombok = jdtls_dir .. '/lombok.jar'
local config_dir = ''
if vim.fn.has('mac') == 1 then
  config_dir = 'config_mac'
elseif vim.fn.has('unix') == 1 then
  config_dir = 'config_linux'
else
  config_dir = 'config_win'
end
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

local config = {
  cmd = {
    java21 .. '\\bin\\java.exe',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. path_to_lombok,
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', path_to_jar,
    '-configuration', jdtls_dir .. '/' .. config_dir,
    '-data', workspace_dir,

  },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', 'mvnw', '.gradle' }, { upward = true })[1]),
  settings = {
    java = {
      home = java21,
      eclipse = { downloadSources = true },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          {
            name = "Java-17",
            path = java17,
          },
          {
            name = "Java-21",
            path = java21,
            default = true,
          },
        },
      },
      maven = { downloadSources = true },
      implementationCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      format = {
        enabled = true,
        settings = {
          url = "file://" .. vim.fn.stdpath("config") .. "/google-style.xml",
          -- profile = "GoogleStyle",
        },
        tabSize = 2,
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
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = {},
  },
  on_attach = function(client, bufnr)
    vim.defer_fn(function()
      vim.lsp.start({
        name = "sonarlint",
        cmd = { "sonarlint-language-server", "-stdio" },
        root_dir = require('jdtls.setup').find_root(root_markers),
        filetypes = { "java" },
        init_options = {
          workspaceFolders = { workspace_dir },
        },
      })
    end, 1000)
  end,
}

require('jdtls').start_or_attach(config)

local lspconfig = require("lspconfig")
local lsp_configs = require('lspconfig.configs')

-- Register SonarLint LSP manually if not already defined
if not lsp_configs.sonarlint then
  lsp_configs.sonarlint = {
    default_config = {
      cmd = { "sonarlint-language-server", "-stdio" },
      filetypes = { "java" },
      root_dir = lspconfig.util.root_pattern("pom.xml", "build.gradle", ".git"),
      init_options = {
        workspaceFolders = {
          {
            uri = vim.uri_from_fname(vim.fn.getcwd()),
            name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
          },
        },
      },
      single_file_support = false,
    },
  }
end
