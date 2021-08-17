" ################################################################
" PLUGINS

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    Plug 'airblade/vim-gitgutter'
    Plug 'itchyny/lightline.vim'
    Plug 'tpope/vim-surround'
    Plug 'kshenoy/vim-signature'
    Plug 'ayu-theme/ayu-vim'
    Plug 'tomtom/tcomment_vim'
    Plug 'junegunn/vim-peekaboo'
    Plug 'Yilin-Yang/vim-markbar'
    Plug 'ap/vim-buftabline'
    Plug 'vim-scripts/ReplaceWithRegister'
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-entire'
    Plug 'machakann/vim-highlightedyank'
    Plug 'adelarsq/vim-matchit'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

" decrease updatetime so the vim-gitgutter is quick
set updatetime=100

" I need this for lightline to show up
set laststatus=2

" lightline shows the mode, so vim doesn't have to
set noshowmode

" ################################################################
" APPARENCE

set termguicolors     " enable true colors support
let ayucolor="light"  " for light version of theme
colorscheme ayu
set guifont=Operator\ Mono\ Book:h16

set cursorline
set number relativenumber
set signcolumn=yes  " always show signs column to avoid jumping back and forth

" ################################################################
" BEHAVIOR

" sanity
set nocompatible
set hidden " switch buffers without having to save/drop changes 

" autosave and autoload sessions
autocmd! QuitPre * mksession! ~/.vim/sessions/auto.vim
autocmd VimEnter * nested source ~/.vim/sessions/auto.vim
set ssop-=options    " do not store global and local values in a session

" list options on tab-completion, like bash's menu-complete
set wildmenu
set wildmode=longest:list,full

nnoremap Y y$

" ################################################################
" MAPPINGS

map <Space> <Leader>
nnoremap H ^
nnoremap L $

" delete without yanking with leader-d
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

nnoremap <leader>[ :bp<CR>
nnoremap <leader>] :bn<CR>

" ################################################################
" PREFERENCES
set complete+=kspell

" Searching
set hlsearch
set incsearch
set nohlsearch
nohls
set ignorecase " searches are case insensitive...
set smartcase  " ... unless they contain at least one capital letter

syntax enable
set showmatch

set ts=4  " tab width
set autoindent
set expandtab
set shiftwidth=4
set smartindent
set smarttab

" path magic: look for files in the current file's folder,
" then in the current folder, then in its subfolders
set path=.,,**

" Make all marks global by automatically uppercasing their letter
noremap <silent> <expr> m "m".toupper(nr2char(getchar()))
noremap <silent> <expr> ' "'".toupper(nr2char(getchar()))
noremap <silent> <expr> ` "`".toupper(nr2char(getchar()))
