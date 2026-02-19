require'copilot'.setup({
  suggestion = { enabled = false }, -- disable inline completions
  panel = { enabled = false },      -- disable Copilot panel
})

require'codecompanion'.setup({
  strategies = {
    chat = {
      adapter = "copilot",
      model = "GPT-5",
    },
    inline = {
      adapter = "copilot",
      model = "GPT-5",
    },
    agent = {
      adapter = "copilot",
      model = "GPT-5",
    },
  },
  display = {
    chat = {
      window = {
        layout = "horizontal",
        height = 0.5,
        full_height = false,
      },
    },
  },
})

vim.keymap.set(
  'n',
  '<leader>q',
  ':CodeCompanionChat toggle<CR>',
  opts
)
