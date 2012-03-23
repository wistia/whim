
let mapleader = "."
so ~/.whim/vimrc

color ir_black
"let mapleader = "."

set nocompatible
set cursorline
set scrolloff=2
setlocal numberwidth=5

" Nice statusbar
set laststatus=2
set statusline=\ "
set statusline+=%{system('hostname\|tr\ -d\ \"\\n\"')}: " hostname
set statusline+=%f\ " file name
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&fileformat}] " file format
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset          

" enable setting title
set title
" configure title to look like: Vim /path/to/file
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70    

" Make backspace work in insert mode
"set backspace=indent,eol,start

" can has foldin plz?
set foldenable
set foldmethod=syntax
set foldlevel=999 " make it really high, so they're not displayed by default
                                                        
" quit NERDTree after openning a file
let NERDTreeQuitOnOpen=0
" colored NERD Tree
let NERDChristmasTree = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeShowHidden = 1
" map enter to activating a node
let NERDTreeMapActivateNode='<CR>'
let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf', '.beam']

let g:browser = 'open '

set nowrap

"sm:    flashes matching brackets or parentheses
set showmatch

" From Jeff's vimrc. might be useful if autofocusing the text window is
" possible.
"autocmd vimenter * NERDTree

" insert hashrocket, =>, with control-l
imap <C-l> <Space>=><Space>

" Tab navigation
"nmap <leader>tn :tabnext<CR>
"nmap <leader>tp :tabprevious<CR>
"nmap <leader>te :tabedit

map th :tabprev<CR>
map tl :tabnext<CR>
map tn :tabnew<CR>
map td :tabclose<CR>

" (thanks, Brendan) Map W to w and Q to q, because I always fatfinger them
:command W w
:command Q q


