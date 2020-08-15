# Load aliases based on OS
ALIASDIR=${ZDOTDIR:-$ZSHDIR}/aliases

# GNU/Linux
if isLinux; then
    if [[ -r ${ALIASDIR}/linux-aliases.zsh ]]; then
       . ${ALIASDIR}/linux-aliases.zsh
    fi
fi

# Mac
if isDarwin; then
    if [[ -r ${ALIASDIR}/darwin-aliases.zsh ]]; then
	. ${ALIASDIR}/darwin-aliases.zsh
    fi
fi

# FreeBSD
if isFreeBSD; then
    if [[ -r ${ALIASDIR}/freebsd-aliases.zsh ]]; then
	. ${ALIASDIR}/freebsd-aliases.zsh
    fi
fi

# OpenBSD
if isOpenBSD; then
    if [[ -r ${ALIASDIR}/openbsd-aliases.zsh ]]; then
	. ${ALIASDIR}/openbsd-aliases.zsh
    fi
fi

# NetBSD
if isNetBSD; then
    if [[ -r ${ALIASDIR}/netbsd-aliases.zsh ]]; then
	. ${ALIASDIR}/netbsd-aliases.zsh
    fi
fi

# DragonFly
if isDragonFly; then
    if [[ -r ${ALIASDIR}/dragonfly-aliases.zsh ]]; then
	. ${ALIASDIR}/dragonfly-aliases.zsh
    fi
fi
