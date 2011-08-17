if has("gui_macvim")
  macmenu &File.Open\.\.\. key=<nop>
  macm Window.Select\ Previous\ Tab  key=<C-S-Tab>
  macm Window.Select\ Next\ Tab	   key=<C-Tab>
endif

map <D-o> :NERDTreeToggle \| :silent NERDTreeMirror<CR>
map <D-O> :NERDTreeClose \| :NERDTree ~/active_projects \| :NERDTreeToggle \| :NERDTreeFind \| :silent NERDTreeMirror<CR>

set guioptions-=T
set guifont=Menlo:h14
