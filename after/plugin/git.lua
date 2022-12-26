local gsStatus, gitsigns = pcall(require, 'gitsigns')
if not gsStatus then return end

gitsigns.setup()

