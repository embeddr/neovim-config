-- Misc plugins

require'hex'.setup()
require'mini.trailspace'.setup()
require('osc52').setup {
  silent = false,
  trim = false,
}
require'smear_cursor'.setup {
  vertical_bar_cursor = true,
  smear_insert_mode = true,
  stiffness = 0.9,
  distance_stop_animating = 0.5,
}
