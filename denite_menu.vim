" vim 配置
let g:denite_menus.vim = {
            \ 'description' : 'vim configure files',
            \ }

if g:iswindows
    let g:denite_menus.vim.file_candidates = [
                \ ['vimrc', $VIM.'/.vimrc'],
                \ ['commonPlug', $VIM.'/.vimrc.vimplug'],
                \ ['unit.vim and denite.nvim', $VIM.'/.vimrc.unitvim'],
                \ ['complete', $VIM.'/.vimrc.complete'],
                \ ['language', $VIM.'/.vimrc.language'],
                \ ['ctrlp', $VIM.'/.vimrc.ctrlp'],
                \ ['discard', $VIM.'/.vimrc.discard']
                \ ]
else
    let g:denite_menus.vim.file_candidates = [
                \ ['vimrc', '~/.vimrc'],
                \ ['commonPlug', '~/.vimrc.vimplug'],
                \ ['unit.vim and denite.nvim', '~/.vimrc.unitvim'],
                \ ['complete', '~/.vimrc.complete'],
                \ ['language', '~/.vimrc.language'],
                \ ['ctrlp', '~/.vimrc.ctrlp'],
                \ ['discard', '~/.vimrc.discard']
                \ ]
endif

" map 查询
let g:denite_menus.mymap = {
            \ 'description' : 'map information'
            \ }
let g:denite_menus.mymap.command_candidates = [
            \ ["\\.",   "<Plug>(easymotion-repeat)"],
            \ ["\\s",   "<Plug>(easymotion-lineanywhere)"],
            \ ["\\w",   "<Plug>(easymotion-jumptoanywhere)"],
            \ ["\\h",   "<Plug>(easymotion-linebackward)"],
            \ ["\\l",   "<Plug>(easymotion-lineforward)"],
            \ ["\\k",   "<Plug>(easymotion-k)"],
            \ ["\\j",   "<Plug>(easymotion-j)"],
            \ ["o:\\/", "<Plug>(easymotion-tn)"],
            \ ["nv:\\/","<Plug>(easymotion-sn)"]
            \ ]

" vim:ts=4:sw=4:sts=4 et fdm=indent:
