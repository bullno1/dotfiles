" --- Vundle ---
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'sjl/gundo.vim'
Plugin 'jimenezrick/vimerl'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'nanotech/jellybeans.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'groenewege/vim-less'
Plugin 'tikhomirov/vim-glsl'
Plugin 'uarun/vim-protobuf'
Plugin 'bling/vim-airline'
Plugin 'epeli/slimux'
Plugin 'derekwyatt/vim-scala'
Plugin 'lukerandall/haskellmode-vim'
Plugin 'vim-scripts/DetectIndent'
Plugin 'vim-scripts/django.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'junegunn/goyo.vim'
Plugin 'mileszs/ack.vim'
call vundle#end()

" opam
let g:opam_share = system("opam config var share")

" merlin
let s:merlin=substitute(opam_share,'\n$','','''') .  "/merlin"
execute "set rtp+=".s:merlin."/vim"

" ocp-indent
let g:ocp_indent_vimfile = substitute(g:opam_share, '[\r\n]*$', '', '') . "/vim/syntax/ocp-indent.vim"
autocmd FileType ocaml exec ":source " . g:ocp_indent_vimfile

filetype plugin indent on

" --- Plugin configurations ---
" Gundo
nnoremap <C-u> :GundoToggle<CR>

" CtrlP
nmap <leader>p :CtrlP<CR>

" slimux
map <C-c><C-c> :SlimuxREPLSendLine<CR>
vmap <C-c><C-c> :SlimuxREPLSendSelection<CR>
map <C-c><C-v> :SlimuxREPLConfigure<CR>
let g:slimux_select_from_current_window = 1

function! SlimuxEscape_ocaml(text)
	let trimmed = substitute(a:text, '\_s*$', '', '')
	if match(trimmed,';;\n*$') > -1
		return join([trimmed,"\n"])
	else
		return join([trimmed,";;\n"])
	endif
endfunction

" DetectIndent
autocmd BufReadPost *.hs,*.m,*.mm :DetectIndent
let g:detectindent_preferred_indent = 4

" vim-django
autocmd BufReadPost *.dtl :set ft=htmldjango

" ack.vim
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif

" --- General ---
set history=700
" Always use unix line ending
set ff=unix
" Always show status line
set laststatus=2
" Show a color column
set cc=80
" Don't fold by default
set foldlevel=99

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
if has("win32")
	set clipboard=unnamed
else
	set clipboard=unnamedplus
endif

set mouse=a

" Quick reload of .vimrc
nmap <leader>sv :source\ $MYVIMRC<Cr>
set wildignore+=*.so,*.swp,*.beam,.git,.hg,.svn,*.class,*.pyc,*.o,*.luac,*/build/*,bower_components,node_modules

" --- Interface ---
set number
set ruler
set showcmd
set shellslash

if has("unix")
	set guifont=Hermit\ Medium\ 11
else
	set guifont=Consolas:h12
endif

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
colorscheme jellybeans
set background=dark

"--- Tab ---
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
nmap <leader>p :CtrlP<CR>

"--- Plugin settings ---
let g:airline_theme='jellybeans'
let g:airline#extensions#ctrlp#color_template = 'normal'
nnoremap <leader>jd :YcmCompleter GoTo<CR>

function! YRRunAfterMaps()
    " Don't clobber the yank register when pasting over text in visual mode.
    vnoremap p :<c-u>YRPaste 'p', 'v'<cr>gv:YRYankRange 'v'<cr>
endfunction
