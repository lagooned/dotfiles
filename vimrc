" setup vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" insert vundle plugins 
Plugin 'scrooloose/nerdcommenter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-vinegar'

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
set relativenumber
set noswapfile
set nobackup
set ignorecase
set smartcase
nnoremap <Space> @q

" global powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2

" temp directory
set backupdir=~/.tmp,.
set directory=~/.tmp,.
