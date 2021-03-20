" 加载文件类型
filetype plugin on
set encoding=utf-8
" let mapleader=" "
syntax on
set backspace=2
set tabstop=4
set expandtab
set shiftwidth=4
set updatetime=100
"行号
set number
"set relativenumber
"set cursorline
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
" 不要产生交换文件
set noswapfile
"show filename below
set laststatus=2
nnoremap j gj
nnoremap k gk
nnoremap gk k
nnoremap gj j
noremap K 5gk
noremap J 5gj
nnoremap H 5<c-e>
nnoremap L 5<c-y>
" 全选
map <SPACE>a ggVG
" 分屏
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>
" 将光标移动到下一个窗口
map <SPACE>l  <c-w>l
map <SPACE>h  <c-w>h
map <SPACE>j  <c-w>j
map <SPACE>k  <c-w>k
" 修改窗口大小
nnoremap <left> :vertical resize-5<CR>
nnoremap <right> :vertical resize+5<CR>
" 翻页
nnoremap <c-j> <c-b>
nnoremap <c-k> <c-f>
nnoremap <up> <c-b>
nnoremap <down> <c-f>
" 允许用鼠标操作
set mouse=a
" 去往行尾
map 9 $
map s :<nop>
map S :<nop>
map <SPACE>s :w<CR>
map <SPACE>w :q<CR>
map <SPACE>q :q!<CR>
"map R :source $MYVIMRC<CR>
map R :so %<CR>
noremap <SPACE><CR> :nohlsearch<CR>
"nnoremap tt :Vexplore<CR>
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
inoremap { {<CR>}<ESC>O
inoremap {} {}<ESC>i
" markdown下简洁地输入粗体字
autocmd Filetype markdown :inoremap ,a **** <<>><Esc>6hi
autocmd Filetype markdown :inoremap ,b <Esc>/<<>><CR>:nohlsearch<CR>c4l
"Quick run by <F5>
map <F5> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
	if &filetype == 'c'
		silent! exec "!g++ % -o %<"
        silent! exec "!clear"
		exec "!./%<"
    elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!./%<"
    elseif &filetype == 'java'
		exec "!javac %"
		exec "!java %<"
    elseif &filetype == 'sh'
		:!time bash %
    elseif &filetype == 'python'
        silent! exec "!clear"
		exec "!python3 %"
    elseif &filetype == 'html'
		exec "!google-chrome % &"
    elseif &filetype == 'go'
		exec "!go build %<"
		exec "!go run %"
    endif
endfunc


" ===
" === vim-plug
" ===
call plug#begin('~/.vim/plugged')
Plug 'mg979/vim-visual-multi'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'preservim/nerdcommenter'
Plug 'iberianpig/ranger-explorer.vim'
Plug 'dhruvasagar/vim-table-mode'
call plug#end()
" ========================
" === markdown-preview配置
" ========================
let g:mkdp_auto_start = 1
let g:mkdp_refresh_slow = 1
let g:mkdp_open_to_the_world = 1
let g:mkdp_port = 8080 
let g:mkdp_echo_preview_url = 1
let g:mkdp_browserfunc = 'g:EchoUrl'
" ========================
" === ranger-explore配置
" ========================
let g:ranger_map_keys = 0
" 在左侧打开Ex界面
nnoremap tt :RangerOpenCurrentDir<CR>
" ========================
" === nerdcommenter配置
" ========================
let g:NERDCreateDefaultMappings = 0
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" 映射NERDCommenterInvert
map <SPACE>c <plug>NERDCommenterInvert
" ========================
" === vim-table-mode配置
" ========================
" 设置table mode先导键为<SPACE>t
let g:table_mode_map_prefix = '<SPACE>t' 
" 进入或退出table模式时给出提示
let g:table_mode_verbose = 1
let g:table_mode_corner='|'
