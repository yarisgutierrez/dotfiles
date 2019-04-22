" Vim color file
" Maintainer:	Yaris Gutierrez <yarisgutierrez@gmail.com>
" Last Change:	2019 Apr 20

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "yaris"

hi Comment ctermfg=green
hi LineNr ctermfg=darkgray
hi CursorLineNR ctermfg=white
hi Visual ctermfg=black ctermbg=green
hi Statement ctermfg=lightgray cterm=bold
hi Operator ctermfg=darkmagenta cterm=bold
hi Special ctermfg=yellow
hi GitGutterAdd ctermfg=green
hi GitGutterChange ctermfg=yellow
hi GitGutterDelete ctermfg=darkred

" vim: sw=2
