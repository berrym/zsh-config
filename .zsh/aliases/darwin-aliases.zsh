# Darwin aliases
alias ...='cd ../../'
alias da='du -sch'
alias dir='command ls -lSrah'
alias egrep='egrep --color=auto'
alias grep='grep --color=auto'
alias insecscp='scp -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
alias l='command ls -l -G'
alias la='command ls -la -G'
alias lad='command ls -d .*(/)'
alias lh='command ls -hAl -G'
alias ll='command ls -l -G'
alias ls='command ls -G'
alias lsa='command ls -a .*(.)'
alias lsbig='command ls -flh *(.OL[1,10])'
alias lsd='command ls -d *(/)'
alias lse='command ls -d *(/^F)'
alias lsl='command ls -l *(@)'
alias lsnew='command ls -rtlh *(D.om[1,10])'
alias lsnewdir='command ls -rthdl *(/om[1,10]) .*(D/om[1,10])'
alias lsold='command ls -rtlh *(D.Om[1,10])'
alias lsolddir='command ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])'
alias lss='command ls -l *(s,S,t)'
alias lssmall='command ls -Srl *(.oL[1,10])'
alias lsw='command ls -ld *(R,W,X.^ND/)'
alias lsx='command ls -l *(*)'
alias mdstat='cat /proc/mdstat'
alias mq='hg -R $(readlink -f $(hg root)/.hg/patches)'
alias new=modified
alias rmcdir='cd ..; rmdir $OLDPWD || cd $OLDPWD'
alias rune='command run emacs &>/dev/null'
alias runec='command run emacsclient --create-frame &>/dev/null'
alias se=simple-extract
alias term2iso='echo '\''Setting terminal to iso mode'\'' ; print -n '\''\e%@'\'
alias term2utf='echo '\''Setting terminal to utf-8 mode'\''; print -n '\''\e%G'\'
alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'
alias which-command=whence
