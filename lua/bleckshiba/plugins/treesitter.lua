return {
  {
    'nvim-treesitter/playground',
    -- cmd = "TSPlaygroundToggle",
    lazy = true,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'css',
        'gitignore',
        'go',
        'http',
        'java',
        'json',
        'rust',
        'scss',
        'sql',
        'svelte',
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_event = { 'BufWrite', 'CursorHold' },
      },
      playground = {
        enable = false,
        disable = {},
        updateTime = 25,
        persist_queries = true,
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<CR>',
          show_help = '?',
        },
      },
    },
    config = function(_, opts)
      require 'nvim-treesitter.configs'.setup(opts)

      vim.filetype.add({
        extension = { mdx = 'mdx' },
      })

      vim.treesitter.language.register('markdown', 'mdx')
    end
  },
}
