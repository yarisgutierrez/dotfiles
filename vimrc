" -------------------------------------------------------------
"  File: .vimrc
"  Author: Yaris Alex Gutierrez <yarisgutierrez@gmail.com>
" -------------------------------------------------------------

" Vundle
set nocompatible

filetype off

call plug#begin('~/.vim/plugged')

" Active Plugins
Plug 'vim-scripts/indentpython.vim'       " 
Plug 'tmhedberg/SimpylFold'               " Code folding
Plug 'w0rp/ale'                           " True asynchronous linter/code checker. Replaced Synatastic
Plug 'scrooloose/nerdtree'                " Better file browser
Plug 'tpope/vim-fugitive'                 " Git integration
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'                  " Class/module browser
Plug 'Townk/vim-autoclose'                " Autoclose
Plug 'tpope/vim-surround'                 " Handle surround characters such as ''
Plug 'nvie/vim-flake8'                    " Check syntax and style through Flake8
Plug 'hynek/vim-python-pep8-indent'       " Modify vim indentation to comply to PEP8
Plug 'sheerun/vim-polyglot'
Plug 'davidhalter/jedi'
Plug 'kien/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'marciomazza/vim-brogrammer-theme'

call plug#end()

filetype plugin indent on

" tmux
if exists('$TMUX')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

""" Appearance
" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Colors
syntax enable
set background=dark
set t_Co=256
"set termguicolors
colorscheme peachpuff
hi Comment ctermfg=green

" Misc
set updatetime=250
set encoding=utf-8
set ttyfast
set backspace=indent,eol,start
set switchbuf+=usetab,newtab
set mouse=a
set clipboard=unnamed

" Flag unnecessary whitespace
hi BadWhitespace ctermbg=Red guibg=DarkRed

" Disable Arrow Keys
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

" Move between splits
noremap <C-h> <C-w><Left>
noremap <C-j> <C-w><Down>
noremap <C-k> <C-w><Up>
noremap <C-l> <C-w><Right>

" Spaces & Tabs
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set omnifunc=syntaxcomplete#Complete
set autoindent

" UI Layout
set showtabline=2
"set cursorline
set nu
nmap <F3> :set nu!<CR>
set noshowmode
set showmatch                               " Highlight matching paranthesis

""" COC Settings
let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-html',
    \ 'coc-prettier',
    \ 'coc-json',
    \ 'coc-python'
    \ ]

set hidden                                  " if hidden is not set, TexEdit might fail
set nobackup                                " Some servers has issues with backup files
set nowritebackup                           
set cmdheight=2                             " Better display for messages
set updatetime=300                          " Bad experience for diagnostic messages when default is 4000
set shortmess+=c                            " Do not give ins-completion-menu messages
set signcolumn=yes                         " Always show signcolumns

" Use tab for trigger completion with chracters ahead and navigate
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
""" END COC SETTINGS


""" Statusline
" Ale linter settings
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = 'ERROR'
let g:ale_echo_msg_warning_str = 'WARNING'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" Display errors from Ale in statusline
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
                \ 'W:%d E:%d',
                \ all_non_errors,
                \ all_errors
                \)
endfunction

" Custom status line status to avoid using plugin(s)
function! StatuslineMode()
    let l:mode=mode()
    if l:mode==#"n"
        exe 'hi! StatusLine ctermfg=blue ctermbg=white'
        return "NORMAL"
    elseif l:mode==?"v"
        exe 'hi! StatusLine ctermfg=yellow ctermbg=black'
        return "VISUAL"
    elseif l:mode==#"i"
        exe 'hi! StatusLine ctermfg=green ctermbg=black'
        return "INSERT"
    elseif l:mode==#"R"
        exe 'hi! StatusLine ctermfg=red ctermbg=white'
        return "REPLACE"
    elseif l:mode==?"s"
        return "SELECT"
    elseif l:mode==#"t"
        return "TERMINAL"
    elseif l:mode==#"c"
        return "COMMAND"
    elseif l:mode==#"!"
        return "SHELL"
    endif
endfunction

" Git repo/status
function! StatuslineGitBranch()
    let b:gitbranch=""
    if &modifiable
        lcd %:p:h
        let l:gitrevparse=system("git rev-parse --abbrev-ref HEAD")
        lcd -
        if l:gitrevparse!~"fatal: not a git repository"
            let b:gitbranch="[".substitute(l:gitrevparse, '\n', '', 'g')."] "
        endif
    endif
endfunction

augroup GetGitBranch
    autocmd!
    autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

" coc-status-manual
function! StatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, 'E' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, 'W' . info['warning'])
    endif
    return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

set laststatus=2
set statusline=
set statusline+=\ %{StatuslineMode()}\ 
set statusline+=%4*\ [%n]\%4*
set statusline+=%4*\ %{b:gitbranch}
set statusline+=%1*\ %F\ %4*
set statusline+=%3*\ %{StatusDiagnostic()}\%4*
set statusline+=%=
set statusline+=%4*\ %y\ %4*
set statusline+=%5*\ %{LinterStatus()}\ 
set statusline+=%1*\ %{strlen(&fenc)?&fenc:'none'}\ %4*
set statusline+=%2*\ %l\:%c\ %4*
set statusline+=%2*\ %P\ 

" Define colors
hi User1 ctermbg=white ctermfg=black
hi User2 ctermbg=darkgray ctermfg=white
hi User3 ctermbg=green ctermfg=black
hi User4 ctermbg=black ctermfg=white
hi User5 ctermbg=darkcyan ctermfg=black


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

" Switch Tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" NERDTree
let NERDTreeIgnore = ['\.pyc$', 'build', 'venv', 'egg', 'egg-info/', 'dist', 'docs']
nmap <F6> :NERDTreeToggle<CR>
nmap <F7> :NERDTreeFind<CR>
nmap <F8> :TagbarToggle<CR>


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

" PHP
" autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
set completeopt=longest,menuone
let g:SuperTabDefaultCompletionType= "<c-x><c-o>"

" Python
au BufNewFile,BufRead *.py set filetype=python
au FileType python set expandtab
au FileType python set fileformat=unix
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

" C
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END
" configure build system
set makeprg=make\ -C\ ../build\ -j9
" bind F4 to compile
nnoremap <F4> :make!<cr>

" Full Stack
au BufNewFile,BufRead *.js, *.html, *.css
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2 |

" Log Stuff
au BufNewFile,BufRead *.log* set filetype=log
au BufNewFile,BufRead *.log set filetype=log

set t_ut=
