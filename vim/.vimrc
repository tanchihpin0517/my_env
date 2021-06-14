let g:python3_host_prog = expand('~/.local/bin/python3')
"let g:python3_host_prog = substitute(system('which python3'), '\n\+$', '', '')
let g:loaded_python_provider = 0

"============================= Vim-Plug ====================================="
set nocompatible
if has('nvim')
    call plug#begin(stdpath('data') . '/plugged')
else
    call plug#begin('~/.vim/plugged')
endif
Plug 'sheerun/vim-polyglot'         " A collection of language packs
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-expand-region'
"Plug 'majutsushi/tagbar'
"Plug 'ludovicchabant/vim-gutentags' " Management of tags files
Plug 'joshdick/onedark.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-repeat'
Plug 'yggdroot/indentline'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'skywind3000/vim-quickui'
Plug 'tmhedberg/SimpylFold'
call plug#end()

"============================= General ======================================"
if has("termguicolors")
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
    set termguicolors
endif
syntax on
filetype plugin indent on
set encoding=utf-8
set fileencodings=utf-8,big5,cp950,latin1
set fileencoding=utf-8
set nocompatible    "avoid using compatible mode of vi
set ai              "auto indent
set shiftwidth=4    "set the number of character while using >> to move whole line
set softtabstop=4   "set the number of spaces as replacing tab
set expandtab       "replace tab with space (type :retab to replace all tab in the file)
set ruler           "show setting at right button below
set number          "show the number of line
set relativenumber
set wrap            "only change line when meeting space
set linebreak
set backspace=2     "use backspace on insert mode
set ignorecase      "ignore upper or lower case in search
set smartcase
set hlsearch        "highlight the result of search
set incsearch       "show the result of search before type total key word
set smartindent     "set smart indent
set confirm         "confirm when conflict occurs
set history=100     "save 100 command
set cursorline      "show the position of cursor
set cursorcolumn
set modeline        "enable modeline
set laststatus=2    "display status line always
set statusline=%m%r%<[%F]%<[%Y,%{&fileencoding}]%=%c(%v),%l/%L,%p%%
set formatoptions+=croqnl1j
set showmatch
set matchpairs+=<:>
set pastetoggle=<F9>
set tags+=tags;
set timeout
set timeoutlen=10000  "timeout for mappings (ms)
set ttimeout
set ttimeoutlen=10  "timeout for key codes
set foldmethod=indent
set foldlevel=99
set hidden "coc
if !has('nvim')
    for key in ['h', 'j', 'k', 'l', 'f', 'b', 'w']
        exec "set <M-".key.">=\e".key
    endfor
endif

"============================= Variables ===================================="
let move_interval=4         | let mi=move_interval
let temp_register="t"       | let tr=temp_register
let temp_mark="t"           | let tm=temp_mark
let mode_switch_mark="m"    | let msm=mode_switch_mark

"============================= Key Maps ====================================="
"============================= normal ======================================="
let mapleader = "\<Space>" "for <leader>
nnoremap        ? :let @/ = ""<CR>
nnoremap <silent> <leader>6 :TagbarToggle<CR>
nnoremap <expr> > "m".tm.">>`".tm.&sw."l"
nnoremap <expr> < "m".tm."<<`".tm.&sw."h"
nnoremap        * *``
nnoremap        `i `^
" nnoremap <expr> <C-j> mi."<C-e>".mi."j"
" nnoremap <expr> <C-k> mi."<C-y>".mi."k"
nnoremap <expr> i "m".msm."i"
nnoremap <expr> c "m".msm."c"
nnoremap <expr> v "m".msm."v"
nnoremap <expr> <C-j> mi."j"
nnoremap <expr> <C-k> mi."k"
nnoremap <expr> <C-h> mi."h"
nnoremap <expr> <C-l> mi."l"
nnoremap        q: :q
nnoremap        <leader>q :q<CR>
nnoremap        : :set norelativenumber<CR>:
nnoremap        / :set norelativenumber<CR>/
nnoremap        <F10> :IndentLinesToggle<CR>
nnoremap <expr> <C-e> mi."<C-e>".mi."j"
nnoremap <expr> <C-y> mi."<C-y>".mi."k"
" EasyMotion
map             <C-F12> <Plug>(easymotion-prefix)
map             s <Plug>(easymotion-s2)
map             <Leader>f <Plug>(easymotion-fl)
map             <Leader>F <Plug>(easymotion-Fl)
" tabs
nnoremap        <leader>1 gT
nnoremap        <leader>2 gt
nnoremap        <C-w>t <C-w>T
" coc
nnoremap        <leader>doc :call <SID>show_documentation()<CR>
nnoremap        <leader>def :execute "normal \<Plug>(coc-definition)"<CR>
nnoremap <silent> <leader>5 :CocCommand explorer --preset floating --quit-on-open<CR>
" fzf
nnoremap        <leader>l :Lines<CR>
" better-whitespace
nnoremap        <leader>= :StripWhitespace<CR>
" quickui
nnoremap        <space><space> :call quickui#menu#open()<CR>

