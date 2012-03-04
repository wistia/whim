so ~/.whim/vimrc

" Integrate with the mouse by default
set mouse=a

" Don't highlight search terms by default
set hlsearch!

colo jellybeans
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
map <leader>r :call <SID>NERDTreeOpenFind()<CR>

" turn automake on for the current buffer
command CoffeeAutoMakeOn let b:coffeeAutoMake = 1
command CoffeeAutoMakeOff let b:coffeeAutoMake = 0

au VimEnter * AutoComplPopEnable

nmap <F4> :w<CR>:make<CR>:cw<CR>
