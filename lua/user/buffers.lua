-- Buffer-related setup

-- Plugin for clean buffer closing (e.g. not closing window)
local close_buffers = require'close_buffers'
close_buffers.setup {
  preserve_window_layout = { 'this', 'nameless' },
  next_buffer_cmd = nil,
}

local opts = { remap = false, silent = true }

-- Forcibly delete the current buffer
vim.keymap.set(
  'n',
  '<leader>d',
  ':BDelete! this<CR>',
  opts
)

local try_delete_hidden = function()
  local status_ok, _ = pcall(function()
    close_buffers.delete({ type = 'hidden', force = false })
  end)
  if not status_ok then
    print("Failed to close one or more buffers. Is a terminal open?")
  end
end

-- Delete all hidden buffers
vim.keymap.set(
  'n',
  '<leader>h',
  try_delete_hidden,
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
  local win_list = vim.api.nvim_tabpage_list_wins(0)
  local visible_windows = 0

  -- Filter for non-floating windows
  for _, win in ipairs(win_list) do
    local config = vim.api.nvim_win_get_config(win)
    if not config.relative or config.relative == '' then
      visible_windows = visible_windows + 1
    end
  end

  if visible_windows == 1 then
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
