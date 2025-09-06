return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- LSP Support
    'williamboman/mason.nvim',
    {
      'williamboman/mason-lspconfig.nvim',
      opts = {
        automatic_enable = {
          exclude = { 'jdtls' }
        }
      }
    },

    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },

    -- Autocomplete
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'saadparwaiz1/cmp_luasnip',

    -- Code Snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',

    'mfussenegger/nvim-jdtls',
  },
  config = function()
    vim.lsp.enable('jdtls')
    local autoformat_filetypes = { 'lua' }
    -- vim.api.nvim_create_autocmd('FileType', {
    --   pattern = 'java',
    --   callback = function(args)
    --     require 'jdtls.jdtls_setup'.setup()
    --   end
    -- })
    vim.api.nvim_create_autocmd('LSPAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end
        if vim.tbl_contains(autoformat_filetypes, vim.bo.filetype) then
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({
                formatting_options = { tabSize = 2, insertSpaces = true },
                bufnr = args.buf,
                id = client.id
              })
            end
          })
        end
      end
    })

    -- vim.lsp.buf.hover = vim.lsp.buf.hover({ border = 'rounded' })

    -- vim.lsp.buf.signature_help = vim.lsp.buf.signature_help({ border = 'rounded' })

    vim.diagnostic.config({
      virtual_text = true,
      severity_sort = true,
      float = {
        style = 'minimal',
        border = 'rounded',
        header = '',
        prefix = '',
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '✘',
          [vim.diagnostic.severity.WARN] = '▲',
          [vim.diagnostic.severity.HINT] = '⚑',
          [vim.diagnostic.severity.INFO] = '»',
        },
      },
    })

    local lspconfig_defaults = require('lspconfig').util.default_config
    lspconfig_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lspconfig_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    require('mason').setup()

    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls', 'eslint', 'ts_ls'
      },
      automatic_installation = true,
      handlers = {
        function(server_name)
          print('setup server: ' .. server_name)
          if server_name == 'jdtls' then return end
          require('lspconfig')[server_name].setup({})
        end,

        lua_ls = function()
          require('lspconfig').lua_ls.setup({
            -- settings = {
            --   Lua = {
            --     runtime = { version = 'LuatJIT' },
            --     diagnostics = { globals = { 'vim' } },
            --     workspace = { library = { vim.env.VIMRUNTIME } }
            --   }
            -- }
          })
        end,
        jdtls = function() end
      }
    })

    local cmp = require('cmp')
    require('luasnip.loaders.from_vscode').lazy_load()
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    cmp.setup({
      preselect = 'item',
      completion = {
        completeotp = 'menu,menuone,noinsert'
      },
      window = { documenation = cmp.config.window.bordered() },
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'buffer',  keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      formatting = {
        fields = { 'abbr', 'menu', 'kind' },
        format = function(entry, item)
          local n = entry.source.name
          if n == 'nvim_lsp' then
            item.menu = '[LSP]'
          else
            item.menu = string.format('[%s]', n)
          end
          return item
        end,
      },
      mapping = cmp.mapping.preset.insert({
        -- confirm completion item
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- scroll documentation window
        ['<C-f>'] = cmp.mapping.scroll_docs(5),
        ['<C-u>'] = cmp.mapping.scroll_docs(-5),

        -- toggle completion menu
        ['<C-e>'] = cmp.mapping(function(_)
          if cmp.visible() then
            cmp.abort()
          else
            cmp.complete()
          end
        end),

        -- tab complete
        -- ['<Tab>'] = cmp.mapping(function(fallback)
        --   local col = vim.fn.col('.') - 1

        --   if cmp.visible() then
        --     cmp.select_next_item({ behavior = 'select' })
        --   elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        --     fallback()
        --   else
        --     cmp.complete()
        --   end
        -- end, { 'i', 's' }),

        -- go to previous item
        -- ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),

        -- navigate to next snippet placeholder
        ['<C-d>'] = cmp.mapping(function(fallback)
          local luasnip = require('luasnip')

          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- navigate to the previous snippet placeholder
        ['<C-b>'] = cmp.mapping(function(fallback)
          local luasnip = require('luasnip')

          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
    })
  end,
}
