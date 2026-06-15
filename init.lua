--------------------------------------------------------------------------------
-- Neovim configuration entry point
--------------------------------------------------------------------------------

if not vim.pack then
  error("This configuration requires Neovim 0.12 or newer for vim.pack")
end

local gh = function(repo)
  return "https://github.com/" .. repo
end

-- Autocommand to invoke TSUpdate on treesitter install/update
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local spec = ev.data and ev.data.spec
    if not spec or spec.name ~= "nvim-treesitter" then
      return
    end

    if ev.data.kind == "install" or ev.data.kind == "update" then
      vim.cmd.packadd("nvim-treesitter")
      vim.cmd.TSUpdate()
    end
  end,
})

vim.pack.add({
  -- LSP
  { src = gh("williamboman/mason.nvim") },
  { src = gh("williamboman/mason-lspconfig.nvim") },
  { src = gh("neovim/nvim-lspconfig") },

  -- Autocompletion
  { src = gh("hrsh7th/nvim-cmp") },
  { src = gh("hrsh7th/cmp-nvim-lsp") },
  { src = gh("hrsh7th/cmp-path") },

  -- Improved syntax highlighting and awareness
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "master" },

  -- OSC52 for remote yank
  -- Neovim 0.10+ has native OSC52 support, so explore removing this sometime
  { src = gh("ojroques/nvim-osc52") },

  -- Fast search
  { src = gh("jremmen/vim-ripgrep") },

  -- Display buffer info in tabline
  { src = gh("akinsho/bufferline.nvim"), version = vim.version.range("*") },

  -- Prevent issues like windows closing when buffers are deleted
  { src = gh("kazhala/close-buffers.nvim") },

  -- Status bar and window bar plugins
  { src = gh("nvim-lualine/lualine.nvim") },
  { src = gh("SmiteshP/nvim-navic") },
  { src = gh("kyazdani42/nvim-web-devicons") },

  -- Clean up inline diagnostics
  { src = gh("rachartier/tiny-inline-diagnostic.nvim") },

  -- Telescope
  -- Note: Ripgrep must be installed separately
  -- Note: File browser optionally uses fd
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("nvim-telescope/telescope.nvim") },
  { src = gh("nvim-telescope/telescope-file-browser.nvim") },

  -- Floating terminal
  { src = gh("nvzone/volt") },
  { src = gh("nvzone/floaterm") },

  -- Hex editor
  { src = gh("RaafatTurki/hex.nvim") },

  -- Notification box
  { src = gh("rcarriga/nvim-notify") },

  -- General git command support
  { src = gh("tpope/vim-fugitive") },

  -- GitHub and GitLab integration (e.g. open permalink)
  { src = gh("tpope/vim-rhubarb") },
  { src = gh("shumphrey/fugitive-gitlab.vim") },

  -- Helpers for abbreviation, substitution, and coercion
  { src = gh("tpope/vim-abolish") },

  -- Show git changes in column to the left of line numbers
  { src = gh("airblade/vim-gitgutter") },

  -- Conservative bracket closing (inserts on enter only)
  { src = gh("rstacruz/vim-closer") },

  -- Startify
  { src = gh("mhinz/vim-startify") },

  -- Highlight trailing spaces
  { src = gh("nvim-mini/mini.trailspace") },

  -- Smooth scrolling with default Vim movement
  { src = gh("psliwka/vim-smoothie") },

  -- Smear cursor effect
  { src = gh("sphamba/smear-cursor.nvim") },

  -- Color Schemes
  { src = gh("sainnhe/everforest") },
  { src = gh("morhetz/gruvbox") },
  { src = gh("folke/tokyonight.nvim") },
}, { confirm = false })

-- Find shell ------------------------------------------------------------------

local function find_shell()
  for _, shell in ipairs({ "zsh", "bash", "sh" }) do
    if vim.fn.executable(shell) == 1 then
      return vim.fn.exepath(shell)
    end
  end
  return ""
end

vim.o.shell = find_shell()

-- User Settings ---------------------------------------------------------------

-- Add experimental mappings for Vim-Smoothie (e.g. G/gg)
vim.g.smoothie_experimental_mappings = true

-- Set GitHub/GitLab enterprise domains in a non-tracked file
-- vim.g.github_enterprise_urls = { "https://my-github" }
-- vim.g.fugitive_gitlab_domains = { "https://my-gitlab" }

-- Key bindings ----------------------------------------------------------------

local function smoothie(keys)
  return function()
    vim.fn["smoothie#do"](vim.api.nvim_replace_termcodes(keys, true, false, true))
  end
end

-- Use ctrl-j/k to scroll up/down
vim.keymap.set("n", "<C-k>", smoothie("<C-U>"), { silent = true })
vim.keymap.set("n", "<C-j>", smoothie("<C-D>"), { silent = true })

-- Unmap q to prevent recording
vim.keymap.set({ "n", "x", "s", "o" }, "q", "<Nop>")

-- Toggle line wrap on the current buffer
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<CR>")

-- Go to previous/next buffer
vim.keymap.set("n", "-", "<cmd>bprev<CR>")
vim.keymap.set("n", "=", "<cmd>bnext<CR>")

-- Get link to open file/selection on GitHub
vim.keymap.set("n", "<leader>b", "<cmd>GBrowse<CR>")
vim.keymap.set("x", "<leader>b", ":GBrowse<CR>")

-- Enable escape to exit terminal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Have shift-tab unindent in insert mode
vim.keymap.set("i", "<S-Tab>", "<C-d>")

-- Use ctrl-j/k to navigate autocompletion menus
vim.keymap.set("i", "<C-j>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-j>"
end, { expr = true })
vim.keymap.set("i", "<C-k>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-k>"
end, { expr = true })

-- Source other config files  --------------------------------------------------

-- Startify config
-- TODO: Try `goolord/alpha-nvim` or similar
local startify_path = vim.fn.stdpath("config") .. "/startify.vim"
if vim.fn.filereadable(startify_path) == 1 then
  vim.cmd.source(vim.fn.fnameescape(startify_path))
end

-- Additional user configs
require("user.aesthetics")
require("user.autocmds")
require("user.buffers")
require("user.cmp")
require("user.filetypes")
require("user.lsp")
require("user.misc_plugins")
require("user.options")
require("user.telescope")
require("user.terminal")
require("user.treesitter")
