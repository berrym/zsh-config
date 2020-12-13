# aliases.zsh - Load aliases based on OS detection
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>


print - "Detecting OS to load aliases."

if isLinux; then
    ALIASFILE=${ALIASDIR}/linux-aliases.zsh
elif isDarwin; then
    ALIASFILE=${ALIASDIR}/darwin-aliases.zsh
elif isFreeBSD; then
    ALIASFILE=${ALIASDIR}/freebsd-aliases.zsh
elif isOpenBSD; then
    ALIASFILE=${ALIASDIR}/openbsd-aliases.zsh
elif isNetBSD; then
    ALIASFILE=${ALIASDIR}/netbsd-aliases.zsh
elif isDragonFly; then
    ALIASFILE=${ALIASDIR}/dragonfly-aliases.zsh
fi

if [[ -r $ALIASFILE ]]; then
    print - "Loading aliases from $ALIASFILE"
    . $ALIASFILE
else
    print - "Unable to source $ALIASFILE"
fi
