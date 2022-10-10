"LINUX VIMRC

" Basic Settings {{{1
set nowrap
set number
set cursorline
set mouse=a
let mapleader=','
nnoremap \ ,
nnoremap <Leader>w :set wrap! linebreak!<CR>
map Y y$
set hidden
nnoremap c "_c
vnoremap . :normal .<CR>
nnoremap <Leader>/ :nohlsearch<CR>
filetype plugin indent on
set encoding=utf-8
set listchars=tab:\ \ ┊,trail:·,nbsp:·
set list
" }}}

" Plugins {{{1
lua << EOF

require 'paq' {
    'airblade/vim-gitgutter';
    'junegunn/fzf.vim';
    'tpope/vim-surround';
    'tpope/vim-speeddating';
    'tpope/vim-repeat';
    'tpope/vim-abolish';
    'tpope/vim-commentary';
    'glts/vim-radical';
    'glts/vim-magnum';
    'dense-analysis/ale';
    'nanotech/jellybeans.vim';
    'jiangmiao/auto-pairs';
    'godlygeek/tabular';
    'skywind3000/asyncrun.vim';
    'derekwyatt/vim-fswitch';
    'Shougo/deoplete.nvim';
    'Shougo/deoplete-clangx';
    'ap/vim-css-color';
    'psliwka/vim-smoothie';
    'lervag/vimtex';
}

EOF

" netrw (tree view) settings {{{2
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
let g:netrw_preview = 1
nmap <silent> <Leader>t :Lex!<CR>
" }}}

" AutoPairs {{{2
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutToggle = '<Leader>)'
let g:AutoPairsShortcutBackInsert = '<Leader><Backspace>'
" }}}

