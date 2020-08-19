local autosuggest=zsh-autosuggestions/zsh-autosuggestions.zsh
local syntax-highlighting=zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

third-party-scripts=(
    ${ZDOTDIR:-$ZSH_THIRD_PARTY_DIR}/$autosuggest
    ${ZDOTDIR:-$ZSH_THIRD_PARTY_DIR}/$syntax-highlighting
)

for f in $third_party_scripts; do
    . $f
done
