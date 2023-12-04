# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# -- my prompt --
# variables
time=""
path=""
git_branch=""
git_changed='*'
sep='>'

# colors
time_color='\033[90m'
path_color='\033[37m'
git_color='\033[33m'
reset='\033[00m'

if [ "$color_prompt" = yes ]
then
    time+="\[${time_color}\]"
    path+="\[${path_color}\]"
    git_branch+="\[${git_color}\]"
fi

# icons
if [[ -f ~/.prompt_icons ]]
then
	use_icons=yes # if no, use ASCII only in the prompt
else
	use_icons=no
fi
if [ "$use_icons" = yes ]
then
    time+=$'\uf43a'
    path+=$'\uf114 '
    git_branch+=$'\ue725 '
    git_changed=$'*'
    #sep=$'\uf138'
    #sep=$'\uf460'
    sep=$'\ue691'
fi

# content
time+=" \\t "
path+="\\w"
git_branchname='$(git branch --show-current) '

# git function - only called if git is found
function prompt_git() {
    # if in a git repo
    if [[ $(git rev-parse --git-dir 2>/dev/null) ]]
    then
        PS1+=${git_branch}
        # if any changes since last commit
        if [[ $(git status --porcelain) ]]
        then
            PS1+=${git_changed}
        fi
        PS1+=${git_branchname}
    fi
}
# Use the prompt_git only if git is installed
if [[ -n "$(which git)" ]]
then
	prompt_git_fn='prompt_git'
else
	prompt_git_fn=':'
fi
# function
function prompt_fn() {
    PS1=${time}
	$prompt_git_fn
    PS1+="${path}${sep}\[${reset}\] "
}
PROMPT_COMMAND='prompt_fn'

unset color_prompt force_color_prompt


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

