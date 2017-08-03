# .zshrc - z shell config file
#
# (c) 2015 Michael Berry <trismegustis@gmail.com>

# Behave like the z shell
emulate -L zsh

# Determine OS
# Test if OS is Linux
isLinux() {
    [[ $OSNAME == "Linux" ]]
}

# Test if OS is Darwin
isDarwin() {
    [[ $OSNAME == "Darwin" ]]
}

# Test if OS is FreeBSD
isFreeBSD() {
    [[ $OSNAME == "FreeBSD" ]]
}

# Test if OS is OpenBSD
isOpenBSD() {
    [[ $OSNAME == "OpenBSD" ]]
}

# Test if OS is NetBSD
isNetBSD() {
    [[ $OSNAME == "NetBSD" ]]
}

# Test if OS is DragonFly
isDragonFly() {
    [[ $OSNAME == "DragonFly" ]]
}

# Set path and other OS independent variables
LANG=en_US.UTF-8
CHARSET=en_US.UTF-8
PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin
PATH=$PATH:/usr/bin:/usr/sbin:/bin:/sbin
OSNAME=$(uname -s)        # Determine OS

if isLinux; then
    ;
elif isDarwin; then
    PATH=$PATH:/usr/X11/bin
    # HomeBrew GitHub Key
    export HOMEBREW_GITHUB_API_TOKEN=60f48f8a8684dcd786edd0011cb61b39fd7aacb6
    export HOMEBREW_CC=clang
elif isFreeBSD; then
    PATH=$PATH:/usr/X11R6/bin
    hash -d ports=/usr/ports
    hash -d src=/usr/src
elif isOpenBSD; then
    PATH=$PATH:/usr/X11R6/bin
    TERM=xterm-xfree86
    hash -d ports=/usr/ports
    hash -d src=/usr/src
    hash -d xenocara=/usr/xenocara
elif isNetBSD; then
    PATH=$PATH:/usr/X11R7/bin
    PATH=$PATH:/usr/pkg/bin
    hash -d pkgsrc=/usr/pkgsrc
fi

# Set pager
command -v less &>/dev/null
if [ $? -eq 0 ]; then
    PAGER=less
else
    PAGER=more
fi

# Check for the mg editor, else default to vi
command -v mg &>/dev/null
if [ $? -eq 0 ]; then
    EDITOR=mg
else
    EDITOR=vi
fi

# Set global exports
export LANG CHARSET PATH PAGER EDITOR

# Gain access to online help
autoload -Uz run-help
HELPDIR=/usr/local/share/zsh/help

autoload -Uz colors zsh-mime-setup select-word-style
colors                        # colors
zsh-mime-setup                # run everything like an executable
select-word-style bash        # [ctrl]+w on words

# Keybindingds
bindkey -e                    # Emacs style keybindings

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '\e[A' up-line-or-beginning-search   # up arrow
bindkey '\e[B' down-line-or-beginning-search # down arrow
bindkey '^[[1;5C' forward-word               # ctrl+[right arrow]
bindkey '^[[1;5D' backward-word              # ctrl+[left arrow]

bindkey '\ew' kill-region     # esc+w kill from cursor to mark
bindkey -s '\el' 'ls\n'       # esc+l execute ls command

# Configure completions
autoload -Uz compinit && compinit -u
zmodload -i zsh/complist

setopt hash_list_all          # hash everything before complettion
setopt auto_menu              # use menu completion
setopt completealiases        # complete aliases
setopt complete_in_word       # complete within a word or phrase
setopt always_to_end          # move cursor to end of complettion
setopt always_last_prompt     # return to last prompt
setopt list_ambiguous         # complete until completion is ambiguous

zstyle ':completion::complete:*' use-cache yes # completion caching
zstyle ':completion::complete:*' cache-path $HOME/.cache/zsh
zstyle ':completion::complete:*' list-colors
zstyle ':completion::complete:*' menu select
zstyle ':completion::complete:*' menu yes

# use approximate completion
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors \
       'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' auto-description 'specify %d'
zstyle ':completion:*' list-colors '#=(#b) #([0-9]#)*=36=31'
zstyle ':completion:*' menu select

# kill completion menu
zstyle ':completion:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors \
       '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:killall:*' force-list always
zstyle ':completion:*:default' list_prompt

# killall menu
zstyle ':completion:*:processes-names' list-colors \
       command 'ps c -u ${USER} -o command | uniq'

# format completions
zstyle ':completion:descriptions' format $'\e[00;34,%d'

# provide verbose completion information
zstyle ':completion:*' verbose yes

# complete manuals by sections
zstyle ':completion:*:manuals' seperate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:man:*' menu yes select

# start menu completion if no unambiguous initial string was found
zstyle ':completion:*:correct:*'  insert-unambiguous true
zstyle ':completion:*:corrections' format \
       $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:correct:*' original true

# format on completion
zstyle ':completion:*:descriptions' format \
       $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

# automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:history-words' list false

# activate menu
zstyle ':completion:*:history-words' menu yes

# ignore duplicate entries
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' stop yes

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# separate matches into groups
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''

