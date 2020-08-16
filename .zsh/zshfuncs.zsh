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

# Completion for lab function
_lab() {
    local LABDIR=$HOME/Lab
    cd $LABDIR
    local SUBDIRS=(`ls -d */`)
    for d in $SUBDIRS; do
	compadd $d
    done
    popd
}

compdef _lab lab

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
simple-extract() {
    emulate -L zsh

    setopt extended_glob noclobber

    local ARCHIVE DELETE_ORIGINAL DECOMP_CMD PIPE_CMD
    local USES_STDIN USES_STDOUT USES_PIPE GZTARGET WGET_CMD
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
	    *rpm)
		DECOMP_CMD="rpm2cpio -"
		PIPE_CMD="cpio -idvm"
		USES_STDIN=true
		USES_STDOUT=true
		USES_PIPE=true
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
		    if $USES_PIPE; then
			${=DECOMP_CMD} < "$ARCHIVE" | ${=PIPE_CMD} > $GZTARGET
		    else
			${=DECOMP_CMD} < "$ARCHIVE" > $GZTARGET
		    fi
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
