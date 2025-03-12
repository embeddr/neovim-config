-- Aesthetics-related configuration

-- Options
vim.opt.termguicolors = true           -- Enable 24-bit RGB color in terminal interface
vim.opt.background = 'dark'            -- Set background light/dark

-- Set everforest colorscheme and options
vim.g.everforest_background = 'medium'
vim.g.everforest_better_performance = true
vim.g.everforest_dim_inactive_windows = false
vim.g.everforest_ui_contrast = 'low'
vim.g.everforest_colors_override = {
  bg0 = {'#31383D', '234'},
  bg1 = {'#31383D', '234'},
}
vim.cmd 'colorscheme everforest'

-- Notification display plugin
vim.notify = require'notify'

-- Cleaner inline diagnostics
vim.diagnostic.config({virtual_text = false})
require'tiny-inline-diagnostic'.setup({
  preset = "powerline",
  options = {
    show_source = true,
    multiple_diag_under_cursor = true,
    multilines = true,
  }
})

-- Override encoding to only display if encoding isn't UTF-8.
local encoding = function()
  local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
  return ret
end

-- Override fileformat to only display if format isn't Unix.
local fileformat = function()
  local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
  return ret
end

require'lualine'.setup {
  options = {
    theme = 'everforest',
  },
  sections = {
    -- Omit diagnostics from section b (3rd component by default)
    lualine_b = { 'branch', 'diff', '' },
    -- Display file path relative to working directory
    lualine_c = {
      { 'filename', path = 1 },
    },
    lualine_x = { encoding, fileformat, 'filetype' },
  },
  inactive_sections = {
    -- Display file path relative to working directory
    lualine_c = {
      { 'filename', path = 1},
    },
  },
  winbar = {
    lualine_a = { 'filename' },
    lualine_c = {
      -- Display code context with navic, if available
      -- Note: Can also define a function that invokes navic.get_location()
      {
        'navic',
      }
    },
  },
  inactive_winbar = {
    lualine_b = { 'filename' },
  }
}
