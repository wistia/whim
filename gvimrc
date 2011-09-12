" Use CTRL+TAB and CTRL+SHIFT+TAB to get around
if has("gui_macvim")
  macmenu &File.Open\.\.\. key=<nop>
  macm Window.Select\ Previous\ Tab  key=<C-S-Tab>
  macm Window.Select\ Next\ Tab	   key=<C-Tab>
endif

set guioptions-=T
set guifont=Menlo:h14
