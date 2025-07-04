-- Misc plugins

require'hex'.setup()
require'mini.trailspace'.setup()
require('osc52').setup {
  silent = false,
  trim = false,
}
require'smear_cursor'.enabled = true
