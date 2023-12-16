# aliases.zsh - Load aliases based on OS detection
#
# (c) 2023 Michael Berry <trismegustis@gmail.com>

if isLinux; then
    ALIAS_FILE=$ALIAS_DIR/linux-aliases.zsh
elif isDarwin; then
    ALIAS_FILE=$ALIAS_DIR/darwin-aliases.zsh
elif isFreeBSD; then
    ALIAS_FILE=$ALIAS_DIR/freebsd-aliases.zsh
elif isOpenBSD; then
    ALIAS_FILE=$ALIAS_DIR/openbsd-aliases.zsh
elif isNetBSD; then
    ALIAS_FILE=$ALIAS_DIR/netbsd-aliases.zsh
elif isDragonFly; then
    ALIAS_FILE=$ALIAS_DIR/dragonfly-aliases.zsh
fi

[[ -r $ALIAS_FILE ]] && . $ALIAS_FILE
