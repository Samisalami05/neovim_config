let g:coq_settings = { 'auto_start': 'shut-up' }
" files "
luafile ~/.config/nvim/plugins.lua

" numbering "
set nu
set relativenumber

" tabs "
set autoindent
set tabstop=4 softtabstop=4
set shiftwidth=4
set noexpandtab

" searches "
set ignorecase
set smartcase
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" misc "
set autoread
set noswapfile
set nowrap

" colors "
set termguicolors
set background=dark

" binds "
tnoremap <ESC> <C-\><C-n>

nnoremap <A-S-p> :Files <CR>
nnoremap <A-S-r> :Ag <CR>

nnoremap <A-S-h> <C-w>h
nnoremap <A-S-j> <C-w>j
nnoremap <A-S-k> <C-w>k
nnoremap <A-S-l> <C-w>l
nnoremap <A-S-n> gT
nnoremap <A-S-m> gt

colorscheme gruvbox
