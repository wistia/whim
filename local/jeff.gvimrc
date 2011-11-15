source ~/.whim/gvimrc

map <D-o> :NERDTreeToggle \| :silent NERDTreeMirror<CR>
map <D-O> :NERDTreeClose \| :NERDTree ~/active_projects \| :NERDTreeToggle \| :NERDTreeFind \| :silent NERDTreeMirror<CR>

co desert
