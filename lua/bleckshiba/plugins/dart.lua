return {
  {
    'akinsho/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    ft = { 'dart' },
    config = function()
      local tools = require('flutter-tools')
      tools.setup({
        widget_guides = { enabled = true },
        closing_tags = {
          highlight = 'ErrorMsg',
          prefix = '//',
          enabled = true,
        },
        lsp = {
          color = {
            enabled = true,
            background = false,
            foreground = false,
            virtual_text = true,
            virtual_text_string = '■',
          },
          settings = {
            showTodos = false,
            completeFunctionCalls = true,
            enableSnippets = true,
          },
          on_attach = function()
            vim.cmd('DartToggleFormatOnSave<CR>')
          end,
        },
      })
    end
  },
  { 'dart-lang/dart-vim-plugin', ft = { 'dart' } },
}
