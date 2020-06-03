# .bashrc
# Yaris Gutierrez <yarisgutierrez@gmail.com>

export LANG=en_US.utf8
export LC_ALL=en_US.utf8
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# PROMPT
# =======================================
source ~/.config/.bash_scripts/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true

# +--- Stash State ---+
# Show currently stashed ($) changes.
GIT_PS1_SHOWSTASHSTATE=false

# +--- Untracked Files ---+
# Show untracked (%) changes.
# Also configurable per repository via "bash.showUntrackedFiles".
GIT_PS1_SHOWUNTRACKEDFILES=true

# +--- Upstream Difference ---+
# Show indicator for difference between HEAD and its upstream.
#
# <  Behind upstream
# >  Ahead upstream
# <> Diverged upstream
# =  Equal upstream
#
# Control behaviour by setting to a space-separated list of values:
#   auto     Automatically show indicators
#   verbose  Show number of commits ahead/behind (+/-) upstream
#   name     If verbose, then also show the upstream abbrev name
#   legacy   Do not use the '--count' option available in recent versions of git-rev-list
#   git      Always compare HEAD to @{upstream}
#   svn      Always compare HEAD to your SVN upstream
#
# By default, __git_ps1 will compare HEAD to SVN upstream ('@{upstream}' if not available).
# Also configurable per repository via "bash.showUpstream".
GIT_PS1_SHOWUPSTREAM="auto verbose name"

# +--- Describe Style ---+
# Show more information about the identity of commits checked out as a detached HEAD.
#
# Control behaviour by setting to one of these values:
#   contains  Relative to newer annotated tag (v1.6.3.2~35)
#   branch    Relative to newer tag or branch (master~4)
#   describe  Relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
#   default   Exactly matching tag
GIT_PS1_DESCRIBE_STYLE="contains"

# +--- Colored Hints ---+
# Show colored hints about the current dirty state. The colors are based on the colored output of "git status -sb".
# NOTE: Only available when using __git_ps1 for PROMPT_COMMAND!
GIT_PS1_SHOWCOLORHINTS=true

# +--- pwd Ignore ---+
# Disable __git_ps1 output when the current directory is set up to be ignored by git.
# Also configurable per repository via "bash.hideIfPwdIgnored".
GIT_PS1_HIDE_IF_PWD_IGNORED=false

compile_prompt () {
  local EXIT=$?
  local CONNECTBAR_DOWN=$'\u250C\u2500\u257C'
  local CONNECTBAR_UP=$'\u2514\u2500\u257C'
  #local CONNECTBAR_UP=$'\u2514\u2500'
  local GITSPLITBAR=$'\u2570\u257C'
  local SPLITBAR=$'\u257E\u2500\u257C'
  local SPLITBAR2=$'\u257E\u2500\u257C'
  local ARROW=$'\u25B6'
  local c_green='\e[0;32m'
  local c_gray='\e[0;37m'
  local c_blue='\e[0;34m'
  local c_cyan='\e[0;36m'
  local c_magenta='\e[0;35m'
  local c_reset='\e[0m'

  # > Connectbar Down
  # Format:
  #   (newline)(bright colors)(connectbar down)
  PS1="\n${c_gray}"
  PS1+="$CONNECTBAR_DOWN"

  # > Username
  # Format:
  #   (bracket open)(username)(bracket close)(splitbar)
  PS1+="[${c_green}\u${c_gray}]"
  PS1+="$SPLITBAR"

  # > Working Directory
  # Format:
  #   (bracket open)(working directory)(bracket close)(newline)
  PS1+="[${c_blue}\w${c_gray}]"

  # > Git
  # Format:
  #   (gitsplitbar)(bracket open)(git branch)(bracket close)(splitbar)
  #   (bracket open)(HEAD-SHA)(bracket close)
  PS1+="$(__git_ps1 "$SPLITBAR[${c_magenta}%s${c_gray}]\\u257E\\u2500\\u257C[${c_cyan}$(git rev-parse --short HEAD 2> /dev/null)${c_gray}]")"
  # Append additional newline if in git repository
  #if [[ ! -z $(__git_ps1) ]]; then
  #  PS1+='\n'
  #fi

  #PS1+="$ARROW \[\e[0m\]"
  PS1+="\n$CONNECTBAR_UP $ \[\e[0m\]"
}

PROMPT_COMMAND='compile_prompt'
# =============================================


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors ~/.dir_colors/dir_colors)"
    alias ls='ls --color=auto'

fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
LS_COLORS=$LS_COLORS:'di=0;36' ; export LS_COLORS

# Aliases
alias virtualenv3='python3 -m venv'
alias r2d2='ssh protocol@192.168.1.234'
alias ubuntu_main='ssh protocol@192.168.1.237'
alias checkJournal="sudo journalctl --follow"
alias mount_bigid="sudo mount.cifs //BIGID-YG/Downloads /home/protocol/bigIDShare/ -o user=Yaris"
alias cpu='ps aux | sort -k 3,3 | tail'
alias mem='ps aux | sort -k 4,4 | tail:w'
alias grep='grep --color=always'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function cli_csv { 
    column -t -s, -n "$@" | less -F -S -X -K
}

function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)      tar xjf $1    ;;
            *.tar.gz)       tar xzf $     ;;
            *.bz2)          bunzip2 $1    ;;
            *.rar)          rar x $1      ;;
            *.gz)           gunzip $1     ;;
            *.tar)          tar xf $1     ;;
            *.tbz2)         tar xjf $1    ;;
            *.tgz)          tar xzf $1    ;;
            *.zip)          unzip $1      ;;
            *.Z)            uncompress $1 ;;
            *.7z)           7z x $1       ;;
            *)              echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


function psgrep() {
    if [ ! -z $1 ] ; then
        echo "Grepping for processes matching $1..."
        ps aux | grep $1 | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

function reboot_to_windows {
    WINDOWS_TITLE=`grep -i 'windows' /boot/grub/grub.cfg|cut -d"'" -f2`
    sudo grub-reboot "$WINDOWS_TITLE"
    sudo reboot
}
