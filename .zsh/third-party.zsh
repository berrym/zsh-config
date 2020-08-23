# third-party.zsh - third party z shell extensions
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>

third_party_scripts=(
    ${ZDOTDIR:-$ZSH_THIRD_PARTY_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh
    ${ZDOTDIR:-$ZSH_THIRD_PARTY_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
)

for f in $third_party_scripts; do
    if [[ -r $f ]]; then
	. $f
    else
	print "Unable to load $f"
    fi
done
