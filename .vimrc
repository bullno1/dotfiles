" --- Vundle ---
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'sjl/gundo.vim'
Plugin 'vim-erlang/vim-erlang-runtime'
Plugin 'vim-erlang/vim-erlang-compiler'
Plugin 'vim-erlang/vim-erlang-omnicomplete'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'nanotech/jellybeans.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'epeli/slimux'
Plugin 'vim-scripts/DetectIndent'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'mileszs/ack.vim'
Plugin 'octref/RootIgnore'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'leafgarland/typescript-vim'
Plugin 'kaarmu/typst.vim'
call vundle#end()

filetype plugin indent on

" --- Plugin configurations ---
" Gundo
nnoremap <C-u> :GundoToggle<CR>
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

" CtrlP
nmap <leader>p :CtrlP<CR>
nmap <leader>. :CtrlPTag<CR>

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
if &term =~ '^screen' && exists('$TMUX')
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
    execute "set <Insert>=\e[2;*~"
    execute "set <Delete>=\e[3;*~"
    execute "set <PageUp>=\e[5;*~"
    execute "set <PageDown>=\e[6;*~"
    execute "set <xF1>=\e[1;*P"
    execute "set <xF2>=\e[1;*Q"
    execute "set <xF3>=\e[1;*R"
    execute "set <xF4>=\e[1;*S"
    execute "set <F5>=\e[15;*~"
    execute "set <F6>=\e[17;*~"
    execute "set <F7>=\e[18;*~"
    execute "set <F8>=\e[19;*~"
    execute "set <F9>=\e[20;*~"
    execute "set <F10>=\e[21;*~"
    execute "set <F11>=\e[23;*~"
    execute "set <F12>=\e[24;*~"
endif

" Quick reload of .vimrc
nmap <leader>sv :source\ $MYVIMRC<Cr>
set wildignore+=*.so,*.swp,*.beam,.git,.hg,.svn,*.class,*.pyc,*.o,*.luac,*/build/*,bower_components,node_modules,deps

" --- Interface ---
set nonumber
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
let g:airline#extensions#whitespace#enabled = 0
nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_tsserver_binary_path = expand('~/bin/tsserver')
let g:ycm_always_populate_location_list = 1
let g:ycm_clangd_args=['--header-insertion=never']

if filereadable("deno.json")
	let g:ycm_language_server =
	  \ [
	  \   {
	  \     'name': 'deno',
	  \     'cmdline': [ 'deno', 'lsp' ],
	  \     'filetypes': [ 'typescript' ],
	  \     'project_root_files': [ 'deno.json' ],
	  \   }
	  \ ]
else
	let g:ycm_language_server =
	  \ [
	  \   {
	  \     'name': 'typst',
	  \     'cmdline': [ 'typst-lsp' ],
	  \     'filetypes': [ 'typst' ]
	  \   }
	  \ ]
endif

function! YRRunAfterMaps()
    " Don't clobber the yank register when pasting over text in visual mode.
    vnoremap p P
endfunction
