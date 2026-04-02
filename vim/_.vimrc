"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 基础
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 关闭 vi 兼容模式
set nocompatible
set backspace=indent,eol,start

" 开启语法高亮
syntax enable

" 显示行号
set number
" 显示相对行号
set relativenumber
" 背景差异游标所在行
set cursorline

" 背景差异显示列,按字符数算
set cc=79

" 设定 << 和 >> 命令移动时的宽度为 4
set shiftwidth=4

" 设置tab为4个空格
set tabstop=4

""""""""
" 搜索
""""""""
" 搜索时忽略大小写
set ignorecase
" 禁止在搜索到文件两端时重新搜索
set nowrapscan
" 输入搜索内容时就显示搜索结果
set incsearch
" 搜索时高亮显示被找到的文本
set hlsearch

""""""""""""
" 编码设置
""""""""""""
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug插件管理
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 加载插件管理 路径为配置文件底下的plugged
call plug#begin()

" 配色方案
Plug 'liuchengxu/space-vim-dark'
" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" 电力字体
Plug 'Lokaltog/powerline'
" 文件管理
Plug 'preservim/nerdtree'
" 注释
Plug 'preservim/nerdcommenter'
" 全文查找
Plug 'rking/ag.vim'
" 模糊查找
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" git
Plug 'tpope/vim-fugitive'
" 在最后一个编辑位置打开文件
Plug 'farmergreg/vim-lastplace'
" 突出光标下的单词及其所有出现
Plug 'dominikduda/vim_current_word'
" 缩进提示
Plug 'Yggdroot/indentLine'
" 对齐
Plug 'junegunn/vim-easy-align'

" 语法检查 
Plug 'dense-analysis/ale'

" 语言服务器(lsp)
"Plug 'yegappan/lsp'

" 拼写检查 typos-lsp

Plug 'Vimjas/vim-python-pep8-indent'

" Godot
Plug 'habamax/vim-godot'
" Rust
Plug 'rust-lang/rust.vim'

" DEBUG
Plug 'puremourning/vimspector'

" 代码片段
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" reStructuredText
Plug 'habamax/vim-rst'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""
" 配色方案
"""""""""""
set t_Co=256
set background=dark
" 主题
colorscheme space-vim-dark
" 背景透明
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE

"""""""""""""""
" vim-airline
""""""""""""""
let g:airline_theme='violet'
" sudo apt-get install fonts-powerline
let g:airline_powerline_fonts = 1
let g:airline#extensions#default#layout = [
 \ [ 'a', 'b', 'c' ],
 \ [ 'x', 'y', 'z', 'error', 'warning' ]
 \ ]
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
if !exists('g:airline_powerline_fonts')
	let g:airline_left_sep='>'
	let g:airline_right_sep='<'
endif

""""""""""""""""
" 文件管理
""""""""""""""""
" NERD Tree
" file browser, https://github.com/preservim/nerdtree
" usage: ctrl-n
map <C-n> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1

" 当使用vim没有带文件参数时,自动打开NERDTree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 当使用vim带的参数是文件夹时,自动打开NERDTree
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

"当 NERDTree 是最后一个窗口时,退出vim
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" 当 NERDTree 是最后一个窗口时,关闭选项卡
"autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"""""""
" 注释
"""""""
" NERD Commenter
" comment https://github.com/preservim/nerdcommenter
" default mappings
" [count]<leader>c<space>
let g:NERDDefaultAlign = 'left'
let NERDTreeIgnore = ['\.pyc$']

"""""""""""""""
" 全文查找
"""""""""""""""
" ag.vim
" https://github.com/rking/ag.vim
" usage: :Ag [options] {pattern} [{directory}]
" need:  the silver searcher
" 快捷键
" e  打开文件关闭搜索窗口
" go 预览文件(打开文件,但游标还在搜索窗口)
let g:ag_working_path_mode="r"

""""""""""""""
" 模糊查找文件
""""""""""""""
" LeaderF
" https://github.com/Yggdroot/LeaderF.git
" usage: ctrl-p
let g:Lf_ShortcutF = '<C-P>'
" 如果使用的话,只会搜索仓库内的文件
let g:Lf_UseVersionControlTool = 0

""""""""""""
" 大纲式导航
""""""""""""
" tagbar
" https://github.com/majutsushi/tagbar
" usage: \b

"map <leader>b :TagbarToggle<CR>

" 使用LeaderF的bufTag
noremap <leader>b :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>

"""""""
" 对齐
"""""""
" usage: markdowm 表格对其 gaip*|
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""""""""""
" 自动补全
"""""""""""""
" 1. 全局指定 Python 解释器路径（指向你的 2.7 可执行文件）
let g:ale_python_executable = '/home/lyncir/Repos/env_2.7/bin/python2.7'
" 2. 针对特定工具指定路径（如果这些工具装在 2.7 的 pip 里）
let g:ale_python_flake8_executable = '/home/lyncir/Repos/env_2.7/bin/flake8'
let g:ale_python_pyright_executable =  '/home/lyncir/.local/share/nvim/lsp_servers/pyright/node_modules/.bin/pyright-langserver'
" 1. 手动定义 typos-lsp (如果 ALE 默认没集成)
call ale#linter#Define('python', {
\   'name': 'typos_lsp',
\   'lsp': 'stdio',
\   'executable': 'typos-lsp',
\   'command': '%e',
\   'project_root': function('ale#python#FindProjectRoot'),
\})

" 3. 配置 Linter（语法检查器）
let g:ale_linters = {
\   'python': ['flake8', 'pyright', 'typos_lsp'],
\}

" 例如让 flake8 忽略一些 Py3 独有的规则
let g:ale_python_flake8_options = '--ignore=E121,E123,E126,E226,E241,E242,E704,W503,E501'
" 显示提示的linter名字
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

""""""""
" 何时检查补全
""""""""""
" 禁用边打字边检查
let g:ale_lint_on_text_changed = 'never'
" 离开插入模式时检查（可选）
let g:ale_lint_on_insert_leave = 0
" 保存文件时检查（最推荐）
let g:ale_lint_on_save = 1

