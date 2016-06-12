"~/.vimrc
"install from vim ":PluginInstall"
"install from command line: "vim +PluginInstall +qall"
color desert
set background=light
set hlsearch
set number
set showmatch
set ignorecase
set shell=/bin/bash
syntax on


"vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin on
