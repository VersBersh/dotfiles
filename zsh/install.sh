
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
    omz=false

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
    source "$HOME/dotfiles/scripts/utils.sh"
    colour_init

    local info_style="$fg_cyan$ta_bold"
    local warn_style="$fg_yellow$ta_emph"

    parse_params "$@"

    if [[ -z "${ZSH_VERSION-}" ]]; then
        sudo apt-get install zsh
    else
        pretty_print "ZSH is already installed!" "$warn_style"
    fi

    if $omz; then
        pretty_print "installing oh-my-zsh..." "$info_style"
        # --unattended: don't run zsh after install
        sh "$HOME/dotfiles/zsh/install_scripts/install-oh-my-zsh.sh" --unattended

        # remove .zshrc so we can stow our own
        echo "removing .zshrc"
        if [[ -f "$HOME/.zshrc" ]]; then
            rm "$HOME/.zshrc"
        fi
    fi
    unset omz

    pretty_print "changing the default shell to zsh" "$info_style"
    sudo chsh -s $(which zsh)
}


main "$@"
