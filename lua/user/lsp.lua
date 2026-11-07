-- Make sure lspconfig is successfully setup before proceeding
local ok, _ = pcall(require, 'lspconfig')
if not ok then
  vim.notify('failed to load nvim-lspconfig', vim.log.levels.ERROR)
  return
end

require('mason').setup({
  log_level = vim.log.levels.ERROR,
})

require('mason-lspconfig').setup({
  automatic_installation = true,
})

local navic_ok, navic = pcall(require, 'nvim-navic')

-- Global diagnostic mappings
vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto_prev({ float = false })
end, { noremap = true, silent = true })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next({ float = false })
end, { noremap = true, silent = true })

-- Resolve real paths where possible
local function realpath_locations(opts)
  for _, item in ipairs(opts.items) do
    local path = item.filename
    if not path and item.bufnr and item.bufnr > 0 then
      path = vim.api.nvim_buf_get_name(item.bufnr)
    end

    local real = path and vim.uv.fs_realpath(path)
    if real then
      -- Neovim reuses buffers for the same inode, even under another name.
      -- locations_to_items may already have created one for the symlink.
      local bufnr = vim.fn.bufadd(real)
      if vim.api.nvim_buf_get_name(bufnr) ~= real then
        vim.api.nvim_buf_set_name(bufnr, real)
      end
      item.filename = real
      item.bufnr = bufnr
    end
  end

  vim.fn.setqflist({}, " ", opts)
  if #opts.items == 1 then
    vim.cmd("cfirst")
  else
    vim.cmd("copen")
  end
end

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition({ on_list = realpath_locations })
  end, vim.tbl_extend('force', opts, { desc = "Go to definition (resolve symlinks)" }))

  vim.keymap.set("n", "gD", function()
    vim.lsp.buf.declaration({ on_list = realpath_locations })
  end, vim.tbl_extend('force', opts, { desc = "Go to declaration (resolve symlinks)" }))

  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)

  -- Attach navic if available and supported by the server
  if navic_ok and client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
  clangd = {
    cmd = { '/usr/bin/clangd-19' },
    filetypes = { 'c', 'cpp' }, -- exclude proto, which clangd enables by default
  },
  rust_analyzer = {},
  pyright = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
          disable = { 'missing-fields' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
          checkThirdParty = false,
        },
      },
    },
  },
}

for name, config in pairs(servers) do
  config.on_attach = on_attach
  config.capabilities = capabilities

  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
