" Get vim-plug if not already present in autoload directory
if empty(glob('$HOME/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim-plug --------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

" Fuzzy finder
" Fuzzy search tool, provides easy mechanism for finding files
" Note: this will download and install fzf and enable it for nvim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Ripgrep
" Very fast grep tool wrftten in rust
" Note: this must be first installed separately; use cargo
" Note: Original plugin is by jremmen, but this one adds useful hotkeys
Plug 'miki725/vim-ripgrep'

" BufTabLine
" Displays buffer names in the tab line for convenience
Plug 'ap/vim-buftabline'

" Lightline
" Lightweight, customizable status bar under each window
Plug 'itchyny/lightline.vim'

" Git helpers by tpope
Plug 'tpope/vim-fugitive'

" Abolish
" Helper for abbreviation, substitution, and coercion
Plug 'tpope/vim-abolish'

" GitGutter
" Shows git changes in column to the left of line numbers
Plug 'airblade/vim-gitgutter'

" Color schemes
Plug 'KurtPreston/vimcolors'
Plug 'morhetz/gruvbox'

" Colorscheme-switcher
" Allows for easy iteration across available color schemes
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'

" Cpp-modern
" Provides better highlighting for modern C++
Plug 'bfrg/vim-cpp-modern'

" Closer
" Plugin for conservative bracket closing (inserts on enter only)
Plug 'rstacruz/vim-closer'

" Startify
" Vim startup menu improvements (recent files, sessions, etc.)
Plug 'mhinz/vim-startify'

" Gutentags
Plug 'ludovicchabant/vim-gutentags'

" Initialize plugin system
call plug#end()

" User Settings ----------------------------------------------------------------

" Configure tabs to insert two spaces, enable auto-indent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set copyindent

" Smart-case searching
" If the search term is all lowercase, search is case-insensitive
" To force an all-lowercase search term to be case-sensitive, add \C
set ignorecase
set smartcase

" Disable status on command line since lightline conveys the same information
set noshowmode

" Automatically reload files on disk changes
set autoread

" Utilize system clipboard
" Note: install xclip (or similar) to support this
set clipboard+=unnamedplus

" Clear search highlighting by hitting return
nnoremap <CR> :noh<CR><CR>

" Use ctrl-h/j/k/l to navigate between views
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use <leader>-num to open the corresponding (ordinal) buffer number
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)
nmap <leader>- :bprev<CR>
nmap <leader>= :bnext<CR>

" Hotkeys to close current buffer or window
"nmap <leader>q :b#\|bd #<CR>
nmap <leader>q :enew\|bd #<CR>
nmap <leader>c :close<CR>

" Hotkeys for FZF file search
nmap <leader>f :Files<CR>
nmap <leader>g :GFiles<CR>

" Enable escape to exit terminal mode 
tnoremap <Esc> <C-\><C-n>

" Highlight the selected line when in insert mode
:autocmd InsertEnter,InsertLeave * set cul!

" Have tab/shift-tab indent and unindent in normal and insert modes
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
nnoremap <Tab> >>

" Enable hybrid line numbers by default
set nu rnu

" Disable hybrid line numbers when in insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Prevent auto-insertion of // comments in C/C++ files
au FileType c,cpp,h,hpp setlocal comments-=:// comments+=f://

" BufTabLine configuration
" Always show buffers in tab
let g:buftabline_show=2
" Show ordinal buffer numbers
let g:buftabline_numbers=2
" Show status indicator
let g:buftabline_indicators=1

" Vim file browser (netrw) config
" Disable header
let g:netrw_banner = 0

" Display tree form
let g:netrw_liststyle = 3

" Specify initial color scheme and background mode
colorscheme gruvbox

" Disable background color
hi Normal guibg=NONE ctermbg=NONE

" Enable 24-bit colors (requires truecolor terminal emulator)
set termguicolors

" Source other config files  ---------------------------------------------------

" Startify config
if !empty(glob('$HOME/.config/nvim/startify.vim'))
  source $HOME/.config/nvim/startify.vim
endif

" Lightline config
if !empty(glob('$HOME/.config/nvim/lightline.vim'))
  source $HOME/.config/nvim/lightline.vim
endif


