" Startify configuration
" Set custom header to the latest ZOOX logo

" Set startify lists
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Saved Sessions']                   },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
      \ { 'type': 'files',     'header': ['   Recent Files']                     },
      \ ]

" Set startify bookmarks
let g:startify_bookmarks = [ 
      \ '~/.config/nvim/init.vim',
      \ '~/Work/',
      \ '~/Work/practice',
      \ '~/Work/stm32f3discovery/test_project',
      \ ]

" Other startify settings
let g:startify_enable_special = 0
let g:startify_padding_left = 8
