local floaterm = require'floaterm'
floaterm.setup {
  size = { h = 60, w = 80 },
  mappings = {
    term = function(bufnr)
      local map = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true })
      end
      map("n", "<Esc>", "<Cmd>FloatermToggle<CR>")
      map("t", "<C-j>", function()
        require("floaterm.api").cycle_term_bufs "next"
      end)
      map("t", "<C-k>", function()
        require("floaterm.api").cycle_term_bufs "prev"
      end)
    end,
  },
  terminals = {
    { name = "Git" },
    { name = "Exec" },
    { name = "Misc" },
  },
}

vim.keymap.set("n", "<leader>t", "<Cmd>FloatermToggle<CR>")
vim.keymap.set("t", "<leader>t", "<Cmd>FloatermToggle<CR>")
