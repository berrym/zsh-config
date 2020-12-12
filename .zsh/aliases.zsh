# aliases.zsh - Load aliases based on OS detection
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>


print - "Detecting OS to load aliases."

if [[ isLinux ]]; then
    local ALIASFILE=${ALIASDIR}/linux-aliases.zsh
    if [[ -r  $ALIASFILE ]]; then
        print - "Loading aliases from $ALIASFILE"
        . $ALIASFILE
    else
        print - "Unable to source $ALIASFILE"
    fi
elif [[ isDarwin ]]; then
    local ALIASFILE=${ALIASDIR}/darwin-aliases.zsh
    if [[ -r  $ALIASFILE ]]; then
        print - "Loading aliases from $ALIASFILE"
        . $ALIASFILE
    else
        print - "Unable to source $ALIASFILE"
    fi
elif [[ isFreeBSD ]]; then
    local ALIASFILE=${ALIASDIR}/freebsd-aliases.zsh
    if [[ -r  $ALIASFILE ]]; then
        print - "Loading aliases from $ALIASFILE"
        . $ALIASFILE
    else
        print - "Unable to source $ALIASFILE"
    fi
elif [[ isOpenBSD ]]; then
    local ALIASFILE=${ALIASDIR}/openbsd-aliases.zsh
    if [[ -r  $ALIASFILE ]]; then
        print - "Loading aliases from $ALIASFILE"
        . $ALIASFILE
    else
        print - "Unable to source $ALIASFILE"
    fi
elif [[ isNetBSD ]]; then
    local ALIASFILE=${ALIASDIR}/netbsd-aliases.zsh
    if [[ -r $ALIASFILE ]]; then
        print - "Loading aliases from $ALIASFILE"
        . $ALIASFILE
    else
        print - "Unable to source $ALIASFILE"
    fi
elif [[ isDragonFly ]]; then
    local ALIASFILE=${ALIASDIR}/dragonfly-aliases.zsh
    if [[ -r $ALIASFILE ]]; then
        print - "Loading aliases from $ALIASFILE"
        . $ALIASFILE
    else
        print - "Unable to source $ALIASFILE"
    fi
fi
