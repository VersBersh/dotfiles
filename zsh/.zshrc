#!/usr/bin/env zsh

# Path to oh-my-zsh configuration
ZSH="$HOME/.oh-my-zsh"

# Name of the oh-my-zsh theme to load
if [[ -d $ZSH/custom/themes/oliver ]]; then
    ZSH_THEME="oliver"
else
    ZSH_THEME="agnoster"
fi

export LANG=en_AU.UTF-8

# make arrays index from zero
setopt KSH_ARRAYS

# Enable case-sensitive completion
CASE_SENSITIVE="true"

# Disable automatic update checks
DISABLE_AUTO_UPDATE="true"

# How often auto-update checks occur
# export UPDATE_ZSH_DAYS=13

# Disable autosetting terminal title
# DISABLE_AUTO_TITLE="true"

# Disable command autocorrection
DISABLE_CORRECTION="true"

# Display red dots while waiting
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
plugins=(colored-man-pages gitfast shrink-path)

# Actually load oh-my-zsh with our settings
source "$ZSH/oh-my-zsh.sh"

# Disable the auto_cd option enabled by oh-my-zsh
unsetopt auto_cd

# Create a zkbd compatible hash populating it via the terminfo array
typeset -g -A key
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Home]=${terminfo[home]}
key[End]=${terminfo[kend]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}

# Set Insert/Delete keys to insert/delete chars on line
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char

# Set Home/End keys to jump to beginning/end of line
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line

# Use any entered text as the prefix for searching command history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" history-search-backward
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" history-search-forward

# Set Ctrl+Left-arrow/Ctrl+Right-arrow to move to adjacent word
bindkey "\e[D" backward-word
bindkey "\e[C" forward-word
bindkey "\e[1;2D" backward-word
bindkey "\e[1;2C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word

# Make sure the terminal is in application mode when zle is active
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

#################################
### Common and Custom Configs ###
#################################

# Load configs common to bash and zsh and any custom
# configs specific to a particular app or system
SRC_DIR=$(dirname ${(%):-%x})

for file in $(find $SRC_DIR/.shellrc.d -type f,l); do
    if [[ $(basename "$file") != ".gitignore" ]]; then
        source "$file"
    fi
done
 

# vim: syntax=zsh cc=80 tw=79 ts=4 sw=4 sts=4 et sr
