return {
  {
    'rest-nvim/rest.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local rest = require('rest-nvim')
      rest.setup({
        -- TODO: add config
      })
    end
  }
}
