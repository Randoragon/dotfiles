"LINUX VIMRC

" Basic Settings {{{1
set nowrap
set number
set path+=** " Enables recursive :find
set mouse=a
let mapleader=','
nnoremap \ ,
nnoremap <Leader>w :set wrap! linebreak!<CR>
map Y y$
set hidden
" }}}

" Plugins {{{1
call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'glts/vim-radical'
Plug 'glts/vim-magnum'
Plug 'dense-analysis/ale'
Plug 'nanotech/jellybeans.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'skywind3000/asyncrun.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-clangx'
Plug 'psliwka/vim-smoothie'
Plug 'ap/vim-css-color'
Plug 'junegunn/goyo.vim'
call plug#end()

" Airline {{{2
let g:airline_detect_spell = 0
let g:airline_detect_spellang = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
" }}} 

" AutoPairs {{{2
let g:AutoPairsFlyMode = 1
" }}}

" GitGutter {{{2
nnoremap <Leader>; :GitGutterNextHunk<CR>
nnoremap <Leader>\ :GitGutterPrevHunk<CR>
" }}}

" Tabular keyboard shortcuts {{{2
vnoremap <Leader>t= :Tabular/=<CR>
vnoremap <Leader>t, :Tabular/,/l0r1<CR>
vnoremap <Leader>t; :Tabular/;/l0r1<CR>
" }}}

" ALE {{{2
nnoremap <Leader>e :ALEDetail<CR>
nnoremap <Leader>a :ALEToggle<CR>
nnoremap <Leader>n :ALENextWrap<CR>
nnoremap <Leader>N :ALEPreviousWrap<CR>
" }}} 

" Auto Pairs {{{2
let g:AutoPairsShortcutToggle='<Leader>0'
" }}}

" FZF {{{2
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fl :Lines<CR>
nnoremap <Leader>fc :Commands<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <Leader>fm :Marks<CR>
nnoremap <Leader>fh :Helptags<CR>
nnoremap <Leader>fa :Ag<CR>
nnoremap <Leader>fb :Buffers<CR>
" }}}

" {{{2 Deoplete
let g:deoplete#enable_at_startup = 1
" }}}

" {{{2 Goyo
nnoremap <Leader>g :Goyo<CR>
" }}}

" }}}

" Clipboard Integration {{{1
let g:clipboard = {
 \    'name': 'xclip',
 \    'copy': {
 \        '+': 'xclip -selection clipboard',
 \        '*': 'xclip -selection clipboard'
 \    },
 \    'paste': {
 \        '+': 'xclip -selection clipboard -o',
 \        '*': 'xclip -o'
 \    },
 \    'cache_enabled': 1,
 \ }
" }}}

" Indentation settings {{{1
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
" }}}

" File type detection settings {{{1
augroup filetype_detect
    autocmd! BufEnter *.MD :set filetype=markdown
augroup END
" }}}

" Fold settings {{{1
set foldmethod=manual

" For markdown folding, src: https://stackoverflow.com/a/4677454 (comments) {{{2
function MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+')
    if empty(h)
        return "="
    else
        return ">" .  len(h)
    endif
endfunction
" }}}

augroup fold_switch
    autocmd!
    autocmd BufWinEnter * :normal zR
    autocmd! BufWinEnter .vimrc,init.vim     setlocal foldmethod=marker foldlevel=0
    autocmd! BufWinEnter *.c,*.h,*.cpp,*.hpp setlocal foldmethod=syntax | :normal zR
    autocmd! BufWinEnter *.py      setlocal foldmethod=indent | :normal zR
    autocmd! BufWinEnter *.md,*.MD setlocal foldmethod=expr foldexpr=MarkdownLevel() foldnestmax=3 foldlevel=1
augroup END
" }}}

" FSwitch settings {{{1
augroup file_switch
    autocmd! BufEnter *.cpp let b:fswitchdst = 'hpp,h' | let b:fswitchlocs = '.'
    autocmd! BufEnter *.c   let b:fswitchdst = 'h'     | let b:fswitchlocs = '.'
augroup END
nnoremap <C-s> :FSHere<CR>
" }}}

" Searching {{{1
set ignorecase
set smartcase
" }}}

" Binary file editing {{{1
" requires xxd, on Arch install xxd-standalone from AUR

" Open *.bin files in binary mode
augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

" Convert to and from hexdump
nnoremap <Leader>d :%!xxd<CR>:set filetype=xxd<CR>
nnoremap <Leader>D :%!xxd -r<CR>:filetype detect<CR>
" }}}

" Window Shortcuts {{{1
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Bar> <C-w><Bar>
nnoremap _ <C-w>_
nnoremap <C-w>x :Bclose<CR>
set splitbelow
set splitright

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bNext<CR>

nnoremap <S-h> :tabprevious<CR>
nnoremap <S-l> :tabnext<CR>
nnoremap g<S-h> :-tabmove<CR>
nnoremap g<S-l> :+tabmove<CR>

nnoremap gt <S-h>
nnoremap gT <S-l>
" }}}

" Copy shortcuts {{{1
nnoremap <M-a> :%y+<CR>
vnoremap <M-a> "+y
inoremap <M-a> <ESC>:%y+<CR>a
" }}}

" Insert Mode Shortcuts {{{1

" Shell or Emacs-like navigation
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-k> <Esc>lC
inoremap <C-u> <Esc>d0xi
inoremap <C-y> <Esc>Pa

" Paste current datetime
inoremap <C-d> <C-r>=strftime('%a %Y-%m-%d %H:%M %Z')<CR>
" }}}

" Backup directories {{{1
set backup
set writebackup
set backupdir=~/.local/share/nvim/backup/
" }}}

" Force redraw shortcut {{{1
nnoremap <Leader>l :redraw!<CR>
" }}}

" Make motions more wrap-friendly {{{1
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
" }}}

" Markdown Preview config {{{1
function PreviewMarkdown()
    write
	AsyncRun mdtopdf "%:p" "/tmp/vim_preview.pdf"
endfunction
nnoremap <Leader>pm :call PreviewMarkdown()<CR>
nnoremap <Leader>po :AsyncRun setsid xdg-open /tmp/vim_preview.pdf<CR>
" }}}

" netrw (tree view) settings {{{1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
let g:netrw_preview = 1
nmap <silent> <Leader>t :Lex!<CR>

" Suppress some netrw maps
" (Source: https://stackoverflow.com/questions/34136749/remove-netrw-s-up-and-s-down-mapping-in-vim)
augroup netrw_maps
  autocmd!
  autocmd filetype netrw call ApplyNetrwMaps()
augroup END

function ApplyNetrwMaps()
    nnoremap <buffer> <C-h> <C-w>h
    nnoremap <buffer> <C-j> <C-w>j
    nnoremap <buffer> <C-k> <C-w>k
    nnoremap <buffer> <C-l> <C-w>l
endfunction
" }}}

" Enable 256 color support, set colorscheme {{{1
syntax enable
let g:palenight_terminal_italics = 1
let g:jellybeans_use_term_italics = 1
let g:badwolf_darkgutter = 1
if $DISPLAY != ""
    set termguicolors
    set background=dark
    colorscheme jellybeans
    if &term =~ '256color'
        " Disable background color erase (BCE) so that color schemes
        " work properly when Vim is used inside tmux and GNU screen
        set t_ut=
    endif
else
    " fallback colorscheme for TTY
    colorscheme ron
endif
" }}}
