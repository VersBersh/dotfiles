#!/usr/bin/env bash

# shellcheck shell=sh

# General configuration common to all shells we use
# Should be compatible with at least sh, bash, and zsh
# includes configuration for ubuntu built-ins such as apt-get

# Preferred text editors ordered by priority (space-separated)
EDITOR_PRIORITY=(vim vi nano pico)

# Locations to prefix to PATH (colon-separated)
EXTRA_PATHS=''

# -----------------------------------------------------------------------------

# Set our preferred editor
if [ -n "${EDITOR_PRIORITY[*]}" ]; then
    for editor in "${EDITOR_PRIORITY[@]}"; do
        editor_path="$(command -v "$editor")"
        if [ -n "$editor_path" ]; then
            export EDITOR="$editor_path"
            export VISUAL="$editor_path"
            break
        fi
    done
fi
unset EDITOR_PRIORITY editor editor_path

# useful aliases
alias svim='sudo vim -S ~/.vimrc'

# apt configuration
if command -v apt-get > /dev/null; then
    # Super useful alias to determine manually installed packages
    # Via: https://askubuntu.com/questions/2389/generating-list-of-manually-installed-packages-and-querying-individual-packages
    alias apt-pkgs='comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n "s/^Package: //p" | sort -u)'
fi


# lesspipe configuration
if command -v lesspipe > /dev/null; then
    # Setup lesspipe for handling non-text input
    eval "$(lesspipe)"
fi


# sudo configuration
if command -v sudo > /dev/null; then
    # Enables expansion of the subsequent command if it's an alias
    # See: https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
    alias sudo='sudo '
fi


# vim: syntax=sh cc=80 tw=79 ts=4 sw=4 sts=4 et sr
