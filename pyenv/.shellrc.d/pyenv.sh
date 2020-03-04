export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi


# DESC: activate a virtual-env
# ARGS: $1 (required): the name of the virtual-env
# NOTE: don't use $(pyenv virtualenv-init) because this
#       causes pyenv-sh-activate to be called every time
#       a command is executed on the command line
function workon () {
    local env="${1:-}"
    local act="$HOME/.pyenv/versions/$env/bin/activate"
    if [[ -f "$act" ]]; then
        source "$act"
    else
        echo "no directory: $act" 2>&1
        return 2
    fi
}
