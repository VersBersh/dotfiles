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
    version=''
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

    local info_style="$fg_cyan$ta_bold"
    local warn_style="$fg_yellow$ta_emph"

    parse_params "$@"

    export PYENV_ROOT="$HOME/.pyenv"
    if [[ -d "$PYENV_ROOT" ]]; then
        pretty_print "pyenv already installed" "$warn_style"
    else
        pretty_print "install python dependencies..." "$info_style"
        sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
            libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
            libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev \
            liblzma-dev python-openssl git

        pretty_print "cloning pyenv from github" "$info_style"
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    fi

    if [ -n "$version" ]; then
        pretty_print "installing python version $version" "$info_style"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"

        pyenv install "$version"
    fi
    unset version

    if $virtualenv; then
        pretty_print "installing pyenv-virtualenv plugin" "$info_style"
        plugin_dir="$HOME/.pyenv/plugins/pyenv-virtualenv"
        git clone https://github.com/pyenv/pyenv-virtualenv.git "$plugin_dir"
    fi
    unset virtualenv
}


main "$@"
