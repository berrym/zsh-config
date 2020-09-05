# aliases.zsh - Load aliases based on OS detection
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>

declare -A funcs
funcs=(
    $(isLinux)     ${ALIASDIR}/linux-aliases.zsh
    $(isDarwin)    ${ALIASDIR}/darwin-aliases.zsh
    $(isFreeBSD)   ${ALIASDIR}/freebsd-aliases.zsh
    $(isOpenBSD)   ${ALIASDIR}/openbsd-aliases.zsh
    $(isNetBSD)    ${ALIASDIR}/netbsd-aliases.zsh
    $(isDragonFly) ${ALIASDIR}/dragonfly-aliases.zsh
)

for func script in ${(kv)funcs}; do
    if [[ $func ]]; then
        if [[ -r $script ]]; then
            . $script
        else
            print "Unable to source $script"
        fi
        break
    fi
done
