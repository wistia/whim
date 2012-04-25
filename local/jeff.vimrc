source ~/.whim/vimrc
set nocompatible
filetype off  " required!


set rtp+=~/.vim/vundle.git/ 
call vundle#rc()

" My Bundles here:
" "
" " original repos on github
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'nelstrom/vim-markdown-preview'

" non github repos
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'snipMate'
Bundle 'css_color.vim'



filetype plugin indent on     " required!
" this is my home!!!
cd ~/
