" -----------------------------------------------
" Yaris Alex Gutierrez <yarisgutierrez@gmail.com>
" vimrc

" Vundle
set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'               " let Vundle manage Vundle, required

" Active Plugins
Plugin 'vim-scripts/indentpython.vim'       " 
Plugin 'tmhedberg/SimpylFold'               " Code folding
Plugin 'w0rp/ale'                           " True asynchronous linter/code checker. Replaced Synatastic
Plugin 'scrooloose/nerdtree'                " Better file browser
Plugin 'tpope/vim-fugitive'                 " Git integration
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'                  " Class/module browser
Plugin 'ctrlpvim/ctrlp.vim'                 " Code and file fuzzy finder
Plugin 'Townk/vim-autoclose'                " Autoclose
Plugin 'tpope/vim-surround'                 " Handle surround characters such as ''
Plugin 'nvie/vim-flake8'                    " Check syntax and style through Flake8
Plugin 'hynek/vim-python-pep8-indent'       " Modify vim indentation to comply to PEP8
Plugin 'itchyny/lightline.vim'              " Status line
Plugin 'sheerun/vim-polyglot'

call vundle#end()

filetype plugin indent on

" Colors
syntax enable
set t_Co=256
colorscheme Tomorrow-Night-Bright

" Misc
set updatetime=250
set encoding=utf-8
set ttyfast
set backspace=indent,eol,start
set switchbuf+=usetab,newtab
set mouse=a
set clipboard=unnamed


" Flag unnecessary whitespace
highlight BadWhitespace ctermbg=Red guibg=DarkRed

" Spaces & Tabs
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set omnifunc=syntaxcomplete#Complete
set autoindent

" UI Layout
set showtabline=2
set guioptions-=e
set cursorline
set nu
nmap <F3> :set nu!<CR>

set laststatus=2
set noshowmode

set showmatch           " Highlight matching paranthesis

" GUI
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set guioptions-=m
    set t_Co=256
    colorscheme Tomorrow-Night-Bright
    set guitablabel=%M\ %t
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 11
    set lines=50 columns=100
endif

" Searching
set ignorecase          " Ignore case when searching
set incsearch           " Search as characters are entered
set hlsearch!           " Highlight all matches
nnoremap <F9> :set hlsearch!<CR>

" Folding
set foldmethod=indent   " Fold based on indent level
set foldnestmax=10      " Max 10 depth
set foldenable          " Don't fold files by default on open
nnoremap <space> za
set foldlevelstart=10   " Start with fold level of 1

" Leader Shortcuts
let mapleader=","
nnoremap <leader>ev :tabedit $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader><space> :noh<CR>

" CtrlP
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'

" NERDTree
let NERDTreeIgnore = ['\.pyc$', 'build', 'venv', 'egg', 'egg-info/', 'dist', 'docs']
nmap <F6> :NERDTreeToggle<CR>
nmap <F7> :NERDTreeFind<CR>
nmap <F8> :TagbarToggle<CR>

" Ale
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = 'ERROR'
let g:ale_echo_msg_warning_str = 'WARNING'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" AutoGroups
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter *cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

" Backups
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set writebackup

" Custom Functions
" Strips trailing whitespace at the end of files. This is called on buffer
" write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " -- Save last search and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

function! <SID>CleanFile()
    " -- Preparation: save last search, and cursor position.
    let _s=!/
    let l = line(".")
    let c = col(".")
    " -- Do the business:
    %!git stripspace
    " -- Clean up: restore previous search history and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Toggle status line with Shift+H
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <S-h> :call ToggleHiddenAll()<CR>

function! LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightLineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓' : ''
endfunction

"" Lightline settings
let g:lightline = {
            \ 'active': {
            \   'left':[ [ 'mode', 'paste' ],
            \            [ 'gitbranch', 'readonly', 'filename', 'modified' ]
            \   ],
            \   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
            \ },
                \   'component': {
                \     'lineinfo': ' %3l:%-2v',
                \   },
            \   'component_function': {
            \     'gitbranch': 'fugitive#head',
            \   },
            \   'component_expand': {
            \     'linter_warnings': 'LightlineLinterWarnings',
            \     'linter_errors': 'LightlineLinterErrors',
            \     'linter_ok': 'LightlineLinterOK'
            \ },
            \   'component_type': {
            \     'readonly': 'error',
            \     'linter_warnings': 'warning',
            \     'linter_errors': 'error'
            \},
            \ }

autocmd User ALELint call lightline#update()

let g:lightline.separator = {
            \   'left': '', 'right': ''
            \}

let g:lightline.tabline = {
            \ 'left': [ ['tabs'] ],
            \ 'right': [ ['close'] ]
            \}

" PHP
" autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
set completeopt=longest,menuone
let g:SuperTabDefaultCompletionType= "<c-x><c-o>"

" Python
au BufNewFile,BufRead *.py set filetype=python
au FileType python set textwidth=79         " PEP-8 Friendly. Lines longer than 79 columns will be broken
au FileType python set shiftwidth=4         " operation >> indents 4 columns; << unindents 4 columns
au FileType python set tabstop=4            " a hard TAB displays as 4 columns
au FileType python set softtabstop=4        " insert/delete 4 spaces when hitting a TAB/BACKSPACE
au FileType python set shiftround           " round indent to multiple 'shiftwidth'
au FileType python set autoindent           " align the new line indent with the previous line
au FileType python set colorcolumn=79
au FileType python highlight ColorColumn ctermbg=grey guibg=lightgrey
au FileType python syn keyword pythonDecorator True None false self
let python_highlight_all=1

" Full Stack
au BufNewFile,BufRead *.js, *.html, *.css
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2 |
