" --- Vundle ---
set nocompatible               " be iMproved
filetype off                   " required!idd
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'vim-scripts/Wombat'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'sjl/gundo.vim'
Bundle 'jimenezrick/vimerl'

filetype plugin indent on

" --- Plugin configurations ---
" Gundo
nnoremap <C-u> :GundoToggle<CR>
" CtrlP
nmap <leader>p :CtrlP<CR>

" --- General ---
set history=700

set guioptions-=m
set guioptions-=T
set guioptions-=r

let mapleader = ","
let g:mapleader = ","

imap jj <esc>
nmap ; :

set nobackup
set nowb
set noswapfile

set nowrap
set clipboard=unnamedplus

nmap <leader>sv :source\ $MYVIMRC<Cr>

" --- Interface ---
set number
set ruler
set showcmd
set shellslash

" Unicode
if has("multi_byte")
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	set encoding=utf-8
	setglobal fileencoding=utf-8
	"setglobal bomb
	set fileencodings=ucs-bom,utf-8,latin1
endif

" Hide buffer when :q
set hid

" Configure backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
map <silent> <space> :noh<cr>

" Bracket
set showmatch
set mat=2

" No visual bell
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" disable arrow
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Quick save
imap <silent> <C-s> <Esc>:w<Cr>
nmap <silent> <C-s> :w<Cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\	exe "normal! g`\"" |
	\ endif
" Remember info about open buffers on close
set viminfo^=%

"--- Color and fonts ---
syntax enable
colorscheme wombat
set background=dark

"--- Tab ---
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
nmap <leader>p :CtrlP<CR>
