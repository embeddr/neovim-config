local gitsigns = require("gitsigns")

gitsigns.setup({
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Next hunk
    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]h", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, "Next git hunk")

    -- Previous hunk
    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[h", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, "Previous git hunk")

    -- Stage hunk
    map("n", "<leader>gs", gitsigns.stage_hunk, "Stage git hunk")
    map("x", "<leader>gs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Stage selected git lines")

    -- Reset hunk
    map("n", "<leader>gu", gitsigns.reset_hunk, "Undo git hunk")
    map("x", "<leader>gu", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Undo selected git lines")

    -- Preview hunk (before/after comparison)
    map("n", "<leader>gp", gitsigns.preview_hunk, "Preview git hunk")
  end,
})
