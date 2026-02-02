#!/data/data/com.termux/files/usr/bin/bash

# ============================================
# TERMUX PRO THEME - RIZXMODS
# Premium version with all features
# ============================================

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Banner
show_banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
    ╔═══════════════════════════════════════════════╗
    ║        ██████╗ ██████╗  ██████╗              ║
    ║        ██╔══██╗██╔══██╗██╔═══██╗             ║
    ║        ██████╔╝██████╔╝██║   ██║             ║
    ║        ██╔═══╝ ██╔══██╗██║   ██║             ║
    ║        ██║     ██║  ██║╚██████╔╝             ║
    ║        ╚═╝     ╚═╝  ╚═╝ ╚═════╝              ║
    ║                                               ║
    ║         T E R M U X   P R O   T H E M E       ║
    ║            RIZXMODS EDITION v2.0             ║
    ╚═══════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
}

show_banner

echo -e "${YELLOW}[+] Installing PRO Theme...${NC}"
echo ""

# Update & install
echo -e "${BLUE}[1] Updating system...${NC}"
pkg update -y && pkg upgrade -y

echo -e "${BLUE}[2] Installing packages...${NC}"
pkg install -y zsh git wget curl neofetch figlet python nodejs ruby nano

# Cyberpunk Colors
echo -e "${BLUE}[3] Applying Cyberpunk colors...${NC}"
mkdir -p ~/.termux
cat > ~/.termux/colors.properties << 'EOF'
# Cyberpunk PRO Theme
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
color8=#4d4d4d
color9=#ff5580
color10=#33ffb3
color11=#ffdd44
color12=#66c2ff
color13=#dd66ff
color14=#66ffff
color15=#ffffff
EOF

# Font
echo -e "${BLUE}[4] Installing font...${NC}"
wget -q https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf -O ~/.termux/font.ttf 2>/dev/null || echo "Using default font"

# PRO ZSH Config
echo -e "${BLUE}[5] Creating PRO configuration...${NC}"
cat > ~/.zshrc << 'EOF'
# ================================================
# RIZXMODS PRO TERMUX THEME v2.0
# ================================================

# Colors
autoload -U colors && colors
CYBER_GREEN="%F{#00ff9f}"
CYBER_PINK="%F{#ff0055}"
CYBER_BLUE="%F{#00a3ff}"
CYBER_YELLOW="%F{#ffcc00}"
CYBER_CYAN="%F{#00ffff}"
WHITE="%F{white}"
RESET="%f"

# Welcome Banner
welcome_banner() {
    clear
    echo "${CYBER_GREEN}"
    echo '╔═══╗╔═══╗╔╗ ╔╗╔═══╗╔═══╗╔═══╗╔═══╗'
    echo '║╔═╗║║╔══╝║║ ║║║╔══╝║╔═╗║║╔═╗║║╔═╗║'
    echo '║╚═╝║║╚══╗║║ ║║║╚══╗║╚═╝║║╚═╝║║╚══╗'
    echo '║╔╗╔╝║╔══╝║║ ║║║╔══╝║╔╗╔╝║╔╗╔╝╚══╗║'
    echo '║║║╚╗║╚══╗║╚═╝║║╚══╗║║║╚╗║║║╚╗║╚═╝║'
    echo '╚╝╚═╝╚═══╝╚═══╝╚═══╝╚╝╚═╝╚╝╚═╝╚═══╝'
    echo "${RESET}"
    echo "${CYBER_BLUE}╔═══════════════════════════════════════╗"
    echo "║      TERMUX PRO THEME - RIZXMODS      ║"
    echo "║              Version 2.0              ║"
    echo "╚═══════════════════════════════════════╝${RESET}"
    echo ""
}

# System Info
sys_info() {
    echo "${CYBER_BLUE}┌───────────────── SYSTEM INFO ─────────────────┐${RESET}"
    echo "${WHITE}│${RESET} ${CYBER_YELLOW}» OS:${RESET} ${WHITE}$(uname -o)${RESET}"
    echo "${WHITE}│${RESET} ${CYBER_YELLOW}» Kernel:${RESET} ${WHITE}$(uname -r)${RESET}"
    echo "${WHITE}│${RESET} ${CYBER_YELLOW}» Shell:${RESET} ${WHITE}ZSH PRO${RESET}"
    echo "${WHITE}│${RESET} ${CYBER_YELLOW}» User:${RESET} ${CYBER_PINK}@rizxdev${RESET}"
    echo "${WHITE}│${RESET} ${CYBER_YELLOW}» Theme:${RESET} ${CYBER_GREEN}Cyberpunk Edition${RESET}"
    echo "${CYBER_BLUE}└────────────────────────────────────────────────┘${RESET}"
}

