so ~/.whim/vimrc

colo jellybeans
let g:CommandTMaxFiles=30000
let g:CommandTMaxHeight=18
let g:CommandTMatchWindowAtTop=1
let g:CommandTMatchWindowReverse=0

function s:Gcheckout(branch)
  silent exec "Git checkout " . a:branch
  let curBuff = bufnr("%")
  silent! bufdo edit
  execute 'buffer ' . curBuff
  silent CommandTFlush
  echo "Checked out " . a:branch . ", reloaded all buffers, and flushed Command-T"
endfunction
function s:BranchComplete(A,L,P)
  return fugitive#buffer().repo().superglob(a:A)
endfunction
command! -nargs=1 -complete=customlist,s:BranchComplete Gcheckout call s:Gcheckout(<q-args>)

function s:NERDTreeOpenFind()
  wincmd l
  NERDTree
  wincmd l
  NERDTreeFind
endfunction
map <leader>r :call <SID>NERDTreeOpenFind()<CR>

au VimEnter * AutoComplPopEnable
