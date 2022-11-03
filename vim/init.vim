

"Encode {{{
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8
scriptencoding=UTF-8
" }}}

"File, Buffer {{{
syntax on
set number
set nobomb
set hidden       "ファイル変更中でも他のファイルを開けるようにする
set nobackup     "バックアップは作成しない。スワップは作成する。
set noundofile
set history=1000
" set dir=c:\\tmp
" goto file gf
set suffixesadd=.txt,.md
" }}}

"Search {{{
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
" }}}

"Tab, Wrap {{{
set shiftwidth=4
set tabstop=4
set softtabstop=4
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,] "カーソルを行頭、行末で止まらないようにする
set clipboard=unnamed
autocmd FileType text setlocal textwidth=0
" }}}

" def map {{{
let mapleader = "\<Space>"
noremap <Leader>o :edit $MYVIMRC<CR>
nnoremap <Leader>w :<c-u>w<CR>
nnoremap <Leader>q :<c-u>bdel<CR>
nnoremap <Leader>e :source $MYVIMRC<CR>
" undo redo を <C-u>, <C-r> に
nnoremap <C-u> u

" buffer
nnore <C-j> :enew<CR>
nnore gt :bnext<CR>
nnore - :bnext<CR>
nnore = :bprevious<CR>

set iskeyword+=-,'

" move
nnoremap n gj
nnoremap k gk
map L $
map H ^
noremap! <C-d> <C-h>
inoremap <C-k> <C-o>gk
inoremap <C-n> <C-o>gj
noremap! <C-l> <RIGHT>
noremap! <C-h> <LEFT>
noremap! <C-e> <End>
inoremap <C-u> <ESC>^i
cnoremap <C-k> <UP>
cnoremap <C-n> <DOWN>
cnoremap <C-j> <C-n>
inoremap <C-b> <C-o>b
inoremap <C-f> <C-o>w
vnoremap n j
vnoremap j n

" 親和
inoremap <C-j> <C-n>
noremap! <C-o> <Esc>
vnoremap <C-o> <ESC>
inoremap <C-c> <C-o>
nnoremap <C-c> <C-o>
nnoremap o o<Esc>o　
nnoremap <C-o> G
noremap <C-h> I

nnoremap d, dt，
nnoremap d. df。
nnoremap <ESC><ESC> :set columns=80<CR>:noh<CR>
inoremap <C-z> <C-o>u
" 単語送り
nnoremap <C-e> xhep
" 全体コピー
noremap A :%y<CR>

" 操作感の微調整。
nnoremap ; :
nnoremap q; q:
noremap <C-l> A

" search + zz
nnoremap <C-n> nzz
nnoremap <C-k> Nzz
nnoremap * *zz
nnoremap # #zz

set listchars=eol:¤,space:·,tab:¦¸
" }}

