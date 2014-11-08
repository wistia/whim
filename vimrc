"
" whim plugin loading
"
"
call pathogen#infect(expand("<sfile>:h") . '/bundle/{}')
call pathogen#infect()
syntax on
filetype plugin indent on

"
" Basic preferences
"
"
set nocompatible
set backspace=indent,eol,start
set backup		" keep a backup file
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ic  " ignore case in searches
set hlsearch " highlight matching search terms
set viminfo='100,f1
set nu  " show line numbers
set expandtab  " replace tabs with spaces
set ts=2 showcmd sw=2 sts=2   " set all tab widths to 2
colorscheme molokai   " set molokai as the default colorscheme
map Q gq
inoremap <C-U> <C-G>u<C-U>
if has("gui_macvim")
  set mouse=a
else
  set mouse=r
endif

"
" Our special key mappings
" 
"
map <D-1> :tabn 1<CR>
map <D-2> :tabn 2<CR>
map <D-3> :tabn 3<CR>
map <D-4> :tabn 4<CR>
map <D-5> :tabn 5<CR>
map <D-6> :tabn 6<CR>
map <D-7> :tabn 7<CR>
map <D-8> :tabn 8<CR>
map <D-9> :tabn 9<CR>
" window splitting mappings
" split vertically with <leader> v
" split horizontally with <leader> s
nmap <leader>v :vsplit<CR> <C-w><C-w>
nmap <leader>s :split<CR> <C-w><C-w>

" Make it way easier to switch windows (<leader>w)
nmap <leader>w <C-w><C-w>_
" bind command-] to shift right
nmap <D-]> >>
vnoremap <D-]> ><CR>gv
imap <D-]> <C-O>>>

" bind command-[ to shift left
nmap <D-[> <<
vnoremap <D-[> <<CR>gv
imap <D-[> <C-O><<

" Press CTRL+N to toggle highlighting on/off, and show current value.
noremap <C-N> :set hlsearch! hlsearch?<CR>

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
au!

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Javascript commands
function s:Minify(abspath, inpath, infile, outfile)
  let myoutfile = a:inpath . '/' . a:outfile
  if a:outfile == ''
    let myoutfile = a:inpath . '/' . a:infile . '.min.js'
  endif
  exec ':silent !uglifyjs -nc -o ' . myoutfile . ' ' . a:abspath
  echo 'Minified ' . a:abspath . ' to ' . myoutfile
endfunction
command! -nargs=? -complete=file Minify call <SID>Minify(expand("%:p"), expand("%:p:h"), expand("%:t:r"), <q-args>)
command Jslint :w | !jslint.js --devel --browser --white --onevar --undef --nomen --regexp --plusplus --bitwise --newcap --maxerr=5 --indent=2 % 

" Coffeescript commands
autocmd BufNewFile,BufRead *.coffee let b:coffeeAutoMake = 0
function s:CoffeeAutoMake()
  if b:coffeeAutoMake == 1
    silent CoffeeMake! -b | cwindow
  else
    silent CoffeeMake! -bp | cwindow
  endif
endfunction
autocmd BufWritePost *.coffee call s:CoffeeAutoMake()
command Cake :w | !cake build:all

" Command-T preferences
let g:CommandTMaxFiles=30000
let g:CommandTMaxHeight=20
let g:CommandTMatchWindowAtTop=0
let g:CommandTMatchWindowReverse=1

" NERDTree shortcuts
" Pro Tip: <leader>o, <leader>w, <leader>r to find the 
" open buffer in the current working directory
map <leader>o :NERDTree<CR>
map <leader>r :NERDTreeFind<CR>

" Recognize md files as markdown
au BufNewFile,BufRead *.md set filetype=markdown

" VCL Syntax
au BufRead,BufNewFile *.vcl :set ft=vcl
au! Syntax vcl source ~/.whim/bundle/syntax/vcl.vim

" Golang Syntax
au BufRead,BufNewFile *.go :set ft=golang
au! Syntax golang source ~/.whim/bundle/syntax/golang.vim

" Scala Syntax
au BufRead,BufNewFile *.scala :set ft=scala
au! Syntax scala source ~/.whim/bundle/syntax/scala.vim

" Backup and swap configuration
set wildignore+=*~,.git
silent !mkdir -p ~/.vim/swap
silent !mkdir -p ~/.vim/backups
set directory=~/.vim/swap//
set backupdir=~/.vim/backups
au BufWritePre * let &backupdir = expand("$HOME") . '/.vim/backups'
au BufWritePre * let &backupext = substitute(expand("%:p"), "\/", "_", "g")

" Disable acp by default
au VimEnter * AutoComplPopDisable

" So language syntax highlighting works in markdown using fenced code blocks
let g:markdown_fenced_languages = ['ruby', 'javascript', 'html', 'python', 'css']
