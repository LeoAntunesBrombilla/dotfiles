# ===========================
# Powerlevel10k Instant Prompt
# ===========================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===========================
# Oh-My-Zsh & Plugins
# ===========================
export ZSH="$HOME/.oh-my-zsh"

# Enable plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
  colored-man-pages
)

# Load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# ===========================
# Paths & Environment Variables
# ===========================
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && \. "$SDKMAN_DIR/bin/sdkman-init.sh"

# Neovim
export PATH="$PATH:/opt/nvim-linux64/bin"

# Android SDK
export ANDROID_HOME=~/Android/Sdk
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH

# ===========================
# Prompt & Theme
# ===========================
ZSH_THEME="robbyrussell"
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ===========================
# Aliases
# ===========================

# ---- File & Directory Shortcuts ----
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'

# ---- Git Shortcuts ----
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpo='git push origin'
alias gpl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gl='git log --oneline --graph --decorate --all'
alias gcl='git clone'
alias gpr='git pull --rebase'
alias grm='git reset --mixed'
alias grs='git reset --soft'
alias grh='git reset --hard'
alias gdf='git diff'
alias gst='git stash'
alias gsta='git stash apply'
alias gamend='git commit --amend --no-edit'
alias gcb='git checkout -b'

# ---- Node, NPM & Yarn ----
alias nr='npm run'
alias ni='npm install'
alias nid='npm install -D'
alias nis='npm install -g'
alias y='yarn'
alias ya='yarn add'
alias yad='yarn add -D'

# ---- Docker ----
alias dps='docker ps'
alias dpa='docker ps -a'
alias dstop='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -aq)'
alias dprune='docker system prune -af'

# ---- System & Process Management ----
alias update='sudo apt update && sudo apt upgrade -y'
alias cls='clear'
alias h='history'
alias psg='ps aux | grep -i'

# ---- Shortcuts for Navigation ----
alias dev="cd ~/Developer"
alias proj="cd ~/Projects"

# ---- Neovim ----
alias vim='nvim'
alias vi='nvim'

# ===========================
# Functions
# ===========================

# Fix permissions on npm global installs
fix_npm() {
  sudo chown -R $(whoami) ~/.npm
}

# Check port usage
port_check() {
  lsof -i :$1
}

# Kill process on a port
kill_port() {
  lsof -t -i :$1 | xargs kill -9
}

# Create a directory and move into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Quick HTTP server (Python)
serve() {
  local port="${1:-8000}"
  echo "Starting HTTP server on port $port..."
  python3 -m http.server "$port"
}

# ===========================
# Finalization
# ===========================

# Automatically start SSH agent
eval $(ssh-agent) > /dev/null 2>&1

# Source fzf keybindings (optional)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enable exa if installed (better ls)
if command -v exa &>/dev/null; then
  alias ls='exa --icons'
  alias ll='exa -lah --icons'
fi
