if vim.loader then
  vim.loader.enable()
end

_G.BleckShiba = require("bleckshiba.utils")
require("bleckshiba.config.keymaps")
require("bleckshiba.config.options")
require("bleckshiba.config.neovide")
require("bleckshiba.config.functions")
require("bleckshiba.config.workarounds")
require("bleckshiba.plugins")
