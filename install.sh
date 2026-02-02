#!/data/data/com.termux/files/usr/bin/bash

# ============================================
# TERMUX SIMPLE THEME - RIZXMODS
# Clean & minimal version
# ============================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}"
echo "┌──────────────────────────────────────┐"
echo "│     TERMUX SIMPLE THEME v1.0        │"
echo "│         By: @rizxmods               │"
echo "└──────────────────────────────────────┘"
echo -e "${NC}"

# Install basic packages
echo -e "${YELLOW}[1] Installing packages...${NC}"
pkg update -y && pkg upgrade -y
pkg install -y zsh git curl

# Set colors
echo -e "${YELLOW}[2] Setting up colors...${NC}"
mkdir -p ~/.termux
cat > ~/.termux/colors.properties << 'EOF'
# Simple Dark Theme
background=#1a1a1a
foreground=#ffffff
cursor=#00ff00
color0=#000000
color1=#ff5555
color2=#50fa7b
color3=#f1fa8c
color4=#bd93f9
color5=#ff79c6
color6=#8be9fd
color7=#bbbbbb
color8=#444444
color9=#ff6e67
color10=#5af78e
color11=#f4f99d
color12=#caa9fa
color13=#ff92d0
color14=#9aedfe
color15=#ffffff
EOF

# Create simple ZSH config
echo -e "${YELLOW}[3] Creating ZSH configuration...${NC}"
cat > ~/.zshrc << 'EOF'
# Simple RizxMods Theme

# Enable colors
autoload -U colors && colors

# Prompt function
precmd() {
    # Get exit code
    local exit_code=$?
    
    # Set status
    if [[ $exit_code -eq 0 ]]; then
        STATUS="%F{green}✓%f"
    else
        STATUS="%F{red}✗%f"
    fi
    
    # Set prompt
    PROMPT="%F{white}┌─[$STATUS]─[%F{green}@rizxmods%F{white}]─[%F{yellow}%~%F{white}]
%F{white}└──╼ %F{cyan}❯❯❯ %f"
    
    # Time on right
    RPROMPT="%F{blue}%T%f"
}

setopt prompt_subst

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias cl='clear'
alias update='pkg update && pkg upgrade -y'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

# Welcome
clear
echo ""
echo "┌─────────────────────────────────┐"
echo "│   Simple Theme Activated!       │"
echo "└─────────────────────────────────┘"
echo ""
echo "Prompt: ┌─[✗]─[@rizxmods]─[~]"
echo "        └──╼ ❯❯❯"
echo ""
echo "Type 'zsh-theme-help' for help"
EOF

# Set ZSH as default
echo -e "${YELLOW}[4] Setting ZSH as default...${NC}"
chsh -s zsh

# Reload settings
termux-reload-settings

echo -e "${GREEN}"
echo "╔═══════════════════════════════════╗"
echo "║     SIMPLE THEME INSTALLED!      ║"
echo "╚═══════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}Restart Termux or run:${NC} exec zsh"
echo ""
sleep 2
exec zsh
