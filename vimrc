" -----------------------------------------------
" Yaris Alex Gutierrez <yarisgutierrez@gmail.com>
" vimrc
" Last Modified on March 20, 2017
" -----------------------------------------------

set nocompatible

" Setting up Vundle
let haveVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let haveVundle=0
endif

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'               " let Vundle manage Vundle, required
Plugin 'vim-scripts/indentpython.vim'       " 
Plugin 'tmhedberg/SimpylFold'               " Code folding
Plugin 'w0rp/ale'                           " True asynchronous linter/code checker. Replaced Synatastic
Plugin 'scrooloose/nerdtree'                " Better file browser
Plugin 'tpope/vim-fugitive'                 " Git integration
Plugin 'majutsushi/tagbar'                  " Class/module browser
Plugin 'ctrlpvim/ctrlp.vim'                 " Code and file fuzzy finder
Plugin 'Townk/vim-autoclose'                " Autoclose
Plugin 'tpope/vim-surround'                 " Handle surround characters such as ''
Plugin 'dracula/vim'                        " Dracula vim theme
Plugin 'nvie/vim-flake8'                    " Check syntax and style through Flake8
Plugin 'davidhalter/jedi-vim'               " Python autocompletion
Plugin 'hynek/vim-python-pep8-indent'       " Modify vim indentation to comply to PEP8
Plugin 'itchyny/lightline.vim'              " Status line
Plugin 'whatyouhide/vim-gotham'             " colorscheme

" Install plugins the first time vim runs
if haveVundle == 0
    echo "Installing Plugins, please ignore key map error messages..."
    echo ""
    :silent! PluginInstall
    :qa
endif

call vundle#end()

let &runtimepath.=',~/.vim/bundle/ale'

filetype plugin indent on

" Colors
syntax enable
set t_Co=256
colorscheme gotham

" Misc
set encoding=utf-8
set ttyfast
set backspace=indent,eol,start
set switchbuf+=usetab,newtab
let g:nerdtree_tabs_open_on_console_startup=1
let g:lightline = { 'colorscheme': 'gotham' }

" Toggle Tree
nmap <F6> :NERDTreeToggle<CR>
nmap <F7> :NERDTreeFind<CR>
nmap <F8> :TagbarToggle<CR>

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
set number
set showcmd
set wildmenu

" Status line
set laststatus=2

nmap <F3> :set nu!<CR>

" Set lazyredraw
set showmatch           " Highlight matching paranthesis

" GUI
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set guioptions-=m
    set t_Co=256
    colorscheme gotham
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

" CtrlP
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'

" NERDTree
let NERDTreeIgnore = ['\.pyc$', 'build', 'venv', 'egg', 'egg-info/', 'dist', 'docs']

" Ale
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = 'ERROR'
let g:ale_echo_msg_warning_str = 'WARNING'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

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

" --Strips trailing whitespace at the end of files. This is called on buffer
" --write in the autogroup above
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

" PHP
" autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
set completeopt=longest,menuone
let g:SuperTabDefaultCompletionType= "<c-x><c-o>"

" Python
" -- Add Proper PEP8 Indentation
au BufNewFile,BufRead *.py set filetype=python
au FileType python set textwidth=79         " PEP-8 Friendly. Lines longer than 79 columns will be broken
au FileType python set shiftwidth=4
au FileType python set tabstop=4
au FileType python set softtabstop=4
au FileType python set shiftround
au FileType python set autoindent
au FileType python syn keyword pythonDecorator True None false self
let python_highlight_all=1

" Full Stack
au BufNewFile, BufRead *.js, *.html, *.css
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2 |
