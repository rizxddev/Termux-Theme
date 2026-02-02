#!/data/data/com.termux/files/usr/bin/bash

# ============================================
# TERMUX PRO THEME - FINAL FIXED VERSION
# ============================================

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

echo -e "${CYAN}"
cat << "EOF"
╔═══════════════════════════════════════╗
║        TERMUX PRO THEME               ║
║         RIZXMODS EDITION v2.2         ║
╚═══════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${YELLOW}[+] Installing PRO Theme (Final Fixed Version)...${NC}"
echo ""

# Install
pkg update -y && pkg upgrade -y
pkg install -y zsh

# Colors
mkdir -p ~/.termux
cat > ~/.termux/colors.properties << 'EOF'
background=#0a0a0a
foreground=#00ff9f
cursor=#ff0055
color0=#1a1a1a
color1=#ff0055
color2=#00ff9f
color3=#ffcc00
color4=#00a3ff
color5=#cc00ff
color6=#00ffff
color7=#c0c0c0
EOF

# ZSH CONFIG - FIXED: Gunakan metode escape yang benar
cat > ~/.zshrc << "EOF"
# ================================================
# RIZXMODS PRO THEME - FINAL FIXED
# ================================================

autoload -U colors && colors

# Simple Welcome - FIXED: tidak pakai print -P untuk banner
welcome() {
    clear
    echo ""
    echo "╔═══════════════════════════════════════╗"
    echo "║      TERMUX PRO THEME - RIZXMODS      ║"
    echo "║              Version 2.2              ║"
    echo "╚═══════════════════════════════════════╝"
    echo ""
}

# System Info - FIXED: pakai echo biasa untuk info
sys_info() {
    echo "┌───────────────── SYSTEM INFO ─────────────────┐"
    echo "│ » OS: $(uname -o)"
    
    local KERNEL=$(uname -r)
    if [ ${#KERNEL} -gt 40 ]; then
        KERNEL="${KERNEL:0:37}..."
    fi
    echo "│ » Kernel: $KERNEL"
    echo "│ » Shell: ZSH"
    echo "│ » User: @rizxdev"
    echo "│ » Theme: Cyberpunk Edition"
    echo "└────────────────────────────────────────────────┘"
}

# Prompt - FIXED: ini bagian penting
precmd() {
    local EXIT_CODE=$?
    
    if [ $EXIT_CODE -eq 0 ]; then
        STATUS="%F{green}✓%f"
    else
        STATUS="%F{red}✗%f"
    fi
    
    local TIME=$(date +"%H:%M:%S")
    local DIR=$(print -P "%~")
    
    # Trim directory
    if [ ${#DIR} -gt 20 ]; then
        DIR="...${DIR: -17}"
    fi
    
    # Build prompt - FIXED: sederhana dan jelas
    PROMPT="%F{blue}╭─%f[${STATUS}]%F{blue}──%f[%F{magenta}@rizxdev%f]%F{blue}──%f[%F{yellow}${DIR}%f]"
    
    # Git info
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local BRANCH=$(git branch --show-current 2>/dev/null)
        if [ -n "$BRANCH" ]; then
            PROMPT+=" %F{green}[⎇ $BRANCH]%f"
        fi
    fi
    
    PROMPT+="
%F{blue}╰─%f[%F{cyan}${TIME}%f]%F{blue}───╼%f %F{red}⟩%F{yellow}⟩%F{green}⟩%f "
}

setopt prompt_subst

# ================================================
# ALIASES
# ================================================

alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias cl='clear'
alias update='pkg update && pkg upgrade -y'
alias install='pkg install -y'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

# Theme commands - FIXED: echo biasa
theme-help() {
    echo ""
    echo "┌─────────────── THEME COMMANDS ───────────────┐"
    echo "│ theme-help      - Show this help"
    echo "│ sys-info        - System information"
    echo "│ prompt-demo     - Show prompt examples"
    echo "│ change-user     - Change username"
    echo "│ color-test      - Test colors"
    echo "└────────────────────────────────────────────────┘"
    echo ""
}

sys-info() {
    welcome
    sys_info
}

prompt-demo() {
    echo ""
    echo "┌────────────── PROMPT EXAMPLES ───────────────┐"
    echo "│ ╭─[✓]──[@rizxdev]──[~/projects]"
    echo "│ ╰─[14:30:22]───╼ ⟩⟩⟩"
    echo "└────────────────────────────────────────────────┘"
    echo ""
}

change-user() {
    if [ -z "$1" ]; then
        echo "Usage: change-user <username>"
        return 1
    fi
    sed -i "s/@rizxdev/@$1/g" ~/.zshrc
    source ~/.zshrc
    echo "Username changed to @$1"
}

color-test() {
    echo ""
    echo "┌────────────── COLOR TEST ────────────────┐"
    echo -e "│ \033[1;32mGreen\033[0m   \033[1;35mPink\033[0m   \033[1;34mBlue\033[0m"
    echo -e "│ \033[1;33mYellow\033[0m  \033[1;36mCyan\033[0m   \033[1;37mWhite\033[0m"
    echo "└──────────────────────────────────────────┘"
    echo ""
}

# ================================================
# STARTUP
# ================================================

welcome
sys_info

echo ""
echo "✓ PRO Theme activated successfully!"
echo "Type 'theme-help' for custom commands"
echo "══════════════════════════════════════════════"
echo ""

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# Completion
autoload -Uz compinit
compinit

# Key bindings
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Options
setopt autocd
setopt nobeep

echo "Ready for commands..."
EOF

# Set ZSH as default
chsh -s zsh

# Create bash fallback
cat > ~/.bashrc << 'EOF'
# Bash fallback
PS1='\[\033[1;34m\]╭─\[\033[0m\][\[\033[1;31m\]$?\[\033[0m\]]\[\033[1;34m\]──\[\033[0m\][\[\033[1;35m\]@rizxdev\[\033[0m\]]\[\033[1;34m\]──\[\033[0m\][\[\033[1;33m\]\w\[\033[0m\]]\n\[\033[1;34m\]╰─\[\033[0m\][\[\033[1;36m\]\t\[\033[0m\]]\[\033[1;34m\]───╼\[\033[0m\] \[\033[1;31m\]⟩\[\033[1;33m\]⟩\[\033[1;32m\]⟩\[\033[0m\] '

alias ls='ls --color=auto'
alias ll='ls -la'
alias zsh='exec zsh'

clear
echo ""
echo -e "\033[1;34m╔══════════════════════════════════════╗"
echo -e "║      PRO THEME - BASH MODE          ║"
echo -e "║      Type 'zsh' for full theme      ║"
echo -e "╚══════════════════════════════════════╝\033[0m"
echo ""
EOF

# Reload
termux-reload-settings

# Final message
echo -e "${GREEN}"
cat << "EOF"
╔═══════════════════════════════════════╗
║         THEME INSTALLED!             ║
╠═══════════════════════════════════════╣
║  ✓ Clean Cyberpunk Colors            ║
║  ✓ Multi-line Prompt                 ║
║  ✓ Git Integration                   ║
║  ✓ System Info                       ║
║  ✓ Custom Commands                   ║
╚═══════════════════════════════════════╝
EOF
echo -e "${NC}"

echo ""
echo -e "${YELLOW}Restarting terminal with new theme...${NC}"
sleep 2
exec zsh
