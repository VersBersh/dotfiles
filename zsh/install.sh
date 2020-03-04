
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
            --oh-my-zsh)                
                omz=true
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
   
    apt-get install zsh
    
    # install oh-my-zsh
    if omz; then       
        sh "$HOME/dotfiles/zsh/install_scripts/install-oh-my-zsh.sh"
    fi
}


main "$@"
