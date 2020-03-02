# shellcheck shell=sh

# General configuration common to all shells we use
# Should be compatible with at least: sh, bash & zsh

# Preferred text editors ordered by priority (space-separated)
EDITOR_PRIORITY='vim vi nano pico'

# Locations to prefix to PATH (colon-separated)
EXTRA_PATHS=''

# -----------------------------------------------------------------------------

# Guess the dotfiles directory if $dotfiles wasn't set
if [ -z "${dotfiles-}" ]; then
    if [ -d "$HOME/dotfiles" ]; then
        dotfiles="$HOME/dotfiles"
    else
        # shellcheck disable=SC2016
        echo 'Error: $dotfiles unset and unable to guess dotfiles directory!'
        return
    fi
fi


# Set our preferred editor
if [ -n "$EDITOR_PRIORITY" ]; then
    for editor in $EDITOR_PRIORITY; do
        editor_path="$(command -v "$editor")"
        if [ -n "$editor_path" ]; then
            export EDITOR="$editor_path"
            export VISUAL="$editor_path"
            break
        fi
    done
fi
unset EDITOR_PRIORITY editor editor_path


# Include any custom aliases
sh_aliases_file="$dorfiles/sh/aliases.sh"
if [ -f "$sh_aliases_file" ]; then
    # shellcheck source=sh/aliases.sh
    . "$sh_aliases_file"
fi
unset sh_aliases_file sh_dir


# Use stderred if it's available
USE_STDERRED=1

# Load stderred if requested and it's present
stderred_path='/usr/local/lib/libstderred.so'
if [ -n "${USE_STDERRED-}" ]; then
    if [ -f "$stderred_path" ]; then
       build_path "$stderred_path" "$LD_PRELOAD"
        # shellcheck disable=SC2154
        export LD_PRELOAD="$build_path"
    fi
fi
unset USE_STDERRED stderred_path

echo DONE!
# vim: syntax=sh cc=80 tw=79 ts=4 sw=4 sts=4 et sr
