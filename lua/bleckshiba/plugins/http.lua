return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }
    }
  },
  {
    'rest-nvim/rest.nvim',
    ft = 'http',
    dependencies = { 'luarocks.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      local rest = require('rest-nvim')
      rest.setup({
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = true,
        -- Encode URL before making request
        encode_url = true,
        -- Highlight request on run
      })
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local buf = tonumber(vim.fn.expand('<abuf>'), 10)
          vim.keymap.set('n', '<leader>rs', rest.run, { noremap = true, buffer = buf })
          vim.keymap.set('n', '<leader>rp', function()
            rest.run(true)
          end, { noremap = true, buffer = buf })
          vim.keymap.set('n', '<leader>rl', rest.last, { noremap = true, buffer = buf })
        end
      })
    end
  }
}