"============================= visual ======================================="
vnoremap <expr> <C-j> mi."j"
vnoremap <expr> <C-k> mi."k"
vnoremap        > >gv
vnoremap        < <gv
vnoremap        <F10> <Esc>:IndentLinesToggle<CR>gv

"============================= insert ======================================="
inoremap        <C-s> <Left>
inoremap        <C-d> <Right>
inoremap        <C-w> <C-\><C-o>db
inoremap        <F10> <Esc>:IndentLinesToggle<CR>a
inoremap        () ()<Left>
inoremap        [] []<Left>
inoremap        {} {}<Left>
inoremap        "" ""<Left>
inoremap        '' ''<Left>
inoremap        <> <><Left>
inoremap        {}<CR> {}<Left><CR><Esc>ko
inoremap        <C-v> <C-r>0
" coc
inoremap <expr><C-n> pumvisible() ? "\<C-n>" : coc#refresh()
inoremap <expr><C-p> pumvisible() ? "\<C-p>  : coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

"============================= Command Abbreviation ========================="
cnoreabbrev     Q q
cnoreabbrev     W w
cnoreabbrev     WQ wq
cnoreabbrev     showspace /\s\+$
cnoreabbrev     removespace %s/\s\+$//
cnoreabbrev     align EasyAlign
cnoreabbrev     sstw SetShiftAndTabWidth
cnoreabbrev     tn tabnew
" fzf
cnoreabbrev     ff Files
cnoreabbrev     fl Lines
cnoreabbrev     fw Windows
" coc
cnoreabbrev <silent> dia :CocDiagnostics
cnoreabbrev     ex CocCommand explorer --preset floating --quit-on-open
cnoreabbrev     setpy CocCommand python.setInterpreter

"============================= Color Scheme ================================="
"let g:onedark_terminal_italics=1
let g:onedark_color_overrides = {
\ "black": {"gui": "#1A1D22", "cterm": "235", "cterm16": "0" },
\}
silent! colorscheme onedark
"set t_Co=256 "support 256 color
"highlight Visual cterm=reverse
highlight OverLength ctermbg=237
highlight CocHighlightText cterm=bold,underline gui=bold,underline
highlight TabLineSel ctermfg=145 ctermbg=236 guifg=#ABB2BF guibg=#2C323C

"============================= Filetype ====================================="
"augroup match_overlength
"    autocmd!
"    autocmd FileType c call MOL80()
"    autocmd FileType cpp call MOL80()
"    autocmd FileType java call MOL80()
"    autocmd FileType python call MOL80()
"    autocmd FileType ruby call MOL80()
"    autocmd FileType fortran call MOL80()
"    autocmd FileType gitcommit call MOL72()
"augroup END
function! MOL80()
    match OverLength '\%>80v.\+' " match overLength for length 80
endfunction
function! MOL72()
    match OverLength '\%>72v.\+' " match overLength for length 72
endfunction

augroup filetype_settings
    autocmd!
    autocmd FileType vim setlocal shiftwidth=4 softtabstop=4 foldmethod=marker
    autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2
    autocmd FileType eruby setlocal shiftwidth=2 softtabstop=2
    autocmd FileType scss setlocal shiftwidth=2 softtabstop=2
    autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
    autocmd FileType fortran setlocal textwidth=72
    autocmd FileType gitcommit setlocal spell textwidth=72 formatoptions+=t
