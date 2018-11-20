call LoadConfig('vimrc.deoplete')
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.cpp = '[^. *\t]\.\w*|[^. *\t]\::\w*|[^. *\t]\->\w*|#include\s*[<"][^>"]*'
let g:deoplete#omni#functions={}
let g:deoplete#omni#functions.cpp = ['LanguageClient#complete']

Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'}

let g:LanguageClient_serverCommands = {
    \ 'c': ['ccls', '--log-file=/home/dasea/.vim/tmp/cc.log'],
    \ 'cpp': ['ccls', '--log-file=/home/dasea/.vim/tmp/cc.log'],
    \ 'cuda': ['ccls', '--log-file=/home/dasea/.vim/tmp/cc.log'],
    \ 'objc': ['ccls', '--log-file=/home/dasea/.vim/tmp/cc.log'],
    \ }

let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = '/home/dasea/.config/nvim/settings.json'
" https://github.com/autozimu/LanguageClient-neovim/issues/379 LSP snippet is not supported
let g:LanguageClient_hasSnippetSupport = 0
let g:LanguageClient_serverStderr = '/home/dasea/.vim/tmp/clangd.stderr'
let g:LanguageClient_diagnosticsSignsMax=50

nn <silent> <M-j> :call LanguageClient#textDocument_definition()<cr>
nn <silent> <C-,> :call LanguageClient#textDocument_references({'includeDeclaration': v:false})<cr>
nn <silent> K :call LanguageClient#textDocument_hover()<cr>

" textDocument/documentHighlight
augroup LanguageClient_config
  au!
  au BufEnter * let b:Plugin_LanguageClient_started = 0
  au User LanguageClientStarted setl signcolumn=yes
  au User LanguageClientStarted let b:Plugin_LanguageClient_started = 1
  au User LanguageClientStopped setl signcolumn=auto
  au User LanguageClientStopped let b:Plugin_LanguageClient_stopped = 0
  au CursorMoved * if b:Plugin_LanguageClient_started | sil call LanguageClient#textDocument_documentHighlight() | endif
augroup END

" $ccls/navigate
" Semantic navigation. Roughly,
" D => first child declaration; L=> previous declaration R => next declaration U => parent declaration
nn <silent> xh :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'L'})<cr>
nn <silent> xj :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'D'})<cr>
nn <silent> xk :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'U'})<cr>
nn <silent> xl :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'R'})<cr>

" bases
nn <silent> xb :call LanguageClient#findLocations({'method':'$ccls/inheritance'})<cr>
" bases of up to 3 levels
nn <silent> xB :call LanguageClient#findLocations({'method':'$ccls/inheritance','levels':3})<cr>
" derived
nn <silent> xd :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true})<cr>
" derived of up to 3 levels
nn <silent> xD :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true,'levels':3})<cr>

" caller
nn <silent> xc :call LanguageClient#findLocations({'method':'$ccls/call'})<cr>
" callee
nn <silent> xC :call LanguageClient#findLocations({'method':'$ccls/call','callee':v:true})<cr>

" $ccls/member
" nested classes / types in a namespace
nn <silent> xs :call LanguageClient#findLocations({'method':'$ccls/member','kind':2})<cr>
" member functions / functions in a namespace
nn <silent> xf :call LanguageClient#findLocations({'method':'$ccls/member','kind':3})<cr>
" member variables / variables in a namespace
nn <silent> xm :call LanguageClient#findLocations({'method':'$ccls/member'})<cr>

nn xx x

if 0
    " if use clangd, use this
    let g:LanguageClient_serverCommands = {
                \ 'python': ['/usr/local/bin/pyls'],
                \ 'cpp': ['/usr/bin/clangd'],
                \ 'c': ['/usr/bin/clangd']
                \ }
    augroup LanguageClient_config
        autocmd!
        autocmd User LanguageClientStarted setlocal signcolumn=yes
        autocmd User LanguageClientStopped setlocal signcolumn=auto
    augroup END

    function SetLSPShortcuts()
        nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
        nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
        nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
        nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
        nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
        nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
        nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
        nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
        nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
        nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
    endfunction()

    " Or map each action separately
    " nnoremap <F5> :call LanguageClient_contextMenu()<CR>
    " nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
    " nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    " nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
endif

call LoadConfig('vimrc.lsp.language')

" vim:ts=4:sw=4:sts=4 et fdm=marker:
