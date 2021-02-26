# aliases.zsh - Load aliases based on OS detection
#
# (c) 2021 Michael Berry <trismegustis@gmail.com>

if isLinux; then
    ALIASFILE=$ALIASDIR/linux-aliases.zsh
elif isDarwin; then
    ALIASFILE=$ALIASDIR/darwin-aliases.zsh
elif isFreeBSD; then
    ALIASFILE=$ALIASDIR/freebsd-aliases.zsh
elif isOpenBSD; then
    ALIASFILE=$ALIASDIR/openbsd-aliases.zsh
elif isNetBSD; then
    ALIASFILE=$ALIASDIR/netbsd-aliases.zsh
elif isDragonFly; then
    ALIASFILE=$ALIASDIR/dragonfly-aliases.zsh
fi

if [[ -r $ALIASFILE ]]; then
    . $ALIASFILE
fi
