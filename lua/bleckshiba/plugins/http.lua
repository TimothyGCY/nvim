return {
  'rest-nvim/rest.nvim',
  config = function()
    local rest = require('rest-nvim')
    rest.setup({

      request = {
        skip_ssl_verification = true,

        hooks = {
          encode_url = true,
          -- user_agent = "rest.nvim v" .. require("rest-nvim.api").VERSION,
          set_content_type = true,
        }
      },

      response = {
        hooks = {
          decode_url = true,
          format = true,
        },
      },

      client = {
        curl = {
          statistics = {
            { id = "time_total",    winbar = "take", title = "Time taken" },
            { id = "size_download", winbar = "size", title = "Download size" },
          },

          opts = { set_compressed = false },
        },
      },

      cookies = {
        enable = true,
        -- path = vim.fs.joinpath(vim.fn.stdpath("data")
      },

      env = { enable = true, pattern = ".*%.env.*" },

      ui = {
        winbar = true,
        keybinds = { prev = "H", next = "L" }
      },

      highlight = { enable = true, timeout = 750 },

      _log_level = vim.log.levels.WARN,
    })

    require("telescope").load_extension("rest")

    -- vim.api.nvim_create_autocmd('FileType', {
    --   pattern = 'http',
    --   callback = function()
    vim.keymap.set('n', '<leader>rs', '<Cmd> Rest run<CR>', { noremap = true })
    vim.keymap.set('n', '<leader>rl', '<Cmd> Rest last<CR>', { noremap = true })
    --   end
    -- })
  end
}
