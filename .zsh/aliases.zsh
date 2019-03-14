# Load aliases based on OS

emulate -L zsh

ALIAS_DIR="${ZSH_DIR}/aliases"

fpath=($ALIAS_DIR $fpath)

#export ALIAS_DIR

# GNU/Linux
if isLinux; then
    if [[ -r ${ALIAS_DIR}/linux-aliases.zsh ]]; then
       . ${ALIAS_DIR}/linux-aliases.zsh
    fi
fi

# Mac
if isDarwin; then
    if [[ -r ${ALIAS_DIR}/darwin-aliases.zsh ]]; then
	. ${ALIAS_DIR}/darwin-aliases.zsh
    fi
fi

# FreeBSD
if isFreeBSD; then
    if [[ -r ${ALIAS_DIR}/freebsd-aliases.zsh ]]; then
	. ${ALIAS_DIR}/freebsd-aliases.zsh
    fi
fi

# OpenBSD
if isOpenBSD; then
    if [[ -r ${ALIAS_DIR}/openbsd-aliases.zsh ]]; then
	. ${ALIAS_DIR}/openbsd-aliases.zsh
    fi
fi

# NetBSD
if isNetBSD; then
    if [[ -r ${ALIAS_DIR}/netbsd-aliases.zsh ]]; then
	. ${ALIAS_DIR}/netbsd-aliases.zsh
    fi
fi

# DragonFly
if isDragonFly; then
    if [[ -r ${ALIAS_DIR}/dragonfly-aliases.zsh ]]; then
	. ${ALIAS_DIR}/dragonfly-aliases.zsh
    fi
fi
