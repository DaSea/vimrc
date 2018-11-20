" linux {{{
if g:islinux
    " 退出插入模式的时候自动进入英文状态，但是重新进入插入模式时会返回中文状态
    " Plug 'h-youhei/vim-fcitx'

    " 自己写的用于控制音乐切换的小插件 {{{
    Plug 'DaSea/SimpleMusicCtrl.vim'
    " SMCNext SMCPlay SMCPrev
    " }}}
endif
" }}}
"
" windows {{{
if g:iswindows
endif
" }}}

" vim:ts=4:sw=4:sts=4 et fdm=marker:
