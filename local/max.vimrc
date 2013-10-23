so ~/.whim/vimrc

" Integrate with the mouse by default
set mouse=a

" Don't highlight search terms by default
set hlsearch!

colo solarized
let g:CommandTMaxFiles=30000
let g:CommandTMaxHeight=18
let g:CommandTMatchWindowAtTop=1
let g:CommandTMatchWindowReverse=0

function s:Gcheckout(branch)
  silent exec "Git checkout " . a:branch
  set ar
  silent! bufdo checktime
  set noar
  silent CommandTFlush
  echo "Checked out " . a:branch . ", reloaded all buffers, and flushed Command-T"
endfunction
function s:BranchComplete(A,L,P)
  return fugitive#buffer().repo().superglob(a:A)
endfunction
command! -nargs=1 -complete=customlist,<SID>BranchComplete Gcheckout call s:Gcheckout(<q-args>)
function s:Gbranch(args)
  exec "Git branch " . args
endfunction
command! -nargs=* -complete=customlist,<SID>BranchComplete Gbranch call s:Gbranch(<q-args>)

function s:NERDTreeOpenFind()
  wincmd l
  NERDTree
  wincmd l
  NERDTreeFind
endfunction
map <leader>r :call <SID>NERDTreeOpenFind()<CR> :set nu<CR>
map <leader>o :NERDTree<CR> :set nu<CR>

" turn automake on for the current buffer
command CoffeeAutoMakeOn let b:coffeeAutoMake = 1
command CoffeeAutoMakeOff let b:coffeeAutoMake = 0

au VimEnter * AutoComplPopEnable

nmap <F4> :w<CR>:make<CR>:cw<CR>

" Functions to do partial splits and joins with two lines.
function! s:joinBelow()
  let c = v:count1
  let i = 0
  while i < c
    norm $Jf rk$
    let i += 1
  endwhile
endfunction
function! s:splitBelow()
  let c = v:count1
  let i = 0
  if line(".") == line("$")
    norm ok
  end
  while i < c
    norm j@kk$
    let i += 1
  endwhile
endfunction
function! s:joinAbove()
  let c = v:count1
  let i = 0
  while i < c
    norm k$JF r^
    let i += 1
  endwhile
endfunction
function! s:splitAbove()
  let c = v:count1
  let i = 0
  if line(".") == 1
    norm Oj
  end
  while i < c
    norm k@jj^
    let i+= 1
  endwhile
endfunction

set wildignore+=*/tmp/*,*/cache/*,*/backups/*,*.so,*.swp,*.zip,*/doc/generated/*
let g:ctrlp_map = '<c-p>'
let g:ctrlp_map = '<leader>t'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

" ALT+j/ALT+J
nnoremap <silent> ∆ :<C-U>call <SID>splitBelow()<CR>
nnoremap <silent> Ô :<C-U>call <SID>joinBelow()<CR>

" ALT+k/ALT+K
nnoremap <silent> ˚ :<C-U>call <SID>splitAbove()<CR>
nnoremap <silent>  :<C-U>call <SID>joinAbove()<CR>

" Turn off arrow keys to force myself to use hjkl
" noremap  <Up> ""
" noremap! <Up> <Esc>
" noremap  <Down> ""
" noremap! <Down> <Esc>
" noremap  <Left> ""
" noremap! <Left> <Esc>
" noremap  <Right> ""
" noremap! <Right> <Esc>

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
