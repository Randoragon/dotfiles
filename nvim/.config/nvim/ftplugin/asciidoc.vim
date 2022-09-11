" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun asciidoctor -r asciidoctor-diagram -a 'imagesdir=%:p:h' -o "${XDG_CACHE_HOME:-~/.cache}/vim-preview.html" -- "%:p" && pkill -HUP surf<CR>
nnoremap <buffer> <Leader>p :AsyncRun setsid surf -S -- file://"${XDG_CACHE_HOME:-~/.cache}/vim-preview.html"<CR>

" Embed screenshots
nnoremap <buffer> <Leader>is :call sshot#ImportScreenshot(function('sshot#AsciidocScreenshot'), '.png')<CR>

inoremap <buffer> <Leader>ul [.underline]##<Left>
inoremap <buffer> <Leader>ol [.overline]##<Left>
inoremap <buffer> <Leader>lt [.line-through]##<Left>

inoremap <buffer> <Leader>sb ****<CR>****<C-o>O
inoremap <buffer> <Leader>eb ====<CR>====<C-o>O
inoremap <buffer> <Leader>qb ----<CR>----<C-o>O
inoremap <buffer> <Leader>ob --<CR>--<C-o>O
inoremap <buffer> <Leader>pb ++++<CR>++++<C-o>O
inoremap <buffer> <Leader>tt \|===<CR>\|===<C-o>O
inoremap <buffer> <Leader>t, ,===<CR>,===<C-o>O
inoremap <buffer> <Leader>t: :===<CR>:===<C-o>O
