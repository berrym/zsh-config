# aliases.zsh - Load aliases based on OS detection
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>


print - "Detecting OS to load aliases."

if [[ $OSNAME == "Linux" ]]; then
    ALIASFILE=${ALIASDIR}/linux-aliases.zsh
    if [[ -r $ALIASFILE ]]; then
        print - "Loading aliases from $ALIASFILE"
        . $ALIASFILE
    else
        print - "Unable to source $ALIASFILE"
    fi
elif [[ $OSNAME == "OpenBSD" ]]; then
    ALIASFILE=${ALIASDIR}/darwin-aliases.zsh
    if [[ -r $ALIASFILE ]]; then
        print - "Loading aliases from $ALIASFILE"
        . $ALIASFILE
    else
        print - "Unable to source $ALIASFILE"
    fi
elif [[ $OSNAME == "FreeBSD" ]]; then
    ALIASFILE=${ALIASDIR}/freebsd-aliases.zsh
    if [[ -r $ALIASFILE ]]; then
        print - "Loading aliases from $ALIASFILE"
        . $ALIASFILE
    else
        print - "Unable to source $ALIASFILE"
    fi
elif [[ $OSNAME == "OpenBSD" ]]; then
    ALIASFILE=${ALIASDIR}/openbsd-aliases.zsh
    if [[ -r $ALIASFILE ]]; then
        print - "Loading aliases from $ALIASFILE"
        . $ALIASFILE
    else
        print - "Unable to source $ALIASFILE"
    fi
elif [[ $OSNAME == "NetBSD" ]]; then
    ALIASFILE=${ALIASDIR}/netbsd-aliases.zsh
    if [[ -r $ALIASFILE ]]; then
        print - "Loading aliases from $ALIASFILE"
        . $ALIASFILE
    else
        print - "Unable to source $ALIASFILE"
    fi
elif [[ $OSNAME == "DragonFly" ]]; then
    ALIASFILE=${ALIASDIR}/dragonfly-aliases.zsh
    if [[ -r $ALIASFILE ]]; then
        print - "Loading aliases from $ALIASFILE"
        . $ALIASFILE
    else
        print - "Unable to source $ALIASFILE"
    fi
fi
