return {
  { 'dart-lang/dart-vim-plugin', ft = { 'dart' } },
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local tools = require('flutter-tools')

      tools.setup({
        fvm = false,
        widget_guides = { enabled = true },
        ui = {
          -- the border type to use for all floating windows, the same options/formats
          -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
          border = "rounded",
          -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
          -- please note that this option is eventually going to be deprecated and users will need to
          -- depend on plugins like `nvim-notify` instead.
          notification_style = 'native'
        },
        debugger = { -- integrate with nvim dap + install dart code debugger
          enabled = true,
          -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
          -- see |:help dap.set_exception_breakpoints()| for more info
          exception_breakpoints = {},
          -- Whether to call toString() on objects in debug views like hovers and the
          -- variables list.
          -- Invoking toString() has a performance cost and may introduce side-effects,
          -- although users may expected this functionality. null is treated like false.
          evaluate_to_string_in_debug_views = true,
          -- You can use the `debugger.register_configurations` to register custom runner configuration (for example for different targets or flavor). Plugin automatically registers the default configuration, but you can override it or add new ones.
          -- register_configurations = function(paths)
          --   require("dap").configurations.dart = {
          --     -- your custom configuration
          --   }
          -- end,
        },
        closing_tags = {
          highlight = 'ErrorMsg',
          prefix = '--',
          enabled = true,
        },
        lsp = {
          color = {
            enabled = true,
            background = { r = 19, g = 17, b = 24 },
            foreground = false,
            virtual_text = true,
            virtual_text_string = '■',
          },
          settings = {
            showTodos = false,
            completeFunctionCalls = true,
            enableSnippets = true,
            analysisExcludedFolders = {},
            updateImportsOnRename = true,
          },
          -- capabilities = {
          --   textDocument = { formatting = { dynamicRegistration = false } },
          -- },
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
          -- on_attach = function()
          --   vim.cmd([[DartToggleFormatOnSave]])
          -- end,
        },
      })

      require('telescope').load_extension('flutter')
    end,
  },
}
