" setup vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" insert vundle plugins here

call vundle#end()

" visual settings
set number
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
