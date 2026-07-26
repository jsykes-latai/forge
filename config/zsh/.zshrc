# =========================
# Forge Zsh Configuration
# =========================

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt AUTO_CD
setopt EXTENDED_GLOB

# Completion
autoload -Uz compinit
compinit

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Better navigation
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# Aliases
# alias ll="ls -lah"
# alias la="ls -A"
# alias l="ls -CF"

alias cls="clear"
alias update="sudo pacman -Syu"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Temporary prompt until Starship
# PROMPT='%F{cyan}%n@%m%f:%F{green}%~%f %# '

# Modern CLI replacements
alias ls="eza --icons=auto"
alias ll="eza -lah --icons=auto --git"
alias la="eza -a --icons=auto"
alias l="eza -1 --icons=auto"

alias cat="bat"
alias grep="rg"
alias find="fd"
alias top="btop"

# Quality of Life
alias cls="clear"
alias update="sudo pacman -Syu"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Interactive Tools
source <(fzf --zsh)
eval "$(zoxide init zsh)"

# Starship Prompt
eval "$(starship init zsh)"
