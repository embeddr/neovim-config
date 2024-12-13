-- Set up nvim-cmp.
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body) -- now using native snippet engine
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-q>'] = cmp.mapping.abort(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    -- Accept currently selected item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'buffer', keyword_length = 2 },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'path', keyword_length = 2 },
  })
}
