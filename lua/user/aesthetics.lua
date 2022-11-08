-- Aesthetics-related configuration

-- Options
vim.opt.termguicolors = true           -- Enable 24-bit RGB color in terminal interface
vim.opt.background = 'dark'            -- Set background light/dark

-- Set everforest colorscheme and options
vim.cmd 'colorscheme everforest'
vim.g.everforest_background = 'medium'
vim.g.everforest_better_performance = true

-- Notification display plugin
vim.notify = require("notify")

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

-- Navic provides code structure context at current line (e.g. namespace > class::method)
local navic = require('nvim-navic')

require('lualine').setup({
  options = {
    theme = 'everforest',
  },
  sections = {
    -- Omit diagnostics from section b (originally 3rd component)
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
      { navic.get_location, cond = navic.is_available }
    },
  },
  inactive_winbar = {
    lualine_b = { 'filename' },
  }
})

-- Navic is setup here, but also must be attached in LSP setup
navic.setup()