# Search path for sudo/doas completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
       /usr/local/bin  \
       /usr/sbin       \
       /usr/bin        \
       /sbin           \
       /bin            \
       /usr/pkg/bin    \
       /usr/X11R6/bin

hosts=/dev/null
if [ -r .ssh/known_hosts ]; then
    hosts=($(((awk '{print $1}' .ssh/known_hosts | tr , '\n'); ) | sort -u))
fi
zstyle ':completion:*' hosts $hosts

# run rehash on completion so new installed program are found automatically:
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1
}

bindkey -M menuselect '^o' accept-and-infer-next-history

# disable named-directories autocompletion
zstyle ':completion:*:cd*' tag-order \
       local-directories directory-stack path-directories

# Version control info
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git hg svn cvs bzr
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "%{$fg[magenta]%}%c%{$fg[green]%}%u\
%{$fg[magenta]%} [%{$fg[green]%}%b%{$fg[magenta]%}]\
-%{$fg[yellow]%}%s%{$reset_color%}:%{$fg[cyan]%}%r%{$reset_color%}"

# Prompt configuration
load_custom_prompt() {
    setopt PROMPT_SUBST       # needed for vcs_info_msg_0
    color="blue"
    if [ "$USER" = "root" ]; then
	color="red"
    fi
    PROMPT="%{$fg[$color]%}%n%{$reset_color%} %B%~%b %% "
    RPROMPT="${vcs_info_msg_0_}"
}

# Load vcs info before each prompt
precmd() {
    vcs_info
    load_custom_prompt
}

# Pushd
setopt auto_pushd             # make cd push old dir in dir stack
setopt pushd_ignore_dups      # no duplicates in dir stack
setopt pushd_silent           # no dir stack after pushd or popd
setopt pushd_to_home          # `pushd` = `pushd $HOME`

# Configure history
if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=100
SAVEHIST=100

setopt append_history         # append history
setopt hist_ignore_dups       # ignore duplicates
setopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks     # trim blanks
setopt hist_verify            # show command before executing history
setopt inc_append_history     # immediately add commands
setopt share_history          # share histpry between sessions
setopt bang_hist              # ! syntax to access history

# Misc options
setopt auto_cd                # if command is a path, cd into it
setopt auto_remove_slash      # self explicit
setopt correct_all            # try to correct spelling of commands
setopt extended_glob          # activate complex pattern globbing
setopt noclobber              # don't overwrite file, use >! to do so
setopt longlistjobs           # display pid when suspending
setopt notify                 # report status of background jobs
setopt print_exit_value       # print return value if non-zero
setopt interactivecomments    # turn on comments
setopt hash_list_all          # hash command path before completion
setopt complete_in_word       # complete at any place in a word
setopt nobeep                 # no bell on error
setopt nohup                  # no hup signal at shell exit
setopt noglobdots             # don't match dotfiles
setopt noshwordsplit          # use zsh style word splitting
setopt no_bg_nice             # down;t lower priority for background jobs
setopt no_rm_star_silent      # confirm an `rm *' or `rm path/*'
setopt unset

# Print more information to user if positive
VERBOSE=0
verbose() {
    [[ $VERBOSE -gt 0 ]]
}

# Switch to a directoy the list it's contents
cl() {
    if [ -d $1 ]; then
	cd $1 && ls -a
    else
	if verbose; then
	    print 'directory $1 does not exist.\n'
	fi
    fi
}

# Switch to directory, create it if necessary
mkcd() {
    if [ $ARGC -ne 1 ]; then
	print 'usage: mkcd <new-directory>\n'
	return 1;
    fi

    if [ ! -d $1 ]; then
	command mkdir -p $1
    else
	if verbose; then
	    printf '`%s'\'' already exists: cd-ing into directory.\n' "$1"
	fi
    fi

    cd $1
}

# Switch to LABDIR root directory or a project subdir, create it if needed
lab() {
    LABDIR=$HOME/Lab
    mkcd $LABDIR
    mkcd $LABDIR/$1
}

# Aliases
# GNU/Linux
if isLinux; then
    alias ...='cd ../../'
    alias da='du -sch'
    alias dir='command ls -lSrah'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias grep='grep --color=auto'
    alias hbp=hg-buildpackage
    alias help-zshglob=H-Glob
    alias insecscp='scp -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
    alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
    alias l='command ls -l --color=auto'
    alias l.='ls -d .* --color=auto'
    alias la='command ls -la --color=auto'
    alias lad='command ls -d .*(/)'
    alias lh='command ls -hAl --color=auto'
    alias ll='command ls -l --color=auto'
    alias ls='command ls --color=auto'
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
    alias se=simple-extract
    alias term2iso='echo '\''Setting terminal to iso mode'\'' ; print -n '\''\e%@'\'
    alias term2utf='echo '\''Setting terminal to utf-8 mode'\''; print -n '\''\e%G'\'
    alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'
    alias which='(alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot'
    alias which-command=whence
    alias xzegrep='xzegrep --color=auto'
    alias xzfgrep='xzfgrep --color=auto'
    alias xzgrep='xzgrep --color=auto'
    alias zegrep='zegrep --color=auto'
    alias zfgrep='zfgrep --color=auto'
    alias zgrep='zgrep --color=auto'
