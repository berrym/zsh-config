# .zprofile - z login shell config file
#
# (c) 2023 Michael Berry <trismegustis@gmail.com>

umask 022

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
