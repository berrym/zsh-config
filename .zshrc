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
typeset -U path
path=(~/bin
      /usr/local/bin
      /usr/local/sbin
      /usr/bin
      /usr/sbin
      /bin
      /sbin
      $path)
LANG=en_US.UTF-8
CHARSET=en_US.UTF-8
OSNAME=$(uname -s)        # Determine OS

if isLinux; then
    ;
elif isDarwin; then
    path=($path /usr/x11/bin)
    # HomeBrew GitHub Key
    export HOMEBREW_GITHUB_API_TOKEN=60f48f8a8684dcd786edd0011cb61b39fd7aacb6
    export HOMEBREW_CC=clang
elif isFreeBSD; then
    path=($path /usr/X11R6/bin)
    hash -d ports=/usr/ports
    hash -d src=/usr/src
elif isOpenBSD; then
    path=($path /usr/X11R6/bin)
    TERM=xterm-xfree86
    hash -d ports=/usr/ports
    hash -d src=/usr/src
    hash -d xenocara=/usr/xenocara
elif isNetBSD; then
    path=($path /usr/pkg/bin /usr/X11R7/bin)
    hash -d pkgsrc=/usr/pkgsrc
fi

# Set pager
command -v less &>/dev/null
if [[ $? -eq 0 ]]; then
    PAGER=less
else
    PAGER=more
fi

# Check for the mg editor, else default to vi
command -v mg &>/dev/null
if [[ $? -eq 0 ]]; then
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
autoload -Uz compaudit compinit && compaudit && compinit
zmodload -i zsh/complist

setopt hash_list_all          # hash everything before completion
setopt auto_menu              # use menu completion
setopt completealiases        # complete aliases
setopt complete_in_word       # complete within a word or phrase
setopt always_to_end          # move cursor to end of completion
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
if [[ -r .ssh/known_hosts ]]; then
    hosts=($(((awk '{print $1}' .ssh/known_hosts | tr , '\n'); ) | sort -u))
fi
zstyle ':completion:*' hosts $hosts

# run rehash on completion so newly installed programs are found automatically
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
    setopt PROMPT_SUBST       # needed for vcs_info_msg_0_
    color="blue"
    if [[ "$USER" == "root" ]]; then
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
if [[ -z $HISTFILE ]]; then
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
setopt share_history          # share history between sessions
setopt bang_hist              # ! syntax to access history

# Misc options
setopt auto_cd                # if command is a path, cd into it
setopt auto_remove_slash      # self explicit
setopt correct_all            # try to correct spelling of commands
setopt extended_glob          # activate complex pattern globbing
setopt noclobber              # don't overwrite file, use >! to do so
setopt longlistjobs           # display pid when suspending
setopt notify                 # report status of background jobs
setopt interactivecomments    # turn on comments
setopt hash_list_all          # hash command path before completion
setopt complete_in_word       # complete at any place in a word
setopt nobeep                 # no bell on error
setopt nohup                  # no hup signal at shell exit
setopt noglobdots             # don't match dotfiles
setopt noshwordsplit          # use zsh style word splitting
setopt no_bg_nice             # don't lower priority for background jobs
setopt no_rm_star_silent      # confirm an `rm *' or `rm path/*'
setopt unset
unsetopt print_exit_value     # do not print return value if non-zero

# Print more information to user if positive
VERBOSE=1
verbose() {
    [[ $VERBOSE -gt 0 ]]
}

