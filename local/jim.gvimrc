source ~/.whim/gvimrc

if has("gui_macvim")
  macm Window.Select\ Previous\ Tab  key=<S-D-[>
  macm Window.Select\ Next\ Tab	   key=<S-D-]>
endif

"set guifont=Inconsolata:h18
set gfn=Droid\ Sans\ Mono\ 12
set bg=dark

colorscheme molokai
