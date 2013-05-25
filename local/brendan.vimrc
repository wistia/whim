source ~/.whim/vimrc

" Integrate with the mouse by default
set mouse=a

" Solarized for vim diffin'
colo solarized

" Two semicolons to get out of insert mode
:imap ;; <Esc>

" Map W to w and Q to q, because I always fatfinger them
:command W w
:command Q q

" Make <leader>-o toggle the NERDTree, not just open it
map <leader>o :NERDTreeToggle \| :silent NERDTreeMirror<CR>

:set colorcolumn=80

" this is my home!!!
cd ~/active_projects

" Turn off arrow keys to force myself to use hjkl
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

" Use The Silver Searcher instead of grep
if executable("ag")
  set grepprg=ag\ --noheading\ --nogroup\ --nocolor
endif