# utility functions
# this function checks if a command exists and returns either true
# or false. This avoids using 'which' and 'whence', which will
# avoid problems with aliases for which on certain weird systems. :-)
# Usage: check_com [-c|-g] word
#   -c  only checks for external commands
#   -g  does the usual tests and also checks for global aliases
check_com () {
    emulate -L zsh

    local -i comonly gatoo
    comonly=0
    gatoo=0

    if [[ $1 == '-c' ]] ; then
	comonly=1
	shift 1
    elif [[ $1 == '-g' ]] ; then
	gatoo=1
	shift 1
    fi

    if (( ${#argv} != 1 )) ; then
	printf 'usage: check_com [-c|-g] <command>\n' >&2
	return 1
    fi

    if (( comonly > 0 )) ; then
	(( ${+commands[$1]}  )) && return 0
	return 1
    fi

    if     (( ${+commands[$1]}    )) \
	|| (( ${+functions[$1]}   )) \
	|| (( ${+aliases[$1]}     )) \
	|| (( ${+reswords[(r)$1]} )) ; then
	return 0
    fi

    if (( gatoo > 0 )) && (( ${+galiases[$1]} )) ; then
	return 0
    fi

    return 1
}

# Switch to a directoy the list it's contents
cl() {
    emulate -L zsh

    if [[ $ARGC -ne 1 ]]; then
	print 'usage: cl <directory>'
	return 1;
    fi

    if [[ -d $1 ]]; then
	cd $1 && ls -a
    else
	if verbose; then
	    print "directory \`$1' does not exist.\n"
	fi
    fi
}

# Print a list of modified files
modified () {
    print -l -- *(m-${1:-1})
}

# Switch to directory, create it if necessary
mkcd() {
    emulate -L zsh

    if [[ $ARGC -ne 1 ]]; then
	print 'usage: mkcd <new-directory>\n'
	return 1;
    fi

    if [[ ! -d $1 ]]; then
	command mkdir -p $1
	if verbose; then
	    printf 'created directory `%s'\'', cd-ing into it.\n' "$1"
	fi
    else
	if verbose; then
	    printf '`%s'\'' already exists: cd-ing into directory.\n' "$1"
	fi
    fi

    cd $1
}

# Switch to LABDIR root directory or a project subdir, create it if needed
lab() {
    emulate -L zsh

    local LABDIR=$HOME/Lab

    if [[ $ARGC -eq 0 ]]; then
	mkcd $LABDIR
    elif [[ $ARGC -eq 1 ]]; then
	mkcd $LABDIR/$1
    else
	print 'usage: lab <directory>\n'
    fi
}

# Usage: simple-extract <file>
# Using option -d deletes the original archive file.
#f5# Smart archive extractor
simple-extract() {
    emulate -L zsh

    setopt extended_glob noclobber

    local ARCHIVE DELETE_ORIGINAL DECOMP_CMD
    local USES_STDIN USES_STDOUT GZTARGET WGET_CMD
    local RC=0

    zparseopts -D -E "d=DELETE_ORIGINAL"
    for ARCHIVE in "${@}"; do
	case $ARCHIVE in
	    *(tar.bz2|tbz2|tbz))
		DECOMP_CMD="tar -xvjf -"
		USES_STDIN=true
		USES_STDOUT=false
		;;
	    *(tar.gz|tgz))
		DECOMP_CMD="tar -xvzf -"
		USES_STDIN=true
		USES_STDOUT=false
		;;
	    *(tar.xz|txz|tar.lzma))
		DECOMP_CMD="tar -xvJf -"
		USES_STDIN=true
		USES_STDOUT=false
		;;
	    *tar)
		DECOMP_CMD="tar -xvf -"
		USES_STDIN=true
		USES_STDOUT=false
		;;
	    *rar)
		DECOMP_CMD="unrar x"
		USES_STDIN=false
		USES_STDOUT=false
		;;
	    *lzh)
		DECOMP_CMD="lha x"
		USES_STDIN=false
		USES_STDOUT=false
		;;
	    *7z)
		DECOMP_CMD="7z x"
		USES_STDIN=false
		USES_STDOUT=false
		;;
	    *(zip|jar))
		DECOMP_CMD="unzip"
		USES_STDIN=false
		USES_STDOUT=false
		;;
	    *deb)
		DECOMP_CMD="ar -x"
		USES_STDIN=false
		USES_STDOUT=false
		;;
	    *bz2)
		DECOMP_CMD="bzip2 -d -c -"
		USES_STDIN=true
		USES_STDOUT=true
		;;
	    *(gz|Z))
		DECOMP_CMD="gzip -d -c -"
		USES_STDIN=true
		USES_STDOUT=true
		;;
	    *(xz|lzma))
		DECOMP_CMD="xz -d -c -"
		USES_STDIN=true
		USES_STDOUT=true
		;;
	    *)
		print "ERROR: '$ARCHIVE' has unrecognized archive type." >&2
		RC=$((RC+1))
		continue
		;;
	esac

	if ! check_com ${DECOMP_CMD[(w)1]}; then
	    echo "ERROR: ${DECOMP_CMD[(w)1]} not installed." >&2
	    RC=$((RC+2))
	    continue
	fi

	GZTARGET="${ARCHIVE:t:r}"
	if [[ -f $ARCHIVE ]] ; then

	    print "Extracting '$ARCHIVE' ..."
	    if $USES_STDIN; then
		if $USES_STDOUT; then
		    ${=DECOMP_CMD} < "$ARCHIVE" > $GZTARGET
		else
		    ${=DECOMP_CMD} < "$ARCHIVE"
		fi
	    else
		if $USES_STDOUT; then
		    ${=DECOMP_CMD} "$ARCHIVE" > $GZTARGET
		else
		    ${=DECOMP_CMD} "$ARCHIVE"
		fi
	    fi
	    [[ $? -eq 0 && -n "$DELETE_ORIGINAL" ]] && rm -f "$ARCHIVE"

	elif [[ "$ARCHIVE" == (#s)(https|http|ftp)://* ]] ; then
	    if check_com curl; then
		WGET_CMD="curl -L -s -o -"
	    elif check_com wget; then
		WGET_CMD="wget -q -O -"
	    elif check_com fetch; then
		WGET_CMD="fetch -q -o -"
	    else
		print "ERROR: neither wget, curl nor fetch is installed" >&2
		RC=$((RC+4))
		continue
	    fi
	    print "Downloading and Extracting '$ARCHIVE' ..."
	    if $USES_STDIN; then
		if $USES_STDOUT; then
		    ${=WGET_CMD} "$ARCHIVE" | ${=DECOMP_CMD} > $GZTARGET
		    RC=$((RC+$?))
		else
		    ${=WGET_CMD} "$ARCHIVE" | ${=DECOMP_CMD}
		    RC=$((RC+$?))
		fi
	    else
		if $USES_STDOUT; then
		    ${=DECOMP_CMD} =(${=WGET_CMD} "$ARCHIVE") > $GZTARGET
		else
		    ${=DECOMP_CMD} =(${=WGET_CMD} "$ARCHIVE")
		fi
	    fi

	else
	    print "ERROR: '$ARCHIVE' is neither a valid file nor a supported URI." >&2
	    RC=$((RC+8))
	fi
    done
    return $RC
}

# Load aliases
if [[ -r ~/.aliasrc ]]; then
    . ~/.aliasrc
fi
