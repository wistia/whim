source ~/.whim/ginit.vim

if has("gui_macvim")
  macm Window.Select\ Previous\ Tab  key=<S-D-]>
  macm Window.Select\ Next\ Tab	   key=<S-D-[>
endif

map <S-D-]> :tabnext<CR>
map <S-D-[> :tabprevious<CR>
set guifont=Inconsolata:h18
