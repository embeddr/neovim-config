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

" LSP
" Mason provides automatic download and setup of LSP servers
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'

" Snippet engine (needed for nvim-cmp)
Plug 'L3MON4D3/LuaSnip'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Ripgrep
" Very fast grep tool written in rust
" Note: Ripgrep must be installed separately; can use cargo
Plug 'jremmen/vim-ripgrep'

" BufTabLine
" Displays buffer names in the tab line for convenience
Plug 'ap/vim-buftabline'

" Buffer deletion helpers
" Prevents issues like windows closing when buffers are deleted
Plug 'kazhala/close-buffers.nvim'

" Status bar and window bar plugins
Plug 'nvim-lualine/lualine.nvim'
Plug 'SmiteshP/nvim-navic'
Plug 'kyazdani42/nvim-web-devicons'

" Telescope
" Note: Ripgrep must be installed separately; can use cargo
" Note: File browser optionally uses fd, which must be installed separately
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', " { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

" Vim-floaterm
" Floating terminal (rather than managing a terminal in a pane)
Plug 'voldikss/vim-floaterm'

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

" User Settings ----------------------------------------------------------------

" BufTabLine configuration
" Always show buffers in tab
let g:buftabline_show=2
" Show ordinal buffer numbers
let g:buftabline_numbers=2
" Show status indicator
let g:buftabline_indicators=1

" Add experimental mappings for Vim-Smoothie (e.g. G/gg)let
let g:smoothie_experimental_mappings=v:true

" Configure floaterm
let g:floaterm_width = 0.8

" Set GitHub/GitLab domains in non-tracked init file
"let g:github_enterprise_urls = ['https://my-github']
"let g:fugitive_gitlab_domains = ['https://my-gitlab']

" Key bindings -----------------------------------------------------------------

" Use ctrl-j/k to scroll up/down
nnoremap <C-k> <cmd>call smoothie#do("\<C-U>") <CR>
nnoremap <C-j> <cmd>call smoothie#do("\<C-D>") <CR>

" Open new terminal or toggle existing terminal
nmap <leader>t :FloatermToggle<CR>
map <leader>t :FloatermToggle<CR>

" Unmap q to prevent recording
map q <Nop>

" Toggle line wrap on the current buffer
nmap <leader>w :set wrap!<CR>

" Use <leader>-num to open the corresponding (ordinal) buffer number
for i in range(1, 9)
  execute 'nnoremap <leader>' . i . ' <Plug>BufTabLine.Go(' . i . ')'
endfor
nnoremap <leader>0 <Plug>BufTabLine.Go(10)

" Go to previous/next buffer
nnoremap - :bprev<CR>
nnoremap = :bnext<CR>

" Get link to open file/selection on GitHub
nmap <leader>b :GBrowse<CR>
vmap <leader>b :GBrowse<CR>

" Enable escape to exit terminal mode 
tnoremap <Esc> <C-\><C-n>

" Have tab/shift-tab indent and unindent in normal and insert modes
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
nnoremap <Tab> >>

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
lua require'user.autocmds'
lua require'user.buffers'
lua require'user.cmp'
lua require'user.lsp'
lua require'user.options'
lua require'user.plugins'
lua require'user.telescope'
lua require'user.treesitter'
