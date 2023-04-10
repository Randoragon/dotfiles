set shiftwidth=4 tabstop=4

command LSPFileToggleCSS    lua require('lsp').toggle({
            \   name = 'vscode-css-languageserver',
            \   cmd  = {'vscode-css-languageserver', '--stdio'},
            \   settings = require('lsp.settings.vscode-css-languageserver'),
            \ })
command LSPProjectToggleCSS lua require('lsp').toggle({
            \   name = 'vscode-css-languageserver',
            \   cmd  = {'vscode-css-languageserver', '--stdio'},
            \   settings = require('lsp.settings.vscode-css-languageserver'),
            \ },
            \ {
            \  '.git',
            \  'index.html',
            \  'Makefile', 'makefile', 'GNUmakefile',
            \  'CMakeLists.txt'
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleCSS<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleCSS<CR>
