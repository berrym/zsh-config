# zshopts - z shell options
#
# (c) 2023 Michael Berry <trismegustis@gmail.com>

# Gain access to online help
autoload -Uz run-help
HELPDIR=/usr/local/share/zsh/help

autoload -Uz zsh-mime-setup select-word-style
zsh-mime-setup                # run everything like an executable
select-word-style bash        # [ctrl]+w on words

# Keybindingds
bindkey -e                    # Emacs style keybindings

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '\e[A' up-line-or-beginning-search   # up arrow
bindkey '\e[B' down-line-or-beginning-search # down arrow
bindkey '^[[1;5C' forward-word               # ctrl+[right arrow]
bindkey '^[[1;5D' backward-word              # ctrl+[left arrow]

bindkey '\ew' kill-region     # esc+w kill from cursor to mark
bindkey -s '\el' 'ls\n'       # esc+l execute ls command

# Configure completions
zmodload -i zsh/complist
autoload -Uz compaudit compinit && compaudit && compinit

setopt hash_list_all          # hash everything before completion
setopt auto_menu              # use menu completion
setopt completealiases        # complete aliases
setopt complete_in_word       # complete within a word or phrase
setopt always_to_end          # move cursor to end of completion
setopt always_last_prompt     # return to last prompt
setopt list_ambiguous         # complete until completion is ambiguous

zstyle ':completion::complete:*' use-cache yes # completion caching
zstyle ':completion::complete:*' cache-path $HOME/.cache/zsh
zstyle ':completion::complete:*' list-colors
zstyle ':completion::complete:*' menu select
zstyle ':completion::complete:*' menu yes

# use approximate completion
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors \
       'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' auto-description 'specify %d'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select ${(s.:.)LS_COLORS}

# kill completion menu
zstyle ':completion:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors ${(s.:.)LS_COLORS}

# killall menu
zstyle ':completion:*:killall:*' force-list always
zstyle ':completion:*:default' list_prompt
zstyle ':completion:*:processes-names' list-colors \
       command 'ps c -u ${USER} -o command | uniq'

# format descriptions
zstyle ':completion:descriptions' format "%{$fg[cyan]%}"

# provide verbose completion information
zstyle ':completion:*' verbose yes

# complete manuals by sections
zstyle ':completion:*:manuals' seperate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:man:*' menu yes select

# start menu completion if no unambiguous initial string was found
zstyle ':completion:*:correct:*' insert-unambiguous true
zstyle ':completion:*:corrections' format "%{$fg[red]%}%d (errors: %e)%{$reset_color%}"
zstyle ':completion:*:correct:*' original true

# format on completion
zstyle ':completion:*:descriptions' format "%{$fg[cyan]%}completing %B%d%b%{$reset_color%}"

# automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
# disable named-directories autocompletion
zstyle ':completion:*:cd*' tag-order local-directories directory-stack path-directories

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:history-words' list false
# activate menu
zstyle ':completion:*:history-words' menu yes
# ignore duplicate entries
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' stop yes

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# separate matches into groups
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''

if [[ "$NOMENU" -eq 0 ]] ; then
    # if there are more than 5 options allow selecting from a menu
    zstyle ':completion:*' menu select=5
else
    # don't use any menus at all
    setopt no_auto_menu
fi
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:options' auto-description '%d'

# describe options in full
zstyle ':completion:*:options' description 'yes'

# on processes completion complete all user processes
zstyle ':completion:*:processes' command 'ps -au$USER'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# provide verbose completion information
zstyle ':completion:*' verbose true

# recent (as of Dec 2007) zsh versions are able to provide descriptions
# for commands (read: 1st word in the line) that it will list for the user
# to choose from. The following disables that, because it's not exactly fast.
zstyle ':completion:*:-command-:*:' verbose false

# set format for warnings
zstyle ':completion:*:warnings' format $'%{$fg[red]%}No matches for:%{$reset_color%} %d'

# define files to ignore for zcompile
zstyle ':completion:*:*:zcompile:*' ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:' prompt 'correct to: %e'

# Ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# Search path for sudo/doas completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
       /usr/local/bin  \
       /usr/sbin       \
       /usr/bin        \
       /sbin           \
       /bin            \
       /usr/pkg/bin    \
       /usr/X11R6/bin

hosts=/dev/null
if [[ -r .ssh/known_hosts ]]; then
    hosts=($(((awk '{print $1}' .ssh/known_hosts | tr , '\n'); ) | sort -u))
fi
zstyle ':completion:*' hosts $hosts

# run rehash on completion so newly installed programs are found automatically
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1
}

bindkey -M menuselect '^o' accept-and-infer-next-history

# pushd
setopt auto_pushd             # make cd push old dir on dir stack
setopt pushd_ignore_dups      # no duplicates in dir stack
setopt pushd_silent           # no dir stack after pushd or popd
setopt pushd_to_home          # `pushd` = `pushd $HOME`

# history
setopt append_history         # append history
setopt hist_ignore_dups       # ignore duplicates
setopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks     # trim blanks
setopt hist_verify            # show command before executing history
setopt inc_append_history     # immediately add commands
setopt share_history          # share history between sessions
setopt bang_hist              # ! syntax to access history

# misc options
setopt autocd                 # if command is a path, cd into it
setopt auto_remove_slash      # remove trailing slash
setopt correct                # try to correct spelling of commands
setopt extended_glob          # activate complex pattern globbing
setopt noclobber              # don't overwrite file, use >! to do so
setopt longlistjobs           # display pid when suspending
setopt notify                 # report status of background jobs
setopt interactivecomments    # turn on comments
setopt hash_list_all          # hash command path before completion
setopt complete_in_word       # complete at any place in a word
setopt nobeep                 # no bell on error
setopt nohup                  # no hup signal at shell exit
setopt noglobdots             # don't match dotfiles
setopt noshwordsplit          # use zsh style word splitting
setopt no_bg_nice             # don't lower priority for background jobs
setopt no_rm_star_silent      # confirm an `rm *' or `rm path/*'
setopt unset
unsetopt print_exit_value     # do not print return value if non-zero
