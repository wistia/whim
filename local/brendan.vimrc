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
