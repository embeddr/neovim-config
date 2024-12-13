-- Autocommands
-- Disable relative line numbers when in insert mode
vim.api.nvim_create_augroup('relativenumber_toggle', { clear = true })
vim.api.nvim_create_autocmd(
  { 'BufEnter', 'FocusGained', 'InsertLeave' },
  {
    group = 'relativenumber_toggle',
    command = 'set relativenumber'
  }
)
vim.api.nvim_create_autocmd(
  { 'BufLeave', 'FocusLost', 'InsertEnter' },
  {
    group = 'relativenumber_toggle',
    command = 'set norelativenumber'
  }
)

-- Disable comment insertion for select languages
-- Note: Not using formatoptions because I *do* want block comments to be inserted
vim.api.nvim_create_autocmd(
  { 'FileType' },
  {
    pattern = { 'c', 'cpp', 'h', 'hpp' },
    command = 'setlocal comments-=:// comments+=f://',
  }
)
vim.api.nvim_create_autocmd(
  { 'FileType' },
  {
    pattern = { 'lua' },
    command = 'setlocal comments-=:-- comments+=f:--',
  }
)

-- Exit insert mode when leaving a window
vim.api.nvim_create_autocmd(
  { 'WinLeave' },
  { command = 'stopinsert' }
)

-- Show cursorline only when in insert mode
vim.api.nvim_create_autocmd(
  { 'InsertEnter' },
  { command = 'set cul' }
)
vim.api.nvim_create_autocmd(
  -- WinLeave event necessary to play nice with earlier autocommand
  -- Can't just toggle on InsertEnter and InsertLeave
  { 'WinLeave', 'InsertLeave' },
  { command = 'set nocul' }
)

-- Treat CMakeLists files with any extension as cmake files
-- This is to get expected syntax highlighting with nix nonsense...
vim.api.nvim_create_autocmd(
  { 'BufRead', 'BufNewFile' }, {
    pattern = 'CMakeLists*',
    command = 'set filetype=cmake'
  }
)
vim.api.nvim_create_autocmd(
  { 'User' }, {
    pattern = 'TelescopePreviewerLoaded',
    callback = function(args)
      if args.data.bufname:match("CMakeLists*") then
        vim.cmd('set filetype=cmake')
      end
    end,
  }
)
