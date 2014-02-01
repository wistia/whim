source ~/.whim/vimrc

" Integrate with the mouse by default
set mouse=a

" Make sure in the terminal we use 256 colors and not 8, like a chump
let &t_Co=256

" Solarized for vim diffin'
colo brendan
if &diff
  colo solarized
endif

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
"noremap  <Up> ""
"noremap! <Up> <Esc>
"noremap  <Down> ""
"noremap! <Down> <Esc>
"noremap  <Left> ""
"noremap! <Left> <Esc>
"noremap  <Right> ""
"noremap! <Right> <Esc>

au VimEnter * AutoComplPopEnable

" Reveal trailing whitespace
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=darkred
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


" Use The Silver Searcher instead of grep
if executable("ag")
  set grepprg=ag\ --noheading\ --nogroup\ --nocolor
endif

