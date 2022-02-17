#!/bin/zsh

export LC_ALL=en_US.UTF-8
export EDITOR=/usr/bin/nano
export PAGER=/usr/bin/less
export LESS=-R

export PATH=$HOME/.local/bin:$PATH
export TIME_STYLE="+%Y-%m-%d %H:%M:%S"

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE

export MAKEFLAGS="-j $(grep -c ^processor /proc/cpuinfo)"

# pacman -S zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting zsh-theme-powerlevel10k z
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

source /usr/share/z/z.sh

alias ls="$([ -f /usr/bin/lsd ] && echo '/usr/bin/lsd' || echo '/usr/bin/ls' ) --group-dirs=first"

[ -f /usr/bin/bat ] && alias cat="bat"

alias l="ls -lah"
alias ll="ls -lh"
alias la="ls -lAh"

alias cls="clear"

alias open="xdg-open 2>/dev/null"
alias o="open"

alias ytdl="youtube-dl"
alias mp3="youtube-dl --extract-audio --audio-format mp3"

alias ts="ts-node"
alias js="node"

alias gs="git status"                       # Git Status
alias gd="git diff"                         # Git Diff
alias gdc="git diff --cached"               # Git Diff Cached
alias gp="git push --follow-tags && clear"  # Git Push
alias gap="git add -p"                      # Git Add -P
alias gl="git log --stat"                   # Git Log
alias glp="git log -p"                      # Git Log -P
alias gls="git log --pretty='%s'"           # Git Log Short
alias glf="git log --name-status"           # Git Log Files
alias glgpg="git log --show-signature"      # Git Log with GPG signature

alias rgrep="rg"

alias sha="sha256sum"
alias ip="ip -color=auto"

alias zshrc="nano $HOME/.zshrc"
alias zshrc.local="nano $HOME/.zshrc.local"

zstyle ':completion:*' list-colors "${(s.:.)$(dircolors -b)}"
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' group-name '' # See https://bbs.archlinux.org/viewtopic.php?id=225303
zstyle ':completion:*' menu select

function du() {
    /usr/bin/du -hd 1 "$@" | sort -hr
}

function up() {
    if [[ "$1" == "-d" ]]; then
        sudo docker-compose up -d
    else
        DOCKER_HOST=unix:///run/user/1000/podman/podman.sock docker-compose up -d
    fi
}

function down() {
    if [[ "$1" == "-d" ]]; then
        sudo docker-compose down
    else
        DOCKER_HOST=unix:///run/user/1000/podman/podman.sock docker-compose down
    fi
}

function pull() {
    if [[ "$1" == "-d" ]]; then
        sudo docker-compose pull
    else
        DOCKER_HOST=unix:///run/user/1000/podman/podman.sock docker-compose pull
    fi
}

function images() {
    if [[ "$1" == "-d" ]]; then
        sudo docker images | grep -v REPOSITORY | awk '{print $1":"$2}' | xargs -L1 sudo docker pull
    else
        podman images | grep -v REPOSITORY | awk '{print $1":"$2}' | xargs -L1 podman pull
    fi
}

function prune() {
    if [[ "$1" == "-d" ]]; then
        sudo docker image prune --force
        sudo docker images
    else
        podman image prune --force
        podman images
    fi
}

function logs() {
    if [[ "$1" == "-d" ]]; then
        if ! [ -z "$2" ]; then
            sudo docker logs -ft $2
        else
            sudo docker-compose logs -ft
        fi
    else
        if ! [ -z "$1" ]; then
            podman logs -ft $1
        else
            DOCKER_HOST=unix:///run/user/1000/podman/podman.sock docker-compose logs -ft
        fi
    fi
}

autoload -Uz compinit
compinit

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

bindkey "${terminfo[kcbt]}" reverse-menu-complete

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey "\e[3~" delete-char

# time config
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Appends every command to the history file once it is executed
setopt inc_append_history

# Machine specific
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
