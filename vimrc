set encoding=utf-8
let mapleader=" "
syntax on
set backspace=2
set tabstop=4
set updatetime=100
"行号
set number
set relativenumber
set cursorline
"光标垂直移动时保持顶端/底端显示5行
set scrolloff=5
"show the typed command at bottom
set showcmd
"complete for orders at normal mode
set wildmenu
set hlsearch
set incsearch
exec "nohlsearch"
set ignorecase
"内容超出一行时自动折行
set wrap
set linebreak
"show filename below
set laststatus=2
map K 5k<CR>
map J 5j<CR>
map <c-j> 5<c-e>
map <c-k> 5<c-y>
"select all
map <c-a> ggVG
"split windows
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>
"switch windows
map <LEADER>l  <c-w>l
map <LEADER>h  <c-w>h
map <LEADER>j  <c-w>j
map <LEADER>k  <c-w>k
"resize windows by keyboard
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>
" 翻页
nnoremap <up> <c-b>
nnoremap <down> <c-f>
"resize windows by mouse
set mouse=a
"jump to the end of a line
map 9 $
map s :<nop>
map S :<nop>
map <LEADER>s :w<CR>
map <LEADER>w :q<CR>
"map R :source $MYVIMRC<CR>
map R :so %<CR>
" 在右侧打开Ex界面
nnoremap tt :set splitright<CR>:vsplit<CR>:Ex<CR>
noremap <LEADER><CR> :nohlsearch<CR>
noremap @@ @q
" shutdown errorbell
set vb t_vb=
"locate the position of last time
au BufReadPost * if line("'\"") > 1 && line("'\'") <= line("$") | exe "normal! g'\""| endif
"auto complete
"inoremap ' ''<ESC>i
"inoremap " ""<ESC>i
"inoremap ( ()<ESC>i
"inoremap [ []<ESC>i
"inoremap < <><ESC>i
"inoremap { {<CR>}<ESC>O
"jump to place holder to insert something
map <LEADER><LEADER> <Esc>gg/<<>><CR>:nohlsearch<CR>c4l
"Quick run by <F5>
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
elseif &filetype == 'sh'
		:!time bash %
elseif &filetype == 'python'
		silent! exec "!clear"
		exec "!time python3 %"
elseif &filetype == 'html'
		exec "!firefox % &"
elseif &filetype == 'go'
		exec "!go build %<"
		exec "!time go run %"
elseif &filetype == 'mkd'
		exec "!~/.vim/markdown.pl % > %.html &"
		exec "!firefox %.html &"
endif
endfunc


" ===
" === vim-plug
" ===
call plug#begin('~/.vim/plugged')
Plug 'connorholyday/vim-snazzy'
Plug 'mg979/vim-visual-multi'
Plug 'terryma/vim-expand-region'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
call plug#end()
color snazzy
let g:mkdp_auto_start = 1
let g:mkdp_refresh_slow = 1
let g:mkdp_open_to_the_world = 1
let g:mkdp_open_ip = '192.168.1.6'
let g:mkdp_port = 8080 
let g:mkdp_echo_preview_url = 1
function! g:EchoUrl(url)
:echo a:url
endfunction
let g:mkdp_browserfunc = 'g:EchoUrl'
map = <Plug>(expand_region_expand)
map - <Plug>(expand_region_shrink)
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Make <CR> auto-select the first completion item
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"Use <leader>rn for Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