# Git Status
git_status_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local BRANCH=$(git branch --show-current 2>/dev/null)
        if [ -n "$BRANCH" ]; then
            echo "${CYBER_GREEN}[⎇ $BRANCH]${RESET}"
        fi
    fi
}

# Dynamic Prompt
precmd() {
    local EXIT_CODE=$?
    
    if [ $EXIT_CODE -eq 0 ]; then
        STATUS="${CYBER_GREEN}✔${RESET}"
    else
        STATUS="${CYBER_PINK}✘${RESET}"
    fi
    
    local CURRENT_TIME=$(date +"%H:%M:%S")
    local CURRENT_DIR=$(print -P "%~")
    
    # Trim long directory names
    if [ ${#CURRENT_DIR} -gt 25 ]; then
        CURRENT_DIR="...${CURRENT_DIR: -22}"
    fi
    
    # Line 1
    PROMPT_LINE1="${CYBER_BLUE}╭─${RESET}[${STATUS}]${CYBER_BLUE}──${RESET}[${CYBER_PINK}@rizxdev${RESET}]${CYBER_BLUE}──${RESET}[${CYBER_YELLOW}${CURRENT_DIR}${RESET}]"
    
    # Add Git info if available
    local GIT_INFO=$(git_status_info)
    if [ -n "$GIT_INFO" ]; then
        PROMPT_LINE1+=" ${GIT_INFO}"
    fi
    
    # Line 2
    PROMPT_LINE2="${CYBER_BLUE}╰─${RESET}[${CYBER_CYAN}${CURRENT_TIME}${RESET}]${CYBER_BLUE}───╼${RESET}"
    
    # Final Prompt
    PROMPT="${PROMPT_LINE1}
${PROMPT_LINE2} ${CYBER_PINK}⟫${CYBER_YELLOW}⟫${CYBER_GREEN}⟫${RESET} "
}

setopt prompt_subst

# ================================================
# ALIASES & FUNCTIONS
# ================================================

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias home="cd ~"

# Listing
alias ls="ls --color=auto -F"
alias ll="ls -lah"
alias la="ls -A"
alias l="ls -CF"
alias lt="ls -lt"
alias lsize="ls -laS"

# System
alias update="pkg update && pkg upgrade -y"
alias install="pkg install -y"
alias remove="pkg uninstall"
alias clean="pkg clean"
alias disk="df -h"

# Network
alias ip="curl ifconfig.me"
alias myip="ip"
alias ping="ping -c 4"
alias ports="netstat -tuln"

# Development
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --all"
alias python="python3"
alias pip="pip3"

# Theme Management
alias theme="echo 'RIZXMODS PRO Theme v2.0'"
alias theme-reload="source ~/.zshrc"
alias theme-help="echo 'Use: theme-commands for help'"
alias theme-edit="nano ~/.zshrc"

# Fun
alias matrix="cmatrix -s"
alias hacker="echo 'ACCESS GRANTED' | figlet"
alias rainbow="echo '\033[1;31mR\033[1;33mA\033[1;32mI\033[1;36mN\033[1;34mB\033[1;35mO\033[1;37mW'"
alias calc="bc -l"

# Custom Commands
theme-commands() {
    echo "${CYBER_BLUE}┌─────────────── THEME COMMANDS ───────────────┐${RESET}"
    echo "${WHITE}│${RESET} ${CYBER_GREEN}theme-help${RESET}      - Show this help"
    echo "${WHITE}│${RESET} ${CYBER_GREEN}sys-info${RESET}        - System information"
    echo "${WHITE}│${RESET} ${CYBER_GREEN}prompt-demo${RESET}     - Show prompt examples"
    echo "${WHITE}│${RESET} ${CYBER_GREEN}change-user${RESET}     - Change username"
    echo "${WHITE}│${RESET} ${CYBER_GREEN}color-show${RESET}      - Display color palette"
    echo "${WHITE}│${RESET} ${CYBER_GREEN}update-pro${RESET}      - Update PRO theme"
    echo "${CYBER_BLUE}└────────────────────────────────────────────────┘${RESET}"
}

sys-info() {
    welcome_banner
    sys_info
    echo ""
}

prompt-demo() {
    echo "${CYBER_BLUE}┌────────────── PROMPT EXAMPLES ───────────────┐${RESET}"
    echo "${WHITE}│${RESET} ${CYBER_GREEN}Success:${RESET}"
    echo "${WHITE}│${RESET} ╭─[✔]──[@rizxdev]──[~/projects] [⎇ main]"
    echo "${WHITE}│${RESET} ╰─[14:30:22]───╼ ⟫⟫⟫"
    echo "${WHITE}│${RESET}"
    echo "${WHITE}│${RESET} ${CYBER_PINK}Error:${RESET}"
    echo "${WHITE}│${RESET} ╭─[✘]──[@rizxdev]──[~/projects]"
    echo "${WHITE}│${RESET} ╰─[14:30:22]───╼ ⟫⟫⟫"
    echo "${CYBER_BLUE}└────────────────────────────────────────────────┘${RESET}"
}

change-user() {
    if [ -z "$1" ]; then
        echo "Usage: change-user <username>"
        return 1
    fi
    sed -i "s/@rizxdev/@$1/g" ~/.zshrc
    source ~/.zshrc
    echo "${CYBER_GREEN}Username changed to @$1${RESET}"
}

color-show() {
    echo "${CYBER_BLUE}┌────────────── COLOR PALETTE ────────────────┐${RESET}"
    echo -e "${WHITE}│${RESET} ${CYBER_GREEN}Cyber Green${RESET}  ${CYBER_PINK}Cyber Pink${RESET}  ${CYBER_BLUE}Cyber Blue${RESET}"
    echo -e "${WHITE}│${RESET} ${CYBER_YELLOW}Cyber Yellow${RESET} ${CYBER_CYAN}Cyber Cyan${RESET}  ${WHITE}White${RESET}"
    echo "${CYBER_BLUE}└────────────────────────────────────────────────┘${RESET}"
}

update-pro() {
    echo "${CYBER_YELLOW}Updating PRO Theme...${RESET}"
    curl -fsSL https://raw.githubusercontent.com/rizxmods/termux-theme/main/install2.sh | bash
}

# ================================================
# STARTUP
# ================================================

# Show welcome
welcome_banner
sys_info

echo ""
echo "${CYBER_GREEN}✓ PRO Theme activated successfully!${RESET}"
echo "${CYBER_YELLOW}Type 'theme-commands' for custom commands${RESET}"
echo "${CYBER_BLUE}══════════════════════════════════════════════${RESET}"
echo ""

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory
setopt sharehistory

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

# Key bindings
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Options
setopt autocd
setopt extendedglob
setopt nocaseglob
setopt nobeep

# Final
echo "${CYBER_GREEN}Ready for commands...${RESET}"
EOF

# Set ZSH as default
echo -e "${BLUE}[6] Setting ZSH as default shell...${NC}"
chsh -s zsh

# Create bash fallback
echo -e "${BLUE}[7] Creating bash configuration...${NC}"
cat > ~/.bashrc << 'EOF'
# Bash fallback for PRO Theme
PS1='\[\033[1;34m\]╭─\[\033[0m\][\[\033[1;31m\]$?\[\033[0m\]]\[\033[1;34m\]──\[\033[0m\][\[\033[1;35m\]@rizxdev\[\033[0m\]]\[\033[1;34m\]──\[\033[0m\][\[\033[1;33m\]\w\[\033[0m\]]\n\[\033[1;34m\]╰─\[\033[0m\][\[\033[1;36m\]\t\[\033[0m\]]\[\033[1;34m\]───╼\[\033[0m\] \[\033[1;31m\]⟫\[\033[1;33m\]⟫\[\033[1;32m\]⟫\[\033[0m\] '

alias ls='ls --color=auto'
alias ll='ls -la'
alias zsh='exec zsh'

clear
echo ""
echo -e "\033[1;34m╔══════════════════════════════════════╗"
echo -e "║      PRO THEME - BASH MODE          ║"
echo -e "║      Type 'zsh' for full PRO        ║"
echo -e "╚══════════════════════════════════════╝\033[0m"
echo ""
EOF

# Reload
termux-reload-settings

# Final message
echo -e "${GREEN}"
cat << "EOF"
╔═══════════════════════════════════════════╗
║         PRO THEME INSTALLED!             ║
╠═══════════════════════════════════════════╣
║  Features:                               ║
║  • Cyberpunk Color Scheme                ║
║  • Multi-line Prompt                     ║
║  • Git Integration                       ║
║  • System Info Display                   ║
║  • 40+ Aliases & Functions               ║
║  • Custom Theme Commands                 ║
║  • Auto-completion                       ║
╚═══════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo ""
echo -e "${YELLOW}Your prompt now looks like:${NC}"
echo ""
echo -e "  ${BLUE}╭─${NC}[${GREEN}✔${NC}]${BLUE}──${NC}[${MAGENTA}@rizxdev${NC}]${BLUE}──${NC}[${YELLOW}~${NC}]"
echo -e "  ${BLUE}╰─${NC}[${CYAN}14:30:22${NC}]${BLUE}───╼${NC} ${RED}⟫${YELLOW}⟫${GREEN}⟫${NC} "
echo ""
echo -e "${CYAN}Quick commands:${NC}"
echo "  theme-commands  - Show all commands"
echo "  sys-info        - System information"
echo "  prompt-demo     - Prompt examples"
echo "  change-user abc - Change username"
echo ""
echo -e "${YELLOW}Restarting in 3 seconds...${NC}"
sleep 3
exec zsh
