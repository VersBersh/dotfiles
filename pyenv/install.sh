
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
    while [[ $# -gt 0 ]]; do
        param="$1"
        shift
        case $param in
            --version)
                shift
                version=$1
                ;;
            *)
                script_exit "Invalid parameter was provided: $param" 1
                ;;
        esac
    done
}


function main()
{   
    parse_params "$@"
   
    # clone the repo
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    
    # if a version is given install it
    if [ -n "$version" ]; then
        PYENV_ROOT="$HOME/.pyenv
        PATH="$PYENV_ROOT/bin:$PATH
        eval "$(pyenv init -)"
        
        pyenv install "$version"
    fi
}


main "$@"

