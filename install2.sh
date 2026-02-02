#!/data/data/com.termux/files/usr/bin/bash

# ============================================
# TERMUX PRO THEME CLEAN - RIZXMODS
# Clean version without ASCII art issues
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
╔═══════════════════════════════════════════╗
║        TERMUX PRO THEME - CLEAN          ║
║         RIZXMODS EDITION v2.1            ║
╚═══════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${YELLOW}[+] Installing PRO Theme (Clean Version)...${NC}"
echo ""

# Update & install
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

# Clean ZSH Config (NO ASCII ART)
cat > ~/.zshrc << 'EOF'
# ================================================
# RIZXMODS PRO THEME - CLEAN VERSION
# ================================================

autoload -U colors && colors

# Color Variables
GREEN="%F{46}"
PINK="%F{199}"
BLUE="%F{39}"
YELLOW="%F{226}"
CYAN="%F{51}"
WHITE="%F{255}"
RESET="%f"

# Simple Welcome
welcome() {
    clear
    print -P "${BLUE}╔═══════════════════════════════════════╗"
    print "║      TERMUX PRO THEME - RIZXMODS      ║"
    print "║              Version 2.1              ║"
    print "╚═══════════════════════════════════════╝${RESET}"
    print ""
}

# System Info
sys_info() {
    print -P "${BLUE}┌───────────────── SYSTEM INFO ─────────────────┐${RESET}"
    print -P "${WHITE}│${RESET} ${YELLOW}» OS:${RESET} ${WHITE}$(uname -o)${RESET}"
    
    # Trim kernel version if too long
    local KERNEL=$(uname -r)
    if [ ${#KERNEL} -gt 40 ]; then
        KERNEL="${KERNEL:0:37}..."
    fi
    print -P "${WHITE}│${RESET} ${YELLOW}» Kernel:${RESET} ${WHITE}$KERNEL${RESET}"
    print -P "${WHITE}│${RESET} ${YELLOW}» Shell:${RESET} ${WHITE}ZSH ${ZSH_VERSION}${RESET}"
    print -P "${WHITE}│${RESET} ${YELLOW}» User:${RESET} ${PINK}@rizxdev${RESET}"
    print -P "${WHITE}│${RESET} ${YELLOW}» Theme:${RESET} ${GREEN}Cyberpunk Edition${RESET}"
    print -P "${BLUE}└────────────────────────────────────────────────┘${RESET}"
}

# Prompt
precmd() {
    local EXIT_CODE=$?
    
    if [ $EXIT_CODE -eq 0 ]; then
        STATUS="${GREEN}✔${RESET}"
    else
        STATUS="${PINK}✘${RESET}"
    fi
    
    local TIME=$(date +"%H:%M:%S")
    local DIR=$(print -P "%~")
    
    # Trim directory if too long
    if [ ${#DIR} -gt 20 ]; then
        DIR="...${DIR: -17}"
    fi
    
    # Build prompt
    PROMPT="${BLUE}╭─${RESET}[${STATUS}]${BLUE}──${RESET}[${PINK}@rizxdev${RESET}]${BLUE}──${RESET}[${YELLOW}${DIR}${RESET}]"
    
    # Git info
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local BRANCH=$(git branch --show-current 2>/dev/null)
        if [ -n "$BRANCH" ]; then
            PROMPT+=" ${GREEN}[⎇ $BRANCH]${RESET}"
        fi
    fi
    
    PROMPT+="
${BLUE}╰─${RESET}[${CYAN}${TIME}${RESET}]${BLUE}───╼${RESET} ${PINK}⟩${YELLOW}⟩${GREEN}⟩${RESET} "
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

# Theme commands
theme-help() {
    print -P "${BLUE}┌─────────────── THEME COMMANDS ───────────────┐${RESET}"
    print -P "${WHITE}│${RESET} ${GREEN}theme-help${RESET}      - Show this help"
    print -P "${WHITE}│${RESET} ${GREEN}sys-info${RESET}        - System information"
    print -P "${WHITE}│${RESET} ${GREEN}prompt-demo${RESET}     - Show prompt examples"
    print -P "${WHITE}│${RESET} ${GREEN}change-user${RESET}     - Change username"
    print -P "${WHITE}│${RESET} ${GREEN}color-test${RESET}      - Test colors"
    print -P "${BLUE}└────────────────────────────────────────────────┘${RESET}"
}

sys-info() {
    welcome
    sys_info
}

prompt-demo() {
    print -P "${BLUE}┌────────────── PROMPT EXAMPLES ───────────────┐${RESET}"
    print -P "${WHITE}│${RESET} ${BLUE}╭─${RESET}[${GREEN}✔${RESET}]${BLUE}──${RESET}[${PINK}@rizxdev${RESET}]${BLUE}──${RESET}[${YELLOW}~/projects${RESET}]"
    print -P "${WHITE}│${RESET} ${BLUE}╰─${RESET}[${CYAN}14:30:22${RESET}]${BLUE}───╼${RESET} ${PINK}⟩${YELLOW}⟩${GREEN}⟩${RESET}"
    print -P "${BLUE}└────────────────────────────────────────────────┘${RESET}"
}

change-user() {
    if [ -z "$1" ]; then
        print -P "${PINK}Usage: change-user <username>${RESET}"
        return 1
    fi
    sed -i "s/@rizxdev/@$1/g" ~/.zshrc
    source ~/.zshrc
    print -P "${GREEN}Username changed to @$1${RESET}"
}

color-test() {
    print -P "${BLUE}┌────────────── COLOR TEST ────────────────┐${RESET}"
    print -P "${WHITE}│${RESET} ${GREEN}Green${RESET}   ${PINK}Pink${RESET}   ${BLUE}Blue${RESET}"
    print -P "${WHITE}│${RESET} ${YELLOW}Yellow${RESET}  ${CYAN}Cyan${RESET}   ${WHITE}White${RESET}"
    print -P "${BLUE}└──────────────────────────────────────────┘${RESET}"
}

# ================================================
# STARTUP
# ================================================

welcome
sys_info

print ""
print -P "${GREEN}✓ PRO Theme activated successfully!${RESET}"
print -P "${YELLOW}Type 'theme-help' for custom commands${RESET}"
print -P "${BLUE}══════════════════════════════════════════════${RESET}"
print ""

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

print -P "${GREEN}Ready for commands...${RESET}"
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

# Final
echo -e "${GREEN}"
cat << "EOF"
╔═══════════════════════════════════════╗
║         PRO THEME INSTALLED!         ║
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
echo -e "${YELLOW}Sample prompt:${NC}"
echo ""
echo -e "  ${BLUE}╭─${NC}[${GREEN}✔${NC}]${BLUE}──${NC}[${MAGENTA}@rizxdev${NC}]${BLUE}──${NC}[${YELLOW}~${NC}]"
echo -e "  ${BLUE}╰─${NC}[${CYAN}14:30:22${NC}]${BLUE}───╼${NC} ${RED}⟩${YELLOW}⟩${GREEN}⟩${NC} "
echo ""
echo -e "${CYAN}Commands: theme-help, sys-info, prompt-demo${NC}"
echo ""
sleep 2
exec zsh
