# DragonFly aliases

# gem install colorls
command -v colorls &>/dev/null
if [[ $? -eq 0 ]]; then
    USE_COLORLS=true
fi

unset zle_bracketed_paste
alias ...='cd ../../'
alias da='du -sch'
alias dir='command ls -lSrah'
alias egrep='egrep --color=auto'
alias grep='grep --color=auto'
alias insecscp='scp -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
if $USE_COLORLS; then
    alias l='command colorls -l -G'
    alias la='command colorls -la -G'
    alias lad='command colorls -d .*(/)'
    alias lh='command colorls -hAl -G'
    alias ll='command colorls -l -G'
    alias ls='command colorls -G'
    alias lsa='command colorls -a .*(.)'
    alias lsd='command colorls -d *(/)'
    alias lse='command colorls -d *(/^F)'
    alias lsnew='command colorls -rtlh *(D.om[1,10])'
    alias lsnewdir='command colorls -rthdl *(/om[1,10]) .*(D/om[1,10])'
    alias lsold='command colorls -rtlh *(D.Om[1,10])'
    alias lsolddir='command colorls -rthdl *(/Om[1,10]) .*(D/Om[1,10])'
    alias lssmall='command colorls -Srl *(.oL[1,10])'
else
    alias l='command ls -l -G'
    alias la='command ls -la -G'
    alias lad='command ls -d .*(/)'
    alias lh='command ls -hAl -G'
    alias ll='command ls -l -G'
    alias ls='command ls -G'
    alias lsa='command ls -a .*(.)'
    alias lsd='command ls -d *(/)'
    alias lse='command ls -d *(/^F)'
    alias lsnew='command ls -rtlh *(D.om[1,10])'
    alias lsnewdir='command ls -rthdl *(/om[1,10]) .*(D/om[1,10])'
    alias lsold='command ls -rtlh *(D.Om[1,10])'
    alias lsolddir='command ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])'
    alias lssmall='command ls -Srl *(.oL[1,10])'
fi
alias mq='hg -R $(readlink -f $(hg root)/.hg/patches)'
alias rmcdir='cd ..; rmdir $OLDPWD || cd $OLDPWD'
alias rune='command run emacs &>/dev/null'
alias runec='command run emacsclient --create-frame &>/dev/null'
alias se='simple-extract'
alias term2iso='echo '\''Setting terminal to iso mode'\'' ; print -n '\''\e%@'\'
alias term2utf='echo '\''Setting terminal to utf-8 mode'\''; print -n '\''\e%G'\'
alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'