""""""""
" LSP
"""""""
" 允许 ALE 优先使用已运行的 LSP 实例
let g:ale_disable_lsp = 0

"""""""
" UI
"""""""
" 不打开窗口
let g:ale_open_list = 0
" 在侧边栏显示错误/警告图标
let g:ale_set_signs = 1
" 在代码中对错误文本进行高亮（加粗或下划线）
let g:ale_set_highlights = 1
" Pyright 使用错误图标
let g:ale_sign_error = '✘'
" Flake8 使用风格图标（通过 type_map 确保它显示为 Warning）
let g:ale_sign_warning = '≈'
" 设置虚拟文本颜色
" --- 1. 设置错误消息为红色 (针对 Pyright/Error) ---
highlight ALEVirtualTextError guifg=#FF0000 ctermfg=Red
" --- 2. 设置警告消息为黄色 (针对 Flake8/Warning) ---
highlight ALEVirtualTextWarning guifg=#FFA500 ctermfg=Yellow
" --- 3. 设置信息/提示消息为蓝色 (可选) ---
highlight ALEVirtualTextInfo guifg=#00FFFF ctermfg=Cyan


"""""""""
" 开启 ALE 自动补全(手动)
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 999999
" 在 Python 文件中自动设置 omnifunc 为 ALE 的函数
autocmd FileType python setlocal omnifunc=ale#completion#OmniFunc
"
" 补全时不搜索包含文件 (Scan included files)
set complete-=i
" 补全时不搜索定义 (Scan defined identifiers)
set complete-=d
" 按 Ctrl-p 只走 ALE
autocmd FileType python inoremap <buffer> <C-p> <C-x><C-o>

"""""""
" 快捷键
"""""""
" 用 <leader>l 打开错误列表
nnoremap <leader>l :lopen 20<CR>
" 用 <leader>lc 关闭错误列表
nnoremap <leader>lc :lclose<CR>


" Enable ALE auto completion globally
"let g:ale_completion_enabled = 1
" Allow ALE to autoimport completion entries from LSP servers
"let g:ale_completion_autoimport = 1
" Register LSP server for Godot:
"call ale#linter#Define('gdscript', {
"\   'name': 'godot',
"\   'lsp': 'socket',
"\   'address': '127.0.0.1:6005',
"\   'project_root': 'project.godot',
"\})


" Godot
"func! GodotSettings() abort
"    setlocal foldmethod=expr
"    setlocal tabstop=4
"    nnoremap <buffer> <F4> :GodotRunLast<CR>
"    nnoremap <buffer> <F5> :GodotRun<CR>
"    nnoremap <buffer> <F6> :GodotRunCurrent<CR>
"    nnoremap <buffer> <F7> :GodotRunFZF<CR>
"endfunc
"augroup godot | au!
"    au FileType gdscript call GodotSettings()
"augroup end


""""""""""""""""""""""""
" DEBUG工具: vimspector
""""""""""""""""""""""""
" Python: debugpy
" :VimspectorInstall debugpy
" Full options: https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
let g:vimspector_enable_mappings='HUMAN'


""""""""""""""""""""""""
" 代码片段 ultisnips
" next: ctrl-j
""""""""""""""""""""""""
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"


""""""""""""
" 拼写检查
""""""""""""
" typos-lsp
" https://github.com/tekumara/typos-lsp

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 快捷键
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" clear key_mapping
let g:vim_better_default_key_mapping = 0

""""""""""""
" 窗口分割
""""""""""""
" 左右分割: Ctrl+w + v
" 上下分割: Ctrl+w + s
" 关闭当前窗口: Ctrl+w + q
" 切换窗口: Ctrl+w + jklh
" 调整窗口大小: Ctrl+w + 数值 + >/<
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" tabs
map gt :bn<CR>
map gT :bp<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 其它
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""
" reStructuredText预览
" pip install rst2html5
""""""""""""""""""""""""
func! s:rst_view() abort
  let output = tempname() . '.html'

  call system(printf("%s %s %s",
        \ "rst2html5",
        \ shellescape(expand("%:p")),
        \ output
        \ ))

  " Comment/Uncomment what is appropriate
  " Windows
  "exe ':silent !start ' . output
  " OSX
  " exe ':silent !xdg-open ' . output
  " Linux
   exe ':silent !open ' . output
endfunc

command! -buffer RSTView call s:rst_view()

""""""""""""""""""""""""
" add python file header
""""""""""""""""""""""""
let g:header_field_author = 'lyncir'

autocmd bufnewfile *.py so ~/.vim/py_header.txt
autocmd bufnewfile *.py ks|call NewCreate()|'s
fun NewCreate()
  if line("$") > 20
    let l = 20
  else
    let l = line("$")
  endif
  exe "1," . l . "g/:create by:/s/:create by:.*/:create by: " . g:header_field_author
  exe "1," . l . "g/:date:/s/:date:.*/:date: " . strftime("%Y-%m-%d %H:%M:%S (%z)")
endfun

" 游标返回
autocmd Bufwritepre,filewritepre *.py execute "normal ma"

" 设置背景透明(放到最后)
hi Normal  ctermfg=252 ctermbg=none

" 关闭折叠
set foldmethod=manual
set foldlevel=100

" 显示tab 启用: set invlist
set listchars=tab:▷▷⋮
