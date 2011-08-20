# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# execute when running interactively
if [[ -n "$PS1" ]] ; then

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

# for easy access to xclip (eg: ls -l | xclip)
alias xclip='xclip -selection c'

# disk usage at current level
alias du1='du --max-depth=1'

# Ruby Version Manager shortcuts
alias rc='rvm current'
alias r18='rvm use 1.8.7'
alias r19='rvm use 1.9.2'
alias rjr='rvm use jruby'

# upload ssh public key to a server
function authme {
  ssh $1 'cat >>.ssh/authorized_keys' <~/.ssh/id_rsa.pub
}

# prepend ~/bin to PATH
PATH="$HOME/bin:$PATH"

# jump to ~/dev subdirs
export CDPATH=.:~/dev

# for ImageMagick and Chadwick
export LD_LIBRARY_PATH=/usr/local/lib

# load credentials for various services
if [ -f ~/.credentials ]; then
  source ~/.credentials
fi

# end interactive-only section
fi

# Load Ruby Version Manager. This must come AFTER all PATH/variable settings.
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then source "$HOME/.rvm/scripts/rvm" ; fi
