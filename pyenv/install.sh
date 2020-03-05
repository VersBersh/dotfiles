#!/usr/bin/env bash

# A better class of script...
set -o errexit          # Exit on most errors (see the manual)
set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline
#set -o xtrace          # Trace the execution of the script (debug)


# DESC: Parameter parser
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: Variables indicating command-line parameters and options
function parse_params()
{
    local param
    virtualenv=false

    while [[ $# -gt 0 ]]; do
        param="$1"
        shift
        case $param in
            --version)
                version="$1"
                shift
                ;;
            --virtualenv)
                virtualenv=true
                ;;
            *)
                script_exit "Invalid parameter was provided: $param" 1
                ;;
        esac
    done
}


function main()
{
    source "$HOME/dotfiles/scripts/utils.sh"
    colour_init

    local style="$fg_cyan$ta_bold"

    parse_params "$@"

    pretty_print "install python dependencies..." "$style"
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev \
        liblzma-dev python-openssl git

    pretty_print "cloning pyenv from github" "$style"
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv

    if [ -n "${version-}" ]; then
        pretty_print "installing python version $version" "$style"
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"

        pyenv install "$version"
    fi

    if $virtualenv; then
        pretty_print "installing pyenv-virtualenv plugin" "$style"
        plugin_dir="$HOME/.pyenv/plugins/pyenv-virtualenv"
        git clone https://github.com/pyenv/pyenv-virtualenv.git "$plugin_dir"
    fi
}


main "$@"

