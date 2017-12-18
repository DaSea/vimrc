scriptencoding utf-8
" ==============================================================================
" 系统及gui判断{{{
"/////////////////////////////////////////////////////////////////////////////
" -----------------------------------------------------------------------------
"  判断操作系统:1, windows; 2, cygwin,msys; 3. linux; 4, mac;
let g:iswindows = 0
let g:iswinunix = 0
let g:islinux = 0
let g:ismac = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
elseif has("win32unix")
    let g:iswinunix = 1
elseif has('macunix')
    let g:ismac = 1
else
    let g:islinux = 1
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" -----------------------------------------------------------------------------
" 判断是vim还是nvim
let g:isNvim = 0
if has("nvim")
  let g:isNvim = 1
endif

" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if !exists('g:exvim_custom_path')
    if g:iswindows
        set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    endif
endif
" }}}

" ==============================================================================
" language and encoding setup  语言及编码设置{{{
" always use English menu一般使用英文菜单
set langmenu=none

" use English for anaything in vim-editor.
if g:iswindows
    silent exec 'language english'
elseif g:ismac
    silent exec 'language en_US'
else
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        " in mac-terminal
        silent exec 'language en_US'
    else
        " in linux-terminal
        silent exec 'language en_US.utf8'
    endif
endif

" try to set encoding to utf-8
if g:iswindows
    " Be nice and check for multi_byte even if the config requires
    " multi_byte support most of the time
    if has('multi_byte')
        " Windows cmd.exe still uses cp850. If Windows ever moved to
        " Powershell as the primary terminal, this would be utf-8
        set termencoding=cp936
        " Let Vim use utf-8 internally, because many scripts require this
        set encoding=utf-8
        setglobal fileencoding=utf-8
        " Windows has traditionally used cp1252, so it's probably wise to
        " fallback into cp1252 instead of eg. iso-8859-15.
        " Newer Windows files might contain utf-8 or utf-16 LE so we might
        " want to try them first.
        set fileencodings=utf-8,cp936,gbk,gb2312,gb18030,utf-16le,cp1252,ucs-bom,iso-8859-15
    endif
else
    " set default encoding to utf-8
    set encoding=utf-8
    set termencoding=utf-8
endif
"}}}

" ==============================================================================
" 全局配置变量(Dictionnary){{{
let g:setting = {}
" 分隔符：具体看https://github.com/ryanoasis/powerline-extra-symbols
" 1. 三角符号; 2. 火焰符号; 3. 圆角符号; 4. 左斜; 5. 左斜; 6. 波纹; 7. 点
" [0, 1, 2, 3] = [left, left sub, right, right sub]
let g:separator_list = [
            \ ["\ue0b0", "\ue0b1", "\ue0b2", "\ue0b3"],
            \ ["\ue0c0", "\ue0c1", "\ue0c2", "\ue0c3"],
            \ ["\ue0b4", "\ue0b5", "\ue0b6", "\ue0b7"],
            \ ["\ue0b8", "\ue0b9", "\ue0ba", "\ue0bb"],
            \ ["\ue0bc", "\ue0bd", "\ue0be", "\ue0bf"],
            \ ["\ue0c8", "\ue0c9", "\ue0ca", "\ue0cb"],
            \ ["\ue0c4", "\ue0c6", "\ue0c5", "\ue0c7"]
            \ ]
" 定义全局的分割符
let separator_index = 3
let g:setting.left_separator = g:separator_list[separator_index][0]
let g:setting.left_sub_separator = g:separator_list[separator_index][1]
let g:setting.right_separator = g:separator_list[separator_index][2]
let g:setting.right_sub_separator = g:separator_list[separator_index][3]
let g:plugins_file = '.vimrc.vimplug'
" 全局设置seoul256-light, NeoSolarized
" let g:setting.color_scheme = 'gruvbox'
let g:setting.color_scheme = 'NeoSolarized'
" 关于更改行的设置(git(vim-fugitive, vim-gitgutter), git_svn(vim-signify), no)
let g:setting.version_status = 'no'
" 是否使用vim-devicons
let g:setting.use_devicons = 'yes'
" 状态栏(airline, lightline or no), 如果为no, 自定义状态栏
" let g:setting.status_line = 'airline'
let g:setting.status_line = 'lightline'
" let g:setting.status_color = 'gruvbox'
let g:setting.status_color = 'dark'
let g:setting.show_tabline = 'yes'
" 是否使用exVim系列插件
let g:setting.use_exvim = 'yes'
" 使用ctrlp还是使用unit.vim(denite.nvim)
" 由于denite出色的特性, 测试用denite替换unite相关插件, 或者用LeaderF
if g:isNvim
    " let g:setting.ctrlp_or_unite = 'unitvim'
    let g:setting.ctrlp_or_unite = 'leaderf'