fi

# Mac
if isDarwin; then
    alias ...='cd ../../'
    alias da='du -sch'
    alias dir='command ls -lSrah'
    alias egrep='egrep --color=auto'
    alias grep='grep --color=auto'
    alias hbp=hg-buildpackage
    alias help-zshglob=H-Glob
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
    alias se=simple-extract
    alias term2iso='echo '\''Setting terminal to iso mode'\'' ; print -n '\''\e%@'\'
    alias term2utf='echo '\''Setting terminal to utf-8 mode'\''; print -n '\''\e%G'\'
    alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'
    alias which-command=whence
fi

# FreeBSD
if isFreeBSD; then
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
    alias lsd='command ls -d *(/)'
    alias lse='command ls -d *(/^F)'
    alias lsnew='command ls -rtlh *(D.om[1,10])'
    alias lsnewdir='command ls -rthdl *(/om[1,10]) .*(D/om[1,10])'
    alias lsold='command ls -rtlh *(D.Om[1,10])'
    alias lsolddir='command ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])'
    alias lssmall='command ls -Srl *(.oL[1,10])'
    alias mq='hg -R $(readlink -f $(hg root)/.hg/patches)'
    alias rmcdir='cd ..; rmdir $OLDPWD || cd $OLDPWD'
    alias term2iso='echo '\''Setting terminal to iso mode'\'' ; print -n '\''\e%@'\'
    alias term2utf='echo '\''Setting terminal to utf-8 mode'\''; print -n '\''\e%G'\'
    alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'
fi

if isOpenBSD; then
    alias ...='cd ../../'
    alias da='du -sch'
    alias dir='command ls -lSrah'
    alias insecscp='scp -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
    alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
    alias l='command ls -l'
    alias la='command ls -la'
    alias lad='command ls -d .*(/)'
    alias lh='command ls -hAl'
    alias ll='command ls -l'
    alias ls='command ls'
    alias lsa='command ls -a .*(.)'
    alias lsd='command ls -d *(/)'
    alias lse='command ls -d *(/^F)'
    alias lsnew='command ls -rtlh *(D.om[1,10])'
    alias lsnewdir='command ls -rthdl *(/om[1,10]) .*(D/om[1,10])'
    alias lsold='command ls -rtlh *(D.Om[1,10])'
    alias lsolddir='command ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])'
    alias lssmall='command ls -Srl *(.oL[1,10])'
    alias mq='hg -R $(readlink -f $(hg root)/.hg/patches)'
    alias rmcdir='cd ..; rmdir $OLDPWD || cd $OLDPWD'
    alias term2iso='echo '\''Setting terminal to iso mode'\'' ; print -n '\''\e%@'\'
    alias term2utf='echo '\''Setting terminal to utf-8 mode'\''; print -n '\''\e%G'\'
    alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'
fi

#NetBSD
if isNetBSD; then
    alias ...='cd ../../'
    alias da='du -sch'
    alias dir='command ls -lSrah'
    alias insecscp='scp -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
    alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
    alias l='command ls -l'
    alias la='command ls -la'
    alias lad='command ls -d .*(/)'
    alias lh='command ls -hAl'
    alias ll='command ls -l'
    alias ls='command ls'
    alias lsa='command ls -a .*(.)'
    alias lsd='command ls -d *(/)'
    alias lse='command ls -d *(/^F)'
    alias lsnew='command ls -rtlh *(D.om[1,10])'
    alias lsnewdir='command ls -rthdl *(/om[1,10]) .*(D/om[1,10])'
    alias lsold='command ls -rtlh *(D.Om[1,10])'
    alias lsolddir='command ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])'
    alias lssmall='command ls -Srl *(.oL[1,10])'
    alias mq='hg -R $(readlink -f $(hg root)/.hg/patches)'
    alias rmcdir='cd ..; rmdir $OLDPWD || cd $OLDPWD'
    alias term2iso='echo '\''Setting terminal to iso mode'\'' ; print -n '\''\e%@'\'
    alias term2utf='echo '\''Setting terminal to utf-8 mode'\''; print -n '\''\e%G'\'
    alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'
fi

# DragonFly
if isDragonFly; then
    unset zle_bracketed_paste
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
    alias lsd='command ls -d *(/)'
    alias lse='command ls -d *(/^F)'
    alias lsnew='command ls -rtlh *(D.om[1,10])'
    alias lsnewdir='command ls -rthdl *(/om[1,10]) .*(D/om[1,10])'
    alias lsold='command ls -rtlh *(D.Om[1,10])'
    alias lsolddir='command ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])'
    alias lssmall='command ls -Srl *(.oL[1,10])'
    alias mq='hg -R $(readlink -f $(hg root)/.hg/patches)'
    alias rmcdir='cd ..; rmdir $OLDPWD || cd $OLDPWD'
    alias term2iso='echo '\''Setting terminal to iso mode'\'' ; print -n '\''\e%@'\'
    alias term2utf='echo '\''Setting terminal to utf-8 mode'\''; print -n '\''\e%G'\'
    alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'
fi
