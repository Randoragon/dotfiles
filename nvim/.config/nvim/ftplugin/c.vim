inoremap <buffer> <Leader>I #include 
inoremap <buffer> <Leader>t static 
inoremap <buffer> <Leader>c const 
inoremap <buffer> <Leader>.c /*  */<Left><Left><Left>
inoremap <buffer> <Leader>s struct 
inoremap <buffer> <Leader>u unsigned 
inoremap <buffer> <Leader>z size_t 
inoremap <buffer> <Leader>.z sizeof()<Left>
inoremap <buffer> <Leader>.s switch () <,,><C-o>F)
inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if () <,,><C-o>F)
inoremap <buffer> <Leader>e else 
inoremap <buffer> <Leader>o else if () <,,><C-o>F)
inoremap <buffer> <Leader>f for () <,,><C-o>F)
inoremap <buffer> <Leader>w while () <,,><C-o>F)
inoremap <buffer> <Leader>mm malloc()<Left>
inoremap <buffer> <Leader>mc calloc()<Left>
inoremap <buffer> <Leader>mr realloc()<Left>
inoremap <buffer> <Leader>mf free();<Left><Left>

command LSPFileToggleC    lua require('lsp').toggle({
            \   name = 'ccls',
            \   cmd  = {'ccls'},
            \   settings = require('lsp.settings.ccls'),
            \ })
command LSPProjectToggleC lua require('lsp').toggle({
            \   name = 'ccls',
            \   cmd  = {'ccls'},
            \   settings = require('lsp.settings.ccls'),
            \ },
            \ {
            \  '.git',
            \  'Makefile', 'makefile', 'GNUmakefile',
            \  'CMakeLists.txt'
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleC<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleC<CR>
