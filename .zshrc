if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=$HOME/.oh-my-zsh
export PATH=$HOME/.local/bin:$PATH

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
	git
	z
	zsh-autosuggestions
	zsh-syntax-highlighting
	history-substring-search
)

source $ZSH/oh-my-zsh.sh

# Machine specific
[ -f $HOME/.zshrc.local ] && source  $HOME/.zshrc.local

export LC_ALL=en_US.UTF-8

alias cls="clear"
alias open="xdg-open 2>/dev/null"
alias o="open"

alias clip="maim -s -u | xclip -selection clipboard -t image/png"

alias mp3="youtube-dl --extract-audio --audio-format mp3"

alias ts="ts-node"
alias js="node"

alias gs="git status"
alias gd="git diff"
alias gp="git push && clear"
alias gap="git add -p"
alias cputemp="sensors | grep Core"

alias zshrc="nano $HOME/.zshrc"
alias zshrc.local="nano $HOME/.zshrc.local"

alias up="sudo docker-compose up -d"
alias down="sudo docker-compose down"
alias pull="sudo docker-compose pull"
alias logs="sudo docker logs --follow"
function images() { sudo docker images | grep -v REPOSITORY | awk '{print $1}' | xargs -L1 sudo docker pull }

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# time config
TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history
HISTSIZE=5000000
SAVEHIST=5000000
