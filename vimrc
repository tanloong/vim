" Author: @tanloong

set nocompatible
filetype plugin indent on
set encoding=utf-8
" 行号
set number
exec "nohlsearch"
syntax on
set backspace=2
set tabstop=4
set expandtab
set shiftwidth=4
set updatetime=100
" 允许用鼠标操作
set mouse=a
" 光标垂直移动时保持顶端/底端显示5行
set scrolloff=5
" show the typed command at bottom
set showcmd
" Ex模式下按Tab补全命令
set wildmenu
set hlsearch
set incsearch
set ignorecase
noremap @@ @q
" 内容超出一行时自动换行
set wrap
set linebreak
" 不要产生交换文件
set noswapfile
" show filename below
set laststatus=2
nnoremap j gj
nnoremap k gk
nnoremap gk k
nnoremap gj j
noremap K 5gk
noremap J 5gj
nnoremap <c-j> 5<c-e>
nnoremap <c-k> 5<c-y>
" 全选
map <SPACE>a ggVG
" 新建窗口
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>
" 切换窗口
map <SPACE>l  <c-w>l
map <SPACE>h  <c-w>h
map <SPACE>j  <c-w>j
map <SPACE>k  <c-w>k
" 修改窗口大小
nnoremap <left> :vertical resize-5<CR>
nnoremap <right> :vertical resize+5<CR>
" 翻页
nnoremap H <c-b>
nnoremap L <c-f>
nnoremap <up> <c-y>
nnoremap <down> <c-e>
" 合并两行
noremap M J
" 去往行尾
map 9 $
map s :<nop>
map S :<nop>
map <SPACE>s :w<CR>
map <SPACE>w :q<CR>
map <SPACE>q :q!<CR>
"map R :source $MYVIMRC<CR>
map R :so %<CR>
noremap <SPACE><CR> :nohlsearch<CR>:set nospell<CR>
" shutdown errorbell
set vb t_vb=
" 打开文件时跳到上次退出的位置
au BufReadPost * if line("'\"") > 1 && line("'\'") <= line("$") | exe "normal! g'\""| endif

" ===
" === 插入模式
" ===
"inoremap ' ''<ESC>i
"inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
"inoremap < <><ESC>i
inoremap {} {}<Esc>i
" 插入模式下跳到],{,)的右侧
inoremap ,e <Esc>%%a
" 插入模式下跳到行尾
inoremap <c-e> <c-o>$
" 插入模式下跳到行首
inoremap <c-a> <c-o>0
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-j> <down>
inoremap <c-k> <up>
" 插入模式下撤销
inoremap <c-z> <c-o>u
" 跳到占位符
inoremap ,b <Esc>/<<>><CR>:set nohlsearch<CR>c4l

" 对各类型的文件分别设置快捷键
autocmd FileType markdown,tex,c,cpp exec ":call AutoSet()"
func! AutoSet()
    if &filetype == 'c' || &filetype == 'cpp'
        :inoremap } <CR>{<CR>}<ESC>O
        :inoremap `if if ()<CR>{<CR>}<Esc>O<<>><Esc>kki
        :inoremap `for for ()<CR>{<CR>}<Esc>O<<>><Esc>kki
        :inoremap `main main ()<CR>{<CR>}<Esc>O
    elseif &filetype == 'markdown'
        :inoremap ,a **** <<>><Esc>6hi
    elseif &filetype == 'tex'
        :inoremap ,a \{<<>>}<Esc>5hi
        :inoremap ,c \[<<>>]{<<>>}<Esc>11hi
    endif
endfunc

" Compile
map <F5> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
	if &filetype == 'c' || &filetype == 'cpp'
		silent! exec "!g++ % -o %<"
        silent! exec "!clear"
		exec "!./%<"
    elseif &filetype == 'java'
		exec "!javac %"
		exec "!java %<"
    elseif &filetype == 'sh'
        silent! exec "!clear"
		exec "!bash %"
    elseif &filetype == 'python'
        " silent! exec "!clear"
		exec "!python3 %"
    elseif &filetype == 'html'
		exec "!google-chrome % &"
    elseif &filetype == 'tex'
        silent! exec "VimtexStop"
        silent! exec "VimtexCompile"
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
Plug 'dhruvasagar/vim-table-mode', { 'for': ['markdown']}
Plug 'lervag/vimtex', {'for': ['tex']}
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
" 打开ranger
nnoremap tt :RangerOpenCurrentDir<CR>
" nnoremap tt :Vexplore<CR>
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