" GitGutter {{{2
let g:gitgutter_map_keys = 0
nnoremap ]g :GitGutterNextHunk<CR>
nnoremap [g :GitGutterPrevHunk<CR>
nnoremap <Leader>gp :GitGutterPreviewHunk<CR>
nnoremap <Leader>gl :GitGutterLineHighlightsToggle<CR>
nnoremap <Leader>gu :GitGutterUndoHunk<CR>
" }}}

" Tabular keyboard shortcuts {{{2
vnoremap <Leader>t= :Tabular/=<CR>
vnoremap <Leader>t- :Tabular/-<CR>
vnoremap <Leader>t+ :Tabular/+<CR>
vnoremap <Leader>t< :Tabular/<<CR>
vnoremap <Leader>t> :Tabular/><CR>
vnoremap <Leader>t, :Tabular/,/l0r1<CR>
vnoremap <Leader>t; :Tabular/;/l0r1<CR>
" }}}

" ALE & Deoplete {{{2
let g:ale_enabled = 0
let g:deoplete#enable_at_startup = 0
" Close Deoplete preview window after completion
" https://github.com/Shougo/deoplete.nvim/issues/115
autocmd InsertLeave * if pumvisible() == 0 | silent! pclose | endif
nnoremap <Leader>a :ALEToggle<CR>:call deoplete#toggle()<CR>
nnoremap <Leader>e :ALEDetail<CR>
nnoremap ]a :ALENextWrap<CR>
nnoremap [a :ALEPreviousWrap<CR>
" }}} 

" FZF {{{2
nnoremap <C-Space>  :GFiles<CR>
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fl :Lines<CR>
nnoremap <Leader>fc :Commands<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <Leader>fm :Marks<CR>
nnoremap <Leader>fh :Helptags<CR>
nnoremap <Leader>fa :Ag<CR>
nnoremap <Leader>fb :Buffers<CR>
" }}}

" Smoothie {{{2
let g:smoothie_enabled = getenv("NVIM_SMOOTHIE_ENABLED")
if g:smoothie_enabled == v:null | let g:smoothie_enabled = 1 | endif
function! ToggleVimSmoothie()
    if g:smoothie_enabled
        let g:smoothie_enabled = 0
    else
        let g:smoothie_enabled = 1
    endif
endfunction
nnoremap <Leader>S :call ToggleVimSmoothie()<CR>
" }}}

" VimTex {{{2
" I use this plugin mostly for its motions and surround.vim-like support,
" so the majority of everything else can go.
let g:vimtex_compiler_enabled = 0
let g:vimtex_complete_enabled = 0
let g:vimtex_disable_recursive_main_file_detection = 1
let g:vimtex_format_enables = 1
let g:vimtex_quickfix_enabled = 0
let g:vimtex_quickfix_blgparser = {'disable': 1}
let g:vimtex_syntax_conceal_disable = 1
let g:vimtex_view_enabled = 0
let g:vimtex_toc_config = {'layers': ['content', 'todo']}

" surround.vim custom commands
augroup latex_surround_cmds
    autocmd!
    autocmd FileType tex let b:surround_105 = "\\emph{\r}"
    autocmd FileType tex let b:surround_98 = "\\textbf{\r}"
    autocmd FileType tex let b:surround_117 = "\\underline{\r}"
    autocmd FileType tex let b:surround_99 = "\\mintinline{\1syntax: \1}{\r}"
    autocmd FileType tex let b:surround_118 = "\\texttt{\r}"
    autocmd FileType tex let b:surround_120 = "\\\1command: \1{\r}"
augroup END
" }}}

" }}}

" Status Bar{{{1
" https://jdhao.github.io/2019/11/03/vim_custom_statusline/
" https://shapeshed.com/vim-statuslines/

set statusline=
set statusline+=%#PmenuSel#\ %n\                           " Buffer number
set statusline+=%#Visual#\ %F\                             " File path
set statusline+=%#WarningMsg#%h%m%r                        " {help, modified, readonly} flags
set statusline+=%#CursorColumn#%=                          " Align the rest to the right
set statusline+=%#Conceal#%y\                              " File type
set statusline+=%{&fileencoding?&fileencoding:&encoding}\  " File encoding
set statusline+=%#MsgArea#\ \ %v:%l/%L\ (%p%%)\            " Position in file
set statusline+=\ 

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

" Spell-check settings {{{1
set spelllang=en_us
nnoremap <Leader>s :set spell!<CR>
" }}}

" Indentation settings {{{1
function! ToggleIndentStyle()
    if &expandtab
        " 8-character wide tabs
        set noexpandtab
        set shiftwidth=8
        set tabstop=8
        set softtabstop=0
    else
        " 4-character wide spaces
        set expandtab
        set shiftwidth=4
        set tabstop=4
        set softtabstop=4
    endif
endfunction
nnoremap <Leader>T :call ToggleIndentStyle()<CR>

set expandtab
call ToggleIndentStyle()

" For markdown folding, src: https://stackoverflow.com/a/4677454 (comments) {{{2
function MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+')
    if empty(h)
        return "="
    else
        return ">" . len(h)
    endif
endfunction

nnoremap <M-i> zA
nnoremap <M-I> za
nnoremap <M-m> zM
nnoremap <M-r> zR
" }}}

augroup fold_switch
    autocmd!
    autocmd! BufNewFile,BufRead * :normal zR
    autocmd! BufNewFile,BufRead .vimrc,init.vim     setlocal foldmethod=marker foldlevel=0
    autocmd! BufNewFile,BufRead *.c,*.h,*.cpp,*.hpp setlocal foldmethod=indent | :normal zR
    autocmd! BufNewFile,BufRead *.py      setlocal foldmethod=indent | :normal zR
    autocmd! BufNewFile,BufRead *.md,*.MD setlocal foldmethod=expr foldexpr=MarkdownLevel() foldnestmax=3 foldlevel=1
augroup END

" }}}

" New file templates {{{1
function TryLoadTemplate()
    let fpath = $HOME."/.config/nvim/templates/".&filetype
    echo l:fpath
    if filereadable(fpath)
        call setline(1, readfile(l:fpath))

        let datestr = strftime('%A, %B %e, %Y')
        let l = 1
        for line in getline(1, '$')
            " Substitute <DATE> with the current date
            call setline(l:l, substitute(l:line, '\C<DATE>', l:datestr, 'g'))
            let l = l:l + 1
        endfor

        " Place cursor in the spot indicated by <START>
        call searchpos('\C<START>')
        norm "_df>
    endif
endfunction
augroup new_file_templates
    autocmd!
    autocmd! BufNewFile * call TryLoadTemplate()
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

nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>
nnoremap g[t :-tabmove<CR>
nnoremap g]t :+tabmove<CR>
" }}}

" Copy shortcuts {{{1
nnoremap <M-a> :%y+<CR>
vnoremap <M-a> "+y
inoremap <M-a> <ESC>:%y+<CR>a
" }}}

" Insert Mode Shortcuts {{{1

" Shell or Emacs-like shortcuts
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-y> <C-o>P

" Paste current date
inoremap <C-d> <C-r>=strftime('%a %Y-%m-%d')<CR>
inoremap <Leader><C-d> <C-r>=strftime('%Y-%m-%d')<CR>
inoremap <Leader>.<C-d> <C-r>=strftime('%A, %B %e, %Y')<CR>
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
" Make background transparent on any colorscheme, embolden current line number
function TransparentBG()
    highlight Normal     guibg=NONE ctermbg=NONE
    highlight Title      guibg=NONE ctermbg=NONE
    highlight LineNr     guibg=NONE ctermbg=NONE
    highlight Folded     guibg=NONE ctermbg=NONE
    highlight NonText    guibg=NONE ctermbg=NONE
    highlight FoldColumn guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE ctermbg=NONE
    highlight CursorLine guibg=NONE ctermbg=NONE
endfunction
autocmd VimEnter,ColorScheme * call TransparentBG()
" }}}

" Searching configuration {{{1
set wildmenu
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.git/*,*.tags,*.o
cnoremap <expr> / wildmenumode() ? "\<C-E>" : "/"
set path+=** " Enables recursive :find
" }}}

" Reload vimrc {{{1
nnoremap <Leader>r :source $XDG_CONFIG_HOME/nvim/init.vim<CR>
" }}}

"{{{1 Center screen after search
nnoremap n nzz
nnoremap N Nzz
"1}}}

"{{{1 Automatically enter insert mode when starting a terminal in NeoVim
"https://github.com/neovim/neovim/issues/8816#issuecomment-410512452
if has('nvim')
    autocmd TermOpen term://* startinsert
endif
"}}}

"{{{1 Provide EnterFileMode function for scripts
function! EnterFileMode(filetype)
    let &filetype = a:filetype
    nnoremap <buffer> <Leader><Leader> :set filetype=asciidoc<CR>
                \:nunmap <buffer> <Leader><Leader><CR>
                \:echo<CR>
    echo "Entered ".a:filetype." mode. Press <Leader> twice to exit."
endfunction
"}}}
