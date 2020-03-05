#! /usr/bin/env bassh

# A better class of script...
set -o errexit          # Exit on most errors (see the manual)
set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline
#set -o xtrace          # Trace the execution of the script (debug)


function main()
{
    source "$HOME/dotfiles/scripts/utils.sh"
    colour_init

    local info_style="$fg_cyan$ta_bold"
    local warn_style="$fg_yellow$ta_emph"

    local src_dir=/usr/local/src/stderred
    local lib_dir=/usr/local/lib

    if [[ -f "$lib_dir/libstderred.so" ]]; then
        pretty_print "stderred already installed" "$warn_style"
        script_exit "exiting install"  0
    fi

    if [[ -d "$src_dir" ]]; then
        script_exit "directory already exists! $src_dir" 2
    else
        sudo mkdir "$src_dir"
    fi

    pretty_print "installing build dependencies..." "$info_style"
    sudo apt-get install -y build-essential cmake

    pretty_print "cloning stderred..." "$info_style"
    sudo git clone git://github.com/sickill/stderred.git "$src_dir"

    pretty_print "building stderred..." "$info_style"
    cd "$src_dir"
    sudo make

    # put .so in /usr/local/share
    if ! [[ -f $src_dir/build/libstderred.so ]]; then
        script_exit "build failed!" 2
    else
        sudo ln -s "$src_dir/build/libstderred.so" $lib_dir
    fi
}


main "$@"

