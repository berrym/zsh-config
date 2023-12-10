# third-party.zsh - third party z shell extensions
#
# (c) 2023 Michael Berry <trismegustis@gmail.com>

local -a third_party_scripts=(
    $ZSH_THIRD_PARTY_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh
    $ZSH_THIRD_PARTY_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
)

for f in $third_party_scripts; do
    [[ -r $f ]] && . $f
done
