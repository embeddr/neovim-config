" Lightline config file

" Lightline colorscheme
let g:lightline = { 'colorscheme': 'jellybeans' }

" Lightline active view layout
let g:lightline.active = {
      \ 'left': [ 
      \   [ 'mode', 'paste' ],
      \   [ 'readonly', 'filename', 'modified' ]
      \ ],
      \ 'right': [
      \   [ 'lineinfo' ],
      \   [ 'percent' ],
      \   [ 'fileformat', 'filetype' ]
      \ ] }

" Lightline inactive view layout
let g:lightline.inactive = {
      \ 'left': [
      \   [ 'filename' ]
      \ ],
      \ 'right': [
      \   [ 'lineinfo' ],
      \   [ 'percent' ]
      \ ] }

" Read-only and helpfile indication
let g:lightline.component_function = {
      \   'readonly': "LightlineReadonly"
      \ }

function! LightlineReadonly()
  return &readonly ? 'read-only' : ''
endfunction
