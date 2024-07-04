" Startify configuration

" Do not change to the directory of a file/bookmark when opening
let g:startify_change_to_dir = 0

" Set startify lists
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Saved Sessions']                   },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
      \ { 'type': 'files',     'header': ['   Recent Files']                     },
      \ ]

" Set startify bookmarks
let g:startify_bookmarks = [ 
      \ '~/.config/nvim/init.vim',
      \ '~/.config/nvim/lua/user/',
      \ '~/Work/',
      \ ]

" Other startify settings
let g:startify_enable_special = 0
let g:startify_padding_left = 8
let g:startify_custom_footer = [
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ '',
      \ ]