else
    let g:setting.ctrlp_or_unite = 'leaderf'
endif
" 是否需要开启代码的静态语法检查(neomake插件)
let g:setting.make_lint_need = 'no'
" 是否需要开启括号补全
let g:setting.auto_pairs_need = 'yes'
" 参数补全(tenfyzhong/CompleteParameter.vim)
let g:setting.auto_paramcomplete = 'no'
" name
let g:setting.author_name = 'DaSea'
" windows与linux使用不同的目录
if g:iswindows
    let g:setting.vimwiki_path = 'E:/Self/01_mywiki/dasea.github.io/'
    let g:setting.private_snippets = $VIM.'/snippets'
else
    let g:setting.vimwiki_path = '~/dasea.github.io/'
    let g:setting.private_snippets = '~/snippets'
endif
" 设置需要支持的语言(目前有python, cpp, markdown, plantuml, vim, php, org, lua )
" let g:language_group = ['cpp', 'python', 'markdown', 'vim', 'todo', 'plantuml', 'go']
let g:language_group = ['cpp', 'markdown', 'vim', 'org', 'plantuml']
" }}}

" ==============================================================================
" vim-plug steup 插件管理插件设置{{{
"/////////////////////////////////////////////////////////////////////////////
" 需要在加载插件前设置，不然map的无效
if 1==g:islinux " 由于在linux上的按键有问题,使用的是微星的键盘布局
    let mapleader = "<"
endif

set nocompatible
set hidden
set showtabline=0

" 设置exvim工作路径
if exists('g:exvim_custom_path')
    let g:ex_tools_path = g:exvim_custom_path.'/vimfiles/tools/'
else
    let g:ex_tools_path = '~/.vim/tools/'
endif

if has("python") || has("python3")
    let g:plug_threads = 15
else
    let g:plug_threads = 1
endif

" Vim-plug setting {{{
if exists('g:exvim_custom_path')
    let g:vim_plugin_path = g:exvim_custom_path.'/.vimrc.vimplug'
    call plug#begin(g:exvim_custom_path.'/vimfiles/plugged/')
else
    let g:vim_plugin_path = '~/.vimrc.vimplug'
    call plug#begin('~/.vim/plugged')
endif

" 读取插件配置信息
if filereadable(expand(g:vim_plugin_path))
    exec 'source ' . fnameescape(g:vim_plugin_path)
endif

call plug#end()
"}}}
" 插件加载完成后调用一些初始化函数
call PluginLoadFinished()

syntax on " required
"}}}

" ==============================================================================
" 备份及 历史等设置{{{
"/////////////////////////////////////////////////////////////////////////////
" where gf, ^Wf, :find will search
if g:iswindows
    set path +=.,D:/Develop/Java/android-ndk-r10/platforms/android-14/arch-arm/usr/include,D:/Develop/Java/android-ndk-r10/sources/cxx-stl/gnu-libstdc++/4.6/include
endif
"set backup " make backup file and leave it around
set nobackup

" setup back and swap directory
let data_dir = $HOME.'/.data/'
let backup_dir = data_dir . 'backup'
let swap_dir = data_dir . 'swap'
if finddir(data_dir) == ''
    silent call mkdir(data_dir)
endif
if finddir(backup_dir) == ''
    silent call mkdir(backup_dir)
endif
if finddir(swap_dir) == ''
    silent call mkdir(swap_dir)
endif
unlet backup_dir
unlet swap_dir
unlet data_dir

set backupdir=$HOME/.data/backup " where to put backup file
set directory=$HOME/.data/swap " where to put swap file

" Redefine the shell redirection operator to receive both the stderr messages and stdout messages
set shellredir=>%s\ 2>&1
set history=50 " keep 50 lines of command line history
set updatetime=1000 " default = 4000
set autoread " auto read same-file change ( better for vc/vim change )
set autowriteall
set maxmempattern=1000 " enlarge maxmempattern from 1000 to ... (2000000 will give it without limit)

"/////////////////////////////////////////////////////////////////////////////
" xterm settings
"/////////////////////////////////////////////////////////////////////////////
behave xterm  " set mouse behavior as xterm
if &term =~ 'xterm'
    set mouse=a
