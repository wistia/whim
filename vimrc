autocmd BufWritePost *.coffee silent CoffeeMake! -bp | cwindow
command Cake :w | !cake build:all

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

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

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
set viminfo='100,f1
set nu
command Minify :w | !uglifyjs -nc -o %:r.min.%:e %
command Jslint :w | !jslint.js --devel --browser --white --onevar --undef --nomen --regexp --plusplus --bitwise --newcap --maxerr=5 --indent=2 % 
command -range=%  Beautify !jsbeautifier.py -ij -s 2 -
set expandtab
set ts=2 showcmd sw=2 sts=2
set bg=dark
colorscheme molokai
set ic
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

let g:CommandTMaxFiles=30000
let g:CommandTMaxHeight=20
let g:CommandTMatchWindowAtTop=0
let g:CommandTMatchWindowReverse=1

map <Leader>l :Tlist<CR><C-w>h

set wildignore+=*~,.git

" vim backup and swap files
silent !mkdir -p ~/.vim/swap
silent !mkdir -p ~/.vim/backups
set directory=~/.vim/swap//
set backupdir=~/.vim/backups
au BufWritePre * let &backupdir = expand("$HOME") . '/.vim/backups'
au BufWritePre * let &backupext = substitute(expand("%:p"), "\/", "_", "g")
