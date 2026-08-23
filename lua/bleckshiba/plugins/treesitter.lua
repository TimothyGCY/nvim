local treesitter = require "vim.treesitter"
return {
  {
    'nvim-treesitter/playground',
    cmd = "TSPlaygroundToggle",
    lazy = true,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    commit = "90cd658",
    main = "nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      local highlight = function(bufnr, lang)
        if not vim.treesitter.language.add(lang) then return end
        vim.treesitter.start(bufnr)
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local ft = vim.bo.filetype
          local bt = vim.bo.buftype
          local buf = args.buf

          if bt ~= "" then return end

          local ok, _ = pcall(require, 'nvim-treesitter')
          if not ok then return end

          vim.schedule(function()
            if vim.fn.mode() ~= "t" then
              vim.cmd "silent! normal! zx"
            end
          end)

          if not vim.tbl_contains({ "python", "html", "yaml", "markdown" }, ft) then
            vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
          end

          if vim.fn.executable "tree-sitter" ~= 1 then
            return false
          end

          if not vim.treesitter.language.get_lang(ft) then return end

          if vim.list_contains(treesitter.get_installed(), ft) then
            highlight(buf, ft)
          elseif vim.list_contains(treesitter.get_available(), ft) then
            treesitter.install(ft):await(function()
              highlight(buf, ft)
            end)
          end
        end
      })
    end,
    opts = {
      ensure_installed = {
        'go',
        'java',
        'json',
        'sql',
        'dart',
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
      local ok, ts = pcall(require, 'nvim-treesitter')
      if not ok then
        return
      end

      ts.setup(opts)
      if vim.fn.executable "tree-sitter" ~= 1 then
        vim.api.nvim_echo({
          {
            'tree-sitter CLI not found. Parsers cannot be installed.',
            'ErrorMsg',
          }
        }, true, {})
        return false
      end
      treesitter.install(opts.install)
    end
  },
}
