if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-expand-region'
Plug 'matze/vim-move'
Plug 'yuttie/comfortable-motion.vim'
Plug 'kshenoy/vim-signature'
Plug 'leafgarland/typescript-vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

" open nerdtree with C-p
map <C-t> :NERDTreeToggle<CR>
let g:NERDTreeNodeDelimiter = "\u00a0"
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" I need this for lightline to show up
set laststatus=2
" lightline shows the mode, so vim doesn't have to
set noshowmode

" hard mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" search preferences
set hlsearch
set incsearch
set nohlsearch
nohls

" enable syntax highlighting
syntax enable

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1

" from celo
" set number relativenumber
set ruler
set nocompatible
" set background=dark
" set backspace=indent,eol,start
" set ignorecase " searches are case insensitive...
" set smartcase  " ... unless they contain at least one capital letter
" set expandtab
" set smartindent
" set smarttab

" move line or selection up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" decrease updatetime so the vim-gitgutter is quick
set updatetime=100

" path magic: look for files in the current file's folder,
" then in the current folder, then in its subfolders
:set path=.,,**

" switch buffers without having to save/drop changes
set hidden

" always show signs column to avoid jumping back and forth
set signcolumn=yes

