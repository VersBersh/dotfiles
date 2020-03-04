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

    local src_dir=/usr/local/src/stderred
    local lib_dir=/usr/local/lib   

    if [[ -f "$lib_dir/libstderred.so" ]]; then
        pretty_print "stderred already installed" fg_yellow
        script_exit "exiting install"  0
    fi

    # dependencies
    apt-get install -y build-essential cmake   

    if [ -d "$src_dir" ]; then
        exit_script "directory stderred already exists!" 2
    else
        mkdir "$src_dir"
    fi

    git clone git://github.com/sickill/stderred.git "$src_dir"

    cd "$src_dir"
    make

    # put .so in /usr/local/share
    if ! [ -f $src_dir/build/libstderred.so ]; then
        exit_script "build failed!" 2
    else
        ln -s "$src_dir/build/libstderred.so" $lib_dir
    fi
}


main "$@"

