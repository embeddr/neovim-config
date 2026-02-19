""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim configuration entry point
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Get vim-plug if not already present in autoload directory
if empty(glob('$HOME/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim-plug ---------------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')

" Mini
Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }

" LSP
" Mason provides automatic download and setup of LSP servers
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" AI integration
Plug 'zbirenbaum/copilot.lua'
Plug 'olimorris/codecompanion.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" OSC52 for remote yank
" Neovim 0.10+ has native OSC52 support, so explore removing this sometime
Plug 'ojroques/nvim-osc52'

" Ripgrep
" Very fast grep tool written in rust
" Note: Ripgrep must be installed separately; can use cargo
Plug 'jremmen/vim-ripgrep'

" Display buffer info in tabline
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

" Buffer deletion helpers
" Prevents issues like windows closing when buffers are deleted
Plug 'kazhala/close-buffers.nvim'

" Status bar and window bar plugins
Plug 'nvim-lualine/lualine.nvim'
Plug 'SmiteshP/nvim-navic'
Plug 'kyazdani42/nvim-web-devicons'

" Clean up inline diagnostics
Plug 'rachartier/tiny-inline-diagnostic.nvim'

" Telescope
" Note: Ripgrep must be installed separately; can use cargo
" Note: File browser optionally uses fd, which must be installed separately
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', " { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

" Floating terminal
Plug 'nvzone/volt'
Plug 'nvzone/floaterm'

" Hex editor
Plug 'RaafatTurki/hex.nvim'

" Notify
Plug 'rcarriga/nvim-notify'

" Git helpers by tpope
" General git command support
Plug 'tpope/vim-fugitive'

" GitHub and GitLab integration (e.g. open permalink)
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'

" Abolish
" Helper for abbreviation, substitution, and coercion
Plug 'tpope/vim-abolish'

" GitGutter
" Shows git changes in column to the left of line numbers
Plug 'airblade/vim-gitgutter'

" Closer
" Plugin for conservative bracket closing (inserts on enter only)
Plug 'rstacruz/vim-closer'

" Startify
" Vim startup menu improvements (recent files, sessions, etc.)
Plug 'mhinz/vim-startify'

" Vim-Smoothie
" Smooth scrolling with default Vim movement
Plug 'psliwka/vim-smoothie'

" Smear cursor effect
Plug 'sphamba/smear-cursor.nvim'

" Color Schemes
Plug 'sainnhe/everforest'
Plug 'morhetz/gruvbox'
Plug 'folke/tokyonight.nvim'

" Initialize plugin system
call plug#end()

function! CheckPluginsInstalled() abort
  if !exists('g:plugs')
    return v:false
  endif

  for name in keys(g:plugs)
    let plugin_dir = g:plugs[name].dir
    if empty(glob(plugin_dir))
      return v:false
    endif
  endfor
  return v:true
endfunction

if !CheckPluginsInstalled()
  echom "Plugins missing. Installing..."
  silent! PlugInstall
  echom "New plugins installed."
  silent! PlugInstall
endif

" Find shell -------------------------------------------------------------------

function! FindShell()
  for s in ['zsh', 'bash', 'sh']
    if executable(s)
      return exepath(s)
    endif
  endfor
  return ''
endfunction

let &shell = FindShell()

" User Settings ----------------------------------------------------------------

" Add experimental mappings for Vim-Smoothie (e.g. G/gg)let
let g:smoothie_experimental_mappings=v:true

" Set GitHub/GitLab enterprise domains in a non-tracked file
"let g:github_enterprise_urls = ['https://my-github']
"let g:fugitive_gitlab_domains = ['https://my-gitlab']

" Key bindings -----------------------------------------------------------------

" Use ctrl-j/k to scroll up/down
nnoremap <C-k> <cmd>call smoothie#do("\<C-U>") <CR>
nnoremap <C-j> <cmd>call smoothie#do("\<C-D>") <CR>

" Unmap q to prevent recording
map q <Nop>

" Toggle line wrap on the current buffer
nmap <leader>w :set wrap!<CR>

" Go to previous/next buffer
nnoremap - :bprev<CR>
nnoremap = :bnext<CR>

" Get link to open file/selection on GitHub
nmap <leader>b :GBrowse<CR>
vmap <leader>b :GBrowse<CR>

" Enable escape to exit terminal mode
" TODO: Put this in custom binding for floaterm?
tnoremap <Esc> <C-\><C-n>

" Have shift-tab unindent in insert mode
inoremap <S-Tab> <C-d>

" Use ctrl-j/k to navigate autocompletion menus
inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : "<c-j>"
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "<c-k>"

" Source other config files  ---------------------------------------------------

" Startify config
if !empty(glob('$HOME/.config/nvim/startify.vim'))
  source $HOME/.config/nvim/startify.vim
endif

" Lua user configs
lua require'user.aesthetics'
lua require'user.ai'
lua require'user.autocmds'
lua require'user.buffers'
lua require'user.cmp'
lua require'user.lsp'
lua require'user.misc_plugins'
lua require'user.options'
lua require'user.telescope'
lua require'user.terminal'
lua require'user.treesitter'
