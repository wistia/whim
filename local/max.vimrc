source ~/.whim/init.vim

colo jellybeans
let g:CommandTMaxFiles=30000
let g:CommandTMaxHeight=18
let g:CommandTMatchWindowAtTop=1
let g:CommandTMatchWindowReverse=0
map <leader>o :NERDTree<CR>
map <leader>r :NERDTreeFind<CR>
map <leader>x :NERDTreeClose<CR>

au VimEnter * AutoComplPopEnable
