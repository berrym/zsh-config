# .zprofile - z login shell config file
#
# (c) 2023 Michael Berry <trismegustis@gmail.com>

umask 022

# If one of the variables SSH_CLIENT or SSH_TTY is defined, it's an ssh session.
# If the login shell's parent process name is sshd, it's an ssh session.
SSH_SESSION=0
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    SSH_SESSION=1
else
    case $(ps -o comm= -p "$PPID") in
        sshd|*/sshd) SSH_SESSION=1;;
    esac
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
