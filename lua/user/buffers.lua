-- Buffer-related setup

-- Plugin for clean buffer closing (e.g. not closing window)
local close_buffers = require('close_buffers')
close_buffers.setup({
  preserve_window_layout = { 'this', 'nameless' },
  next_buffer_cmd = nil,
})

local opts = { remap = false, silent = true }

-- Delete the current buffer
vim.keymap.set(
  'n',
  '<leader>d',
  -- Note: using command instead of function because invoking the function can cause
  -- undesirable behavior when attempting to delete a buffer with unsaved changes.
  ':BDelete this<CR>',
  opts
)

-- Forcibly delete the current buffer
vim.keymap.set(
  'n',
  '<leader>dd',
  ':BDelete! this<CR>',
  opts
)

-- Delete all hidden buffers
vim.keymap.set(
  'n',
  '<leader>h',
  ':BDelete hidden<CR>',
  opts
)

-- Forcibly delete all hidden buffers
vim.keymap.set(
  'n',
  '<leader>hh',
  ':BDelete! hidden<CR>',
  opts
)

-- Close the current window or quit if it's the last window
local close_or_quit = function()
  if #vim.api.nvim_list_wins() == 1 then
    vim.cmd('confirm qall')
  else
    vim.api.nvim_win_close(0, true)
  end
end

vim.keymap.set(
  'n',
  '<leader>c',
  close_or_quit,
  opts
)
