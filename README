                 __                                 
                /\ \          __                    
   __  __  __   \ \ \___     /\_\        ___ ___    
  /\ \/\ \/\ \   \ \  _ `\   \/\ \     /' __` __`\  
  \ \ \_/ \_/ \   \ \ \ \ \   \ \ \    /\ \/\ \/\ \ 
   \ \___x___/'    \ \_\ \_\   \ \_\   \ \_\ \_\ \_\
    \/__//__/       \/_/\/_/    \/_/    \/_/\/_/\/_/
                                                    
    - Wistia's favorite vim setup


To install whim:

  0) Backup your existing .vimrc and .gvimrc

    mv ~/.vimrc ~/.vimrc.backup 
    mv ~/.gvimrc ~/.gvimrc.backup 

  1) Install pathogen:

    mkdir -p ~/.vim/autoload ~/.vim/bundle
    curl https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim \
      > ~/.vim/autoload/pathogen.vim


  2) Clone whim into ~/.whim and set up the defaults:

    git clone git://github.com/wistia/whim.git ~/.whim
    ln -s ~/.whim/local/default.vimrc ~/.vimrc
    ln -s ~/.whim/local/default.gvimrc ~/.gvimrc

  3) This step is optional. If you want your command-t plugin to work:

    cd ~/.whim/bundle/command-t
    rvm use system
    rake make
    rvm use default

  4) This step is optional. If you want to customize your setup:
     
     Create a new file in ~/.whim/local, 
      then symlink it as in step 2! For example:

    ln -s ~/.whim/local/max.vimrc ~/.vimrc
    ln -s ~/.whim/local/max.gvimrc ~/.gvimrc

  5) Restart (mac)vim and enjoy.
