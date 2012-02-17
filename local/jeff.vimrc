source ~/.whim/vimrc
set nocompatible
filetype off  " required!
autocmd vimenter * NERDTree


set rtp+=~/.vim/vundle.git/ 
call vundle#rc()

" My Bundles here:
" "
" " original repos on github
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'




filetype plugin indent on     " required!
" this is my home!!!
cd ~/
