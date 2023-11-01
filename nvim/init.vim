" Basic setup
set nocompatible
syntax enable
filetype plugin on
 



" General configurations

set termguicolors
" number of spaces in a <Tab>
set tabstop=4
set softtabstop=4
set expandtab
" enable autoindents
set smartindent
" number of spaces used for autoindents
set shiftwidth=4
" columns used for the line number
set numberwidth=4
" navigate buffers without losing unsaved work
set hidden
" case insensitive search unless capital letters are used
set ignorecase
set smartcase

set wrap
set encoding=utf-8
set relativenumber
set laststatus=2 
set scrolloff=4
set incsearch
set updatetime=100
set signcolumn=yes






" FINDING FILES
 
"Search down subfolders
" Provides tab-completion for all file-related tasks
set path+=**
 " Display all matching files when we tab complete
" Goodies
" --> :find supports partial match
" --> Fuzzy search active using *
" --> tab autocomplete buffer supported (:b) 
set wildmenu
 




" Plugin manager
if filereadable(expand("~/.vimrc.plug"))
  source ~/.vimrc.plug
endif
 
colorscheme onedark




lua require('configs')
