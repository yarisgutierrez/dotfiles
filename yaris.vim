" Vim color file
" Maintainer:	Yaris Gutierrez <yarisgutierrez@gmail.com>

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
hi Operator ctermfg=darkmagenta
hi Special ctermfg=yellow
hi Boolean ctermfg=yellow cterm=bold
hi Decorator ctermfg=green
hi Conditional ctermfg=blue cterm=bold
hi Constant ctermfg=red
hi PreProc ctermfg=magenta

hi TabLineFill ctermfg=black
hi TabLine ctermbg=black ctermfg=white
hi TabLineSel ctermbg=darkgray ctermfg=white cterm=none

hi GitGutterAdd ctermfg=green
hi GitGutterChange ctermfg=yellow
hi GitGutterDelete ctermfg=darkred

hi ALEWarning ctermbg=yellow ctermfg=black
hi ALEError ctermbg=darkred ctermfg=black

" vim: sw=2