augroup END

"============================= Number Toggle ================================"
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
  autocmd CmdlineLeave * if &nu | set relativenumber | endif
augroup END

"****************************************************************************"
"                              Plugin settings                               "
"****************************************************************************"

"============================= EasyMotion ==================================="
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

"============================= Expand Region ================================"
" use ':h vim-expand-region.txt' to see the doc
let g:expand_region_text_objects = {
            \ 'iw'  :0,
            \ 'iW'  :0,
            \ 'i''' :0,
            \ 'i"'  :0,
            \ 'i)'  :1,
            \ 'i]'  :1,
            \ 'i}'  :1,
            \ 'ip'  :0,
            \ 'a)'  :1,
            \ 'a]'  :1,
            \ 'a}'  :1,
            \ }

"============================= Gutentags ===================================="
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

"============================= REPEAT.VIM ==================================="
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

"============================= Indentline ==================================="
let g:indentLine_enabled = 0

"============================= Tagbar ======================================="
let g:tagbar_width = 30
let g:tagbar_sort = 0
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_autopreview = 0
let g:tagbar_map_showproto = "d"
let g:tagbar_previewwin_pos = "rightbelow"

"============================= Better-Whitespace ============================"
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=0
let g:strip_whitespace_confirm=0
let g:strip_whitelines_at_eof=1
let g:show_spaces_that_precede_tabs=1
let g:better_whitespace_ctermcolor='204'
let g:better_whitespace_guicolor='#E06C75'
let g:better_whitespace_operator=''

"============================= SimpylFold ==================================="
let g:SimpylFold_docstring_preview = 1

"============================= CoC =========================================="
set nobackup " Some servers have issues with backup files, see #649.
set nowritebackup
set updatetime=250 " (ms)
set shortmess+=c " Don't pass messages to |ins-completion-menu|.
set signcolumn=no " prevent diagnostics change signcolumn

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"============================= coc-snippet =================================="
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

"============================= coc-explorer ================================="
let g:coc_explorer_global_presets = {
\   'default': {
\       'width':30
\   },
\   'floating': {
\     'position': 'floating',
\   }
\ }

"============================= Quick UI ====================================="
" clear all the menus
call quickui#menu#reset()

" install a 'File' menu, use [text, command] to represent an item.
call quickui#menu#install('&File', [
            \ [ "&New File\tCtrl+n", 'echo 0' ],
            \ [ "&Open File\t(F3)", 'echo 1' ],
            \ [ "&Close", 'echo 2' ],
            \ [ "--", '' ],
            \ [ "&Save\tCtrl+s", 'echo 3'],
            \ [ "Save &As", 'echo 4' ],
            \ [ "Save All", 'echo 5' ],
            \ [ "--", '' ],
            \ [ "E&xit\tAlt+x", 'echo 6' ],
            \ ])

" items containing tips, tips will display in the cmdline
call quickui#menu#install('&Edit', [
            \ [ '&Copy', 'echo 1', 'help 1' ],
            \ [ '&Paste', 'echo 2', 'help 2' ],
            \ [ '&Find', 'echo 3', 'help 3' ],
            \ ])

" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("&Option", [
            \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
            \ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
            \ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
            \ ])

" register HELP menu with weight 10000
call quickui#menu#install('H&elp', [
            \ ["&Cheatsheet", 'help index', ''],
            \ ['T&ips', 'help tips', ''],
            \ ['--',''],
            \ ["&Tutorial", 'help tutor', ''],
            \ ['&Quick Reference', 'help quickref', ''],
            \ ['&Summary', 'help summary', ''],
            \ ], 10000)

" enable to display tips in the cmdline
let g:quickui_show_tip = 1

"============================= My scripts ==================================="
function! DoSetShiftAndTabWidth(width)
    let &l:shiftwidth = a:width
    let &l:softtabstop = a:width
endfunction
command! -bang -nargs=? SetShiftAndTabWidth call DoSetShiftAndTabWidth(<q-args>)
let @/ = "" " clear highlight history
