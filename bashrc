[[ "$-" != *i* ]] && return

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.completion/git.completion.bash ]; then
	. ~/.completion/git.completion.bash
fi

if [ -f ~/.completion/tmux.completion.bash ]; then
	. ~/.completion/tmux.completion.bash
fi

set -o emacs
export PS1="\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ "
export LANG="en_US.UTF-8"

# Aliases
if [ -f /usr/bin/vim ] || [ -f /bin/vim ]; then
	alias vi="vim"
fi

alias tmux='tmux -2'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
#
# Misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
if [ `uname`x = "Darwin"x ]; then
	alias ls='ls -h -G'                  # classify files in colour
else
	alias ls='ls -h --color=auto'
fi
alias dir='ls -G --format=vertical'
alias vdir='ls -G --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

#eval "$(rbenv init -)"

PERL_MB_OPT="--install_base \"/Users/hongjy/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/hongjy/perl5"; export PERL_MM_OPT;

#export GOROOT=/root/app/go
#export GOPATH=/root/app/gopackage
#export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:/root/app/mongodb-linux-x86_64-3.0.1/bin

export _JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true"