endif

" }}}

" ==============================================================================
" 字体设置(font set){{{
if g:isGUI
    augroup ex_gui_font
        " check and determine the gui font after GUIEnter.
        " NOTE: getfontname function only works after GUIEnter.
        au!
        au GUIEnter * call s:set_gui_font()
    augroup END

    " set guifont
    function! s:set_gui_font()
        if g:iswindows
            " if getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
                " set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11:cANSI
            if getfontname('Inziu Iosevka SC') != ''
                set guifont=Inziu\ Iosevka\ SC:h14:cANSI
            elseif getfontname( 'Microsoft YaHei Mono' ) != ''
                set guifont=Microsoft\ YaHei\ Mono:h12:cANSI
            elseif getfontname( 'Consolas' ) != ''
                set guifont=Consolas:h12:cANSI " this is the default visual studio font
            endif
        elseif g:islinux
            " if getfontname( 'DejaVuSansMono Nerd Font Mono' ) != ''
                " set guifont=DejaVuSansMono\ Nerd\ Font\ Mono\ 14
            if getfontname( 'UbuntuMono Nerd Font Mono' ) != ''
                set guifont=UbuntuMono\ Nerd\ Font\ Mono\ 14
            elseif getfontname('Inziu Iosevka SC') != ''
                set guifont=InziuIosevkaSC\ 12
            elseif getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12
            elseif getfontname( 'DejaVu Sans Mono' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ 12
            else
                set guifont=Luxi\ Mono\ 12
            endif
        elseif g:ismac
            if getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h15
            elseif getfontname( 'DejaVu Sans Mono' ) != ''
                set guifont=DejaVu\ Sans\ Mono:h15
            endif
        endif
    endfunction
else
    if getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12
    endif
endif
" set ambiwidth=double
"}}}

" ==============================================================================
" 界面部分设置 {{{
" ==============================================================================
set novb
set matchtime=0 " 0 second to show the matching paren ( much faster )
set scrolloff=0 " minimal number of screen lines to keep above and below the cursor
set wrap " do not wrap text

set wildmenu " turn on wild menu, try typing :h and press <Tab>
set showcmd " display incomplete commands
set cmdheight=1 " 1 screen lines to use for the command-line
set ruler " show the cursor position all the time
" set hidden " allow to change buffer without saving
set shortmess=aoOtTI " shortens messages to avoid 'press a key' prompt
set lazyredraw " do not redraw while executing macros (much faster)
set display+=lastline " for easy browse last line with wrap text
set titlestring=%t\[%{expand(\"%:p:h\")}]

set showfulltag " show tag with function protype.

" 关闭光标闪烁
if g:isNvim
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                \,a:blinkwait700-blinkoff400-blinkon300-Cursor/lCursor
                \,sm:block-blinkwait400-blinkoff400-blinkon400
else
    if g:isGUI
        set guicursor&
        set guicursor+=a:blinkon0
    endif
endif

" 但是改变光标样式的时候会抖动
if has('autocmd') && g:isNvim==0
    " 主要解决genome终端下模式不同光标不同的情况
    " 如果你想要光标闪烁，则将下方的2改为1,6改为5,4改为3
    au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
    au InsertEnter,InsertChange *
                \ if v:insertmode == 'i' |
                \   silent execute '!echo -ne "\e[6 q"' | redraw! |
                \ elseif v:insertmode == 'r' |
                \   silent execute '!echo -ne "\e[4 q"' | redraw! |
                \ endif
    au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

" 状态栏设置
set laststatus=2 " always have status-line
if g:setting.status_line ==? 'no'  " 自定义状态栏{{{
    let s:currentmode={
                \ 'n':  {'text': 'NORMAL',  'termColor': 60, 'guiColor': '#076678'},
                \ 'v': {'text': 'VISUAL',  'termColor': 58, 'guiColor': '#D65D0E'},
                \ 'V': {'text': 'V-LINE',  'termColor': 58, 'guiColor': '#D65D0E'},
                \ '': {'text': 'V-BLOCK', 'termColor': 58, 'guiColor': '#D65D0E'},
                \ 'i': {'text': 'INSERT',  'termColor': 29, 'guiColor': '#8EC07C'},
                \ 'R': {'text': 'REPLACE', 'termColor': 88, 'guiColor': '#CC241D'},
                \ 's': {'text': 'SELECT',  'termColor': 58, 'guiColor': '#D65D0E'},
                \ 'S': {'text': 'S-LINE',  'termColor': 58, 'guiColor': '#D65D0E'},
                \ '': {'text': 'S-BLOCK', 'termColor': 58, 'guiColor': '#D65D0E'}
                \ }

    function! TextForCurrentMode()
        set lazyredraw
        if has_key(s:currentmode, mode())
            let modeMap = s:currentmode[mode()]
            execute 'hi! User1 ctermfg=255 ctermbg=' . modeMap['termColor'] . 'guifg=#EEEEEE guibg=' . modeMap['guiColor'] . ' cterm=none'
            return modeMap['text']
        else
            return 'UNKNOWN'
        endif
        set nolazyredraw
    endfunction

    function! BuildStatusLine(showMode)
        hi User1 ctermfg=236 ctermbg=101 guifg=#303030 guibg=#87875F cterm=reverse
        hi User7 ctermfg=88  ctermbg=236 guifg=#870000 guibg=#303030 cterm=none
        hi User8 ctermfg=236 ctermbg=101 guifg=#303030 guibg=#87875F cterm=reverse
        setl statusline=
        if a:showMode
            setl statusline+=%1*\ %{TextForCurrentMode()}\ "
        endif
        setl statusline+=%<                              " Truncate contents after when line too long
        " setl statusline+=%{&paste?'>\ PASTE':''}         " Alert when in paste mode
        setl statusline+=%8*[%n]\ %f                         " File path
        setl statusline+=%7*%m                          " File modified status
        setl statusline+=%r%h%w                          " Flags
        setl statusline+=%=                              " Right align the rest of the status line
        setl statusline+=%1*
        setl statusline+=\ %y                     " File type
        setl statusline+=\ [%03l/%04L:%03v]             " Cursor position in the file line, row
        " setl statusline+=%#warningmsg#                   " Highlights the syntastic errors in red
    endfunction

    au WinLeave * call BuildStatusLine(0)
    au WinEnter,VimEnter,BufWinEnter * call BuildStatusLine(1)
endif "}}}

" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI "{{{
    if g:iswindows
        au GUIEnter * simalt ~x " Maximize window when enter vim
        " set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
    else
        set lines=999 columns=999
    endif

    "present the bottom scrollbar when the longest visible line exceed the window
    set guioptions-=b
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    nnoremap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif "}}}

set nonumber
function! ToggleLineNumber() abort " 切换行号 {{{
    if (0 == &number) && (0 == &relativenumber)
        exec 'set number'
        exec 'set norelativenumber'
    elseif (0 == &relativenumber) && (1 == &number)
        exec 'set number'
        exec 'set relativenumber'
    else
        exec 'set nonumber'
        exec 'set norelativenumber'
    endif
endfunction " }}}
nnoremap <silent> <Leader>nc :call ToggleLineNumber()<CR>

" ==============================================================================
"  < vimtweak 工具配置 > 请确保以已装了工具
" ==============================================================================
" 这里只用于窗口透明与置顶
" 常规模式下 Ctrl + Up（上方向键） 增加不透明度，Ctrl + Down（下方向键） 减少不透明度
" <Leader>t 窗口置顶与否切换
if (g:iswindows && g:isGUI) " {{{
    let g:Current_Alpha = 230
    let g:Top_Most = 0
    call libcallnr("vimtweak.dll","SetAlpha", g:Current_Alpha)
    func! Alpha_add()
        let g:Current_Alpha = g:Current_Alpha + 10
        if g:Current_Alpha > 255
            let g:Current_Alpha = 255
        endif
        call libcallnr("vimtweak.dll","SetAlpha", g:Current_Alpha)
    endfunc
    func! Alpha_sub()
        let g:Current_Alpha = g:Current_Alpha - 10
        if g:Current_Alpha < 155
            let g:Current_Alpha = 155
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Top_window()
        if  g:Top_Most == 0
            call libcallnr("vimtweak.dll","EnableTopMost",1)
            let g:Top_Most = 1
        else
            call libcallnr("vimtweak.dll","EnableTopMost",0)
            let g:Top_Most = 0
        endif
    endfunc

    "快捷键设置
    noremap <c-up> :call Alpha_add()<CR>
    noremap <c-down> :call Alpha_sub()<CR>
endif "}}}

"}}}

" ==============================================================================
" Default colorscheme setup 颜色方案设置{{{
if !g:isGUI
    if has("termguicolors")
        set termguicolors
    endif
    set t_Co=256
endif
if strftime("%H") >= 15 || strftime("%H") <= 8
    set background=dark
else
    set background=light
endif
exec 'colorscheme ' . g:setting.color_scheme
" 切换背景色 {{{
function! ToggleBackground() abort
    let curr_back = &background
    if curr_back ==# 'dark'
        let curr_back = 'light'
    else
        let curr_back = 'dark'
    endif
    exec 'set background=' . curr_back
endfunction " }}}
nnoremap <Leader>bc :call ToggleBackground()<CR>
" }}}

" ==============================================================================
" 编辑相关设置(edit text setting, viminfo){{{
" ==============================================================================
set ttimeoutlen=50
set mouse=a " Disable mouse
set ai " autoindent
set si " smartindent
set backspace=indent,eol,start " allow backspacing over everything in insert mode
" indent options
" see help cinoptions-values for more details
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:0,=s,l0,b0,g0,hs,ps,ts,is,+s,c3,C0,0,(0,us,U0,w0,W0,m0,j0,)20,*30
" default '0{,0},0),:,0#,!^F,o,O,e' disable 0# for not ident preprocess
" set cinkeys=0{,0},0),:,!^F,o,O,e

" official diff settings
set diffexpr=g:MyDiff()
function! g:MyDiff()
    let opt = '-a --binary -w '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    silent execute '!' .  'diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
endfunction

set cindent shiftwidth=4 " set cindent on to autoinent when editing c/c++ file, with 4 shift width
set tabstop=4 " set tabstop to 4 characters
set expandtab " set expandtab on, the tab will be change to space automaticaly
set smarttab
set ve=block " in visual block mode, cursor can be positioned where there is no actual character

" set Number format to null(default is octal) , when press CTRL-A on number
" like 007, it would not become 010
set nf=

" set vim-clang preview buffer position
set splitbelow
set splitright

" ==============================================================================
" Desc: Fold text
" ==============================================================================
set foldenable                                        "启用折叠
set foldmethod=indent                                 "indent 折叠方式
set foldlevel=5
" set foldmethod=marker foldmarker={,} foldlevel=9999
" set foldmethod=syntax
set diffopt=filler,context:9999

" ==============================================================================
" 行列设置
"===============================================================================
set textwidth=100
set cc=+1       " 对齐线，当一行的长度大于80时显示一条竖线
" set cuc         " 高亮当前列
set cursorline  " 高亮当前行

" ==============================================================================
" 显示不可打印字符
"===============================================================================
" set list
" set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
" set listchars=tab:>-,trail:⋅,extends:>,precedes:<
set showbreak=↪
" For conceal markers.
if has("conceal")
    set conceallevel=0
    " set concealcursor=niv
    " set concealcursor=c
endif

" =============================================================================
" 行尾符设置
set fileformats=unix,dos

" ==============================================================================
" 过滤设置
"===============================================================================
" 不显示preview 窗口, 自动完成预览
set completeopt-=preview
" set completeopt+=noinsert
" set completeopt+=noselect
" set wildmode=list:longest,full
" set wildmenu "turn on wild menu
set wildignore=*.o,*.obj,*.exe,*~ "stuff to ignore when tab completing
set wildignore+=debug/**
set wildignore+=release/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=obj/**
set wildignore+=libs/**
set wildignore+=res/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.dll,*.a,*.swp,*.zip,*.pdf,*.dmg,*.bak,*.class,*.pyc
set wildignore+=.exvim/**,.settings/**,.metadata/**

" ==============================================================================
" viminfo设置
"===============================================================================
set viminfo='300,f1,<100,:20,@20,/20,
" }}}

" ==============================================================================
" 搜索(Search) {{{
" ==============================================================================
" There is a pause when leaving insert mode.
set showmatch " show matching paren
set incsearch " do incremental searching
set hlsearch " highlight search terms
set ignorecase " set search/replace pattern to ignore case
set smartcase " set smartcase mode on, If there is upper case character in the search patern, the 'ignorecase' option will be override.

" set this to use id-utils for global search
" set grepprg=ag\ --nogroup\ --nocolor
" set grepformat=%f:%l:%m

"}}}

" ==============================================================================
" Auto Command {{{
" ==============================================================================
" ------------------------------------------------------------------
" Desc: Only do this part when compiled with support for autocommands.
" ------------------------------------------------------------------
if has('autocmd')
    augroup ex
        au!

        " 在插入模式下, 一段时间没有按键,自动进入NORMAL
        " au CursorHoldI * stopinsert

        " ------------------------------------------------------------------
        " Desc: Buffer
        " ------------------------------------------------------------------

        " when editing a file, always jump to the last known cursor position.
        " don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        au BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
        " NOTE: ctags find the tags file from the current path instead of the path of currect file
        au BufNewFile,BufEnter * set cpoptions+=d

        " ------------------------------------------------------------------
        " this will avoid bug in my project with namespace ex,
        " the vim will tree ex:: as modeline.
        au FileType c,cpp,cs,swig set nomodeline

        " disable auto-comment for c/cpp, lua, javascript, c# and vim-script
        " au FileType c,cpp,java,javascript set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://
        " au FileType cs set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f:///,f://
        " au FileType vim set comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",f:\"
        au FileType vim set foldmethod=marker
        au FileType lua setlocal tabstop=2
        au FileType qml,python set foldmethod=indent
        au FileType c,cpp set foldmethod=indent
        au FileType help noremap <buffer> q :close<CR>
        au FileType dosbatch setlocal fileencoding=cp936
        " au FileType org setlocal tabstop=2
        au FileType java setlocal nolist

        " if edit python scripts, check if have \t.( python said: the programme can only
        " use \t or not, but can't use them together )
        au FileType python,coffee call s:check_if_expand_tab()
    augroup END

    function! s:check_if_expand_tab()
        let has_noexpandtab = search('^\t','wn')
        let has_expandtab = search('^    ','wn')
        if has_noexpandtab && has_expandtab
            let idx = inputlist ( ['ERROR: current file exists both expand and noexpand TAB, python can only use one of these two mode in one file.\nSelect Tab Expand Type:',
                        \ '1. expand (tab=space, recommended)',
                        \ '2. noexpand (tab=\t, currently have risk)',
                        \ '3. do nothing (I will handle it by myself)'])
            let tab_space = printf('%*s',&tabstop,'')
            if idx == 1
                let has_noexpandtab = 0
                let has_expandtab = 1
                silent exec '%s/\t/' . tab_space . '/g'
            elseif idx == 2
                let has_noexpandtab = 1
                let has_expandtab = 0
                silent exec '%s/' . tab_space . '/\t/g'
            else
                return
            endif
        endif

        "
        if has_noexpandtab == 1 && has_expandtab == 0
            echomsg 'substitute space to TAB...'
            set noexpandtab
            echomsg 'done!'
        elseif has_noexpandtab == 0 && has_expandtab == 1
            echomsg 'substitute TAB to space...'
            set expandtab
            echomsg 'done!'
        else
            " it may be a new file
            " we use original vim setting
        endif
    endfunction
endif
"}}}

" ==============================================================================
" neovim 特殊配置，vim与neovim终端配置 {{{
if g:isNvim
    let g:terminal_scrollback_buffer_size = 500

    " Use cursor shape feature
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

    " python设置
    let g:python_host_prog = '/usr/bin/python'
    " let g:loader_python_provider=0
    " let g:python_host_skip_check=1
    " python3 设置
    let g:python3_host_prog = '/usr/bin/python3'
    " let g:loaded_python3_provider = 1
    " let g:python3_host_skip_check = 0
    " 禁用ruby支持
    " let g:loaded_ruby_provider = 0

    " 搜索替换设置{{{
    if exists('&inccommand')
        set inccommand=nosplit
    endif
    " }}}

    "终端设置{{{
    nnoremap <Leader>tt :<C-u>terminal<CR>
    tnoremap <ESC> <C-\><C-n>
    augroup me_nvim
        autocmd BufEnter term://* startinsert
    augroup END
    " }}}
else
    "终端设置{{{
    nnoremap <Leader>tt :<C-u>term ++curwin ++close<CR>
    tnoremap <ESC> <C-W>N
    " }}}
endif
"}}}

" ==============================================================================
" Key Mappings 按键映射 {{{
" ==============================================================================
"===================================================
" 取消的系统按键 {{{
nnoremap q <Nop>
xnoremap q <Nop>
nnoremap ZZ <Nop>
" }}}

"===================================================
" 编码的快速转换, utf-8<->cp963; 行结束符格式的转换: dos<->unix{{{
function! QuickChangeFileencoding() abort
    let curencode = &fileencoding
    if curencode ==# 'cp936'
        execute 'set fileencoding=utf-8'
    elseif curencode ==# 'utf-8'
        execute 'set fileencoding=cp936'
    endif
endfunction
nnoremap <Leader>ec :call QuickChangeFileencoding()<CR>

function! QuickChangeFileformat() abort
    let curencode = &fileformat
    if curencode ==# 'dos'
        execute 'set fileformat=unix'
    elseif curencode ==# 'unix'
        execute 'set fileformat=dos'
    endif
endfunction
nnoremap <Leader>lc :call QuickChangeFileFormat()<CR>
"}}}

"===================================================
" 重定位输出map到文件
function! MapToFile()
    silent exe "redir>map.txt"
    silent exe "map"
    silent exe "redir end"
endfunction

" 重新映射leader键，default 为\
" let mapleader = ","
" 修改 :
nnoremap ; :

" 修改esc 键为jk
inoremap jk <ESC>

" 行首和行尾
" nnoremap <Home> ^
nnoremap 0 ^
nnoremap <End> $
vnoremap <Home> ^
vnoremap <End> $

" 结对符之间跳转，助记pair
nmap <Leader>pa %

" ==================================================
" redo
nnoremap U <c-r>

" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 替换当前当前光标下单词 {{{
nnoremap <Leader>pw :call ReplaceCurrentWord()<CR>
function! ReplaceCurrentWord() abort
    let curWord = expand("<cword>")
    call inputsave()
    let replaceWord = input("Please input wanted word:", curWord)
    call inputrestore()
    if curWord ==# replaceWord
        echo "They are same, no replace!"
        return
    endif

    let replaceStr = '%s/\<' . curWord . '\>/' . replaceWord . '/gc'
    execute replaceStr
endfunction " }}}

"===================================================
" 常规模式下输入 cS 清除行尾空格
" nmap CS :%s/\s\+$//g<CR>:noh<CR>
" 常规模式下输入 cM 清除行尾 ^M 符号
nmap CM :%s/\r$//g<CR>:noh<CR>
" tab 转空格(tab to space)
noremap <Leader>tts :%ret! 4<CR>

"===================================================
" 将当前光标下单词转换成大写
noremap <Leader>wu viwU

" 高亮当前光标下单词
" * #
" 取消当前高亮
noremap <Leader>nh :noh<cr>

" If you want n to always search forward and N backward, use this:
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" 命令行快捷键{{{
" 命令行历史窗口关闭
autocmd CmdwinEnter * noremap <buffer> q o<Esc><CR>
" 命令行下浏览历史
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>
" 左右移动光标
cnoremap <C-b>          <Left>
cnoremap <C-f>          <Right>
" 删除输入的字符
cnoremap <C-d>          <Del>
" 头尾
cnoremap <C-a>          <Home>
cnoremap <C-e>          <End>
" 粘贴
cnoremap <C-y>          <C-r>*
" <C-g>: 退出.
cnoremap <C-g>          <C-c>
" }}}

" 移动行(lu:上移, ld下移) (其他插件替代)
" nnoremap <Leader>ld  :<c-u>execute 'move +'. v:count1<cr>
" nnoremap <Leader>lu  :<c-u>execute 'move -1-'. v:count1<cr>
" 快速增加空行
nnoremap <Leader>us :put! =''<cr>
nnoremap <Leader>ds :put =''<cr>
" 快速增加空格
" nnoremap <Leader><space>  a<C-R>=" "<CR><ESC>
" nnoremap <Leader><space>  i<C-R>=" "<CR><ESC>
" 字体大小
" command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
" command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', ''

"===================================================
" 快速切换窗口
nnoremap <Leader>wk <C-W><Up>
nnoremap <Leader>wj <C-W><Down>
nnoremap <Leader>wh <C-W><Left>
nnoremap <Leader>wl <C-W><Right>
" 分割窗口(上, 下, 左, 右)
nnoremap <Leader>kw :<C-u>split<CR><C-W><Up>
nnoremap <Leader>jw :<C-u>split<CR>
nnoremap <Leader>hw :<C-u>vsplit<CR><C-W><Left>
nnoremap <Leader>lw :<C-u>vsplit<CR>
" 插入模式下的字符移动
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-n> <Left>
inoremap <M-m> <Right>
" 快速在行尾插入;
nnoremap <M-;>  A<C-R>=";"<CR><ESC>
" 在等号俩边快速插入空格

"===================================================
" 修改光标的快速上移或下移
" nnoremap J  10j

"===================================================
" 当前文件中搜索光标下单词
nnoremap <Leader>lv :lv /<C-r>=expand("<cword>")<CR>/ %<CR>:lw<CR>
" location-list快捷键设置
nnoremap <Leader>ll :lw<CR>
nnoremap <Leader>ln :lne<CR>
nnoremap <Leader>lp :lp<CR>
" quickfix快捷键设置
nnoremap <Leader>qw :cl<CR>
nnoremap <Leader>qp :cp<CR>
nnoremap <Leader>qn :cn<CR>
nnoremap <Leader>qm :ccN<CR>
" quickfix 定义快速关闭快捷键
autocmd FileType qf noremap <buffer> q :close<CR>

"===================================================
" 编辑vim配置文件，并重新读取配置文件
if g:iswindows
    nnoremap <Leader>ev :e $VIM\.vimrc<cr>
    exec 'nnoremap <Leader>evp :e $VIM\'.g:plugins_file.'<cr>'
    nnoremap <Leader>sv :source $MYVIMRC<cr>
else
    nnoremap <Leader>ev :e $MYVIMRC<cr>
    exec 'nnoremap <Leader>evp :e ~/'.g:plugins_file.'<cr>'
    nnoremap <Leader>sv :source $MYVIMRC<cr>
endif

"===================================================
" 保存文件设置
noremap  <Leader>wa :w<CR>
inoremap <Leader>wa <ESC>:w<CR>
vnoremap <Leader>wa <ESC>:w<CR>
noremap  <Leader>ws :wa<CR>
inoremap <Leader>ws <ESC>:wa<CR>
vnoremap <Leader>ws <ESC>:wa<CR>
if g:islinux
    nnoremap <Leader>rs :w !sudo tee>/dev/null %<CR>
endif
" 重命名文件
" 关闭当前窗口, 详细请看:help Close
noremap <Leader>mc :close<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

"===================================================
" 复制粘贴相关设置 {{{
" 命令行粘贴
cnoremap <c-g> <c-r>"
" 删除行不存入寄存器
nnoremap dl "_dd
" 删除单词不存入寄存器
nnoremap dc "_dw
" 删除单个不放入寄存器
nnoremap x "_x
" set paste
" define the copy/paste judged by clipboard
" set clipboard+=unnamed
if g:islinux
    if has('unnamedplus')
        set clipboard=unnamedplus
    else
        set clipboard+=unnamed
    endif
endif
" if has('unnamedplus')
" set clipboard+=unnamedplus
" endif
if &clipboard ==# 'unnamed'
    " fix the visual paste bug in vim
    " vnoremap <silent>p :call g:()<CR>
else
    " general copy/paste.
    " NOTE: y,p,P could be mapped by other key-mapping
    map <Leader>y "*y
    map <Leader>p "*p
    map <Leader>P "*P
endif

" copy folder path to clipboard, foo/bar/foobar.c => foo/bar/
nnoremap <silent> <Leader>y1 :let @*=fnamemodify(bufname('%'),":p:h")<CR>

" copy file name to clipboard, foo/bar/foobar.c => foobar.c
nnoremap <silent> <Leader>y2 :let @*=fnamemodify(bufname('%'),":p:t")<CR>

" copy full path to clipboard, foo/bar/foobar.c => foo/bar/foobar.c
nnoremap <silent> <Leader>y3 :let @*=fnamemodify(bufname('%'),":p")<CR>
"}}}

" F8 or <Leader>/:  Set Search pattern highlight on/off
nnoremap <F8> :let @/=""<CR>
nnoremap <Leader>/ :let @/=""<CR>
" DISABLE: though nohlsearch is standard way in Vim, but it will not erase the
"          search pattern, which is not so good when use it with exVim's <Leader>r
"          filter method
" nnoremap <F8> :nohlsearch<CR>
" nnoremap <Leader>/ :nohlsearch<CR>

" easy diff goto
noremap <C-k> [c
noremap <C-j> ]c

" enhance '<' '>' , do not need to reselect the block after shift it.
vnoremap < <gv
vnoremap > >gv

" map Up & Down to gj & gk, helpful for wrap text edit
noremap <Up> gk
noremap <Down> gj

" TODO: I should write a better one, make it as plugin exvim/swapword
" VimTip 329: A map for swapping words
" http://vim.sourceforge.net/tip_view.php?tip_id=
" Then when you put the cursor on or in a word, press "\sw", and
" the word will be swapped with the next word.  The words may
" even be separated by punctuation (such as "abc = def").
nnoremap <silent> <Leader>ltr "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o>

"}}}

" vim:ts=4:sw=4:sts=4 et fdm=marker:
