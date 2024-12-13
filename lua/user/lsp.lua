-- Make sure lspconfig is successfully setup before proceeding
local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  print("failed to setup lspconfig")
  return
end

require'mason'.setup {
  log_level = vim.log.levels.debug
}

require'mason-lspconfig'.setup {
  automatic_installation = true,
}

local navic = require'nvim-navic'

-- Mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
--vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({float = false}) end, opts)
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({float = false}) end, opts)

-- Function to be invoked when LSP client attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)

  -- Attach navic if capable (provides code context in winbar)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

-- Register on_attach function for desired servers
local lspconfig = require'lspconfig'
local lsp_defaults = lspconfig.util.default_config

local capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require'cmp_nvim_lsp'.default_capabilities()
)

lspconfig['clangd'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "c", "cpp" }, -- exclude proto, which is enabled by default
}
lspconfig['cmake'].setup {
    on_attach = on_attach,
    filetypes = { "cmake", "txt_nix" },
}
lspconfig['rust_analyzer'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
lspconfig['jsonls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
lspconfig['lua_ls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
          disable = { "missing-fields" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        }
      },
    },
}
lspconfig['pyright'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

