local floaterm = require'floaterm'
local floaterm_api = require("floaterm.api")
local floaterm_utils = require("floaterm.utils")
local floaterm_state = require("floaterm.state")

floaterm.setup {
  size = { h = 60, w = 80 },
  mappings = {
    term = function(bufnr)
      local map = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true })
      end
      -- Exit cleanly on escape
      map("n", "<Esc>", "<Cmd>FloatermToggle<CR>")
      -- Allow ctrl-j/k to cycle terms
      map({"t", "n"}, "<C-j>", function()
        floaterm_api.cycle_term_bufs "next"
      end)
      map({"t", "n"}, "<C-k>", function()
        floaterm_api.cycle_term_bufs "prev"
      end)
      -- Allow =/- to cycle terms
      map({"t", "n"}, "=", function()
        floaterm_api.cycle_term_bufs "next"
      end)
      map({"t", "n"}, "-", function()
        floaterm_api.cycle_term_bufs "prev"
      end)
      -- Remap leader-N to jump to the Nth terminal
      -- This unfortunately requires poking around into the guts of the floaterm plugin a
      -- bit, so there's a decent chance that this will break at some point in the future.
      for i = 1, 9 do
        map({"t", "n"}, "<leader>" .. i, function()
          local term = floaterm_state.terminals[i]
          if term and term.buf and vim.api.nvim_buf_is_loaded(term.buf) then
            floaterm_utils.switch_buf(term.buf)
          else
            vim.notify("Terminal buffer #" .. i .. " does not exist or is not loaded.", vim.log.levels.WARN)
          end
        end)
      end
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
