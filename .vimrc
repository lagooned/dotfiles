" setup vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" insert vundle plugins 

call vundle#end()

" visual settings
filetype plugin indent on
syntax on
set history=1000
set undolevels=1000
set ruler
set showcmd
set incsearch
set hlsearch
set autoindent
set copyindent
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set foldlevel=99
set matchpairs+=<:>
