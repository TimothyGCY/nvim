return {
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = 'InsertEnter',
    config = function()
      require('todo-comments').setup()
    end
  }
}
