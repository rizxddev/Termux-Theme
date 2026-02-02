#!/data/data/com.termux/files/usr/bin/bash

# ============================================
# TERMUX PRO THEME - RIZXMODS (FIXED VERSION)
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
    ║        ██████╗ ██████╗  ██████╗               ║
    ║        ██╔══██╗██╔══██╗██╔═══██╗              ║
    ║        ██████╔╝██████╔╝██║   ██║              ║
    ║        ██╔═══╝ ██╔══██╗██║   ██║              ║
    ║        ██║     ██║  ██║╚██████╔╝              ║
    ║        ╚═╝     ╚═╝  ╚═╝ ╚═════╝               ║
    ║                                               ║
    ║         T E R M U X   P R O   T H E M E       ║
    ║            RIZXMODS EDITION v2.0              ║
    ╚═══════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
}

show_banner

echo -e "${YELLOW}[+] Installing PRO Theme (Fixed Version)...${NC}"
echo ""

# Update & install
echo -e "${BLUE}[1] Updating system...${NC}"
pkg update -y && pkg upgrade -y

echo -e "${BLUE}[2] Installing packages...${NC}"
pkg install -y zsh git wget curl neofetch figlet

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

# PRO ZSH Config (FIXED VERSION)
echo -e "${BLUE}[4] Creating PRO configuration (Fixed)...${NC}"
cat > ~/.zshrc << "EOF"
# ================================================
# RIZXMODS PRO TERMUX THEME v2.0 (FIXED)
# ================================================

# Enable colors
autoload -U colors && colors

# Set color variables
CYBER_GREEN="%F{46}"
CYBER_PINK="%F{199}"
CYBER_BLUE="%F{39}"
CYBER_YELLOW="%F{226}"
CYBER_CYAN="%F{51}"
WHITE="%F{255}"
RESET="%f"

# Welcome Banner - FIXED: gunakan print/echo dengan flag -P
welcome_banner() {
    clear
    print -P "%F{46}"
    print '╔═══╗╔═══╗╔╗ ╔╗╔═══╗╔═══╗╔═══╗╔═══╗'
    print '║╔═╗║║╔══╝║║ ║║║╔══╝║╔═╗║║╔═╗║║╔═╗║'
    print '║╚═╝║║╚══╗║║ ║║║╚══╗║╚═╝║║╚═╝║║╚══╗'
    print '║╔╗╔╝║╔══╝║║ ║║║╔══╝║╔╗╔╝║╔╗╔╝╚══╗║'
    print '║║║╚╗║╚══╗║╚═╝║║╚══╗║║║╚╗║║║╚╗║╚═╝║'
    print '╚╝╚═╝╚═══╝╚═══╝╚═══╝╚╝╚═╝╚╝╚═╝╚═══╝'
    print "%f"
    print -P "{39}╔═══════════════════════════════════════╗"
    print "║      TERMUX PRO THEME - RIZXMODS      ║"
    print "║              Version 2.0              ║"
    print "╚═══════════════════════════════════════╝"
    print ""
}

# System Info - FIXED: gunakan print -P untuk warna ZSH
sys_info() {
    print -P "%F{39}┌───────────────── SYSTEM INFO ─────────────────┐%f"
    print -P "%F{255}│%f %F{226}» OS:%f %F{255}$(uname -o)%f"
    print -P "%F{255}│%f %F{226}» Kernel:%f %F{255}$(uname -r)%f"
    print -P "%F{255}│%f %F{226}» Shell:%f %F{255}ZSH PRO%f"
    print -P "%F{255}│%f %F{226}» User:%f %F{199}@rizxdev%f"
    print -P "%F{255}│%f %F{226}» Theme:%f %F{46}Cyberpunk Edition%f"
    print -P "%F{39}└────────────────────────────────────────────────┘%f"
}

# Git Status
git_status_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local BRANCH=$(git branch --show-current 2>/dev/null)
        if [ -n "$BRANCH" ]; then
            print -P "%F{46}[⎇ $BRANCH]%f"
        fi
    fi
}

# Dynamic Prompt - FIXED: gunakan single quotes untuk PROMPT
precmd() {
    local EXIT_CODE=$?
    
    if [ $EXIT_CODE -eq 0 ]; then
        STATUS="%F{46}✔%f"
    else
        STATUS="%F{199}✘%f"
    fi
    
    local CURRENT_TIME=$(date +"%H:%M:%S")
    local CURRENT_DIR=$(print -P "%~")
    
    # Trim long directory names
    if [ ${#CURRENT_DIR} -gt 25 ]; then
        CURRENT_DIR="...${CURRENT_DIR: -22}"
    fi
    
    # Build prompt line by line
    PROMPT="%F{39}╭─%f[${STATUS}]%F{39}──%f[%F{199}@rizxdev%f]%F{39}──%f[%F{226}${CURRENT_DIR}%f]"
    
    # Add Git info if available
    local GIT_INFO=$(git_status_info)
    if [ -n "$GIT_INFO" ]; then
        PROMPT+=" ${GIT_INFO}"
    fi
    
    PROMPT+="
%F{39}╰─%f[%F{51}${CURRENT_TIME}%f]%F{39}───╼%f %F{199}⟫%F{226}⟫%F{46}⟫%f "
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

# System
alias update="pkg update && pkg upgrade -y"
alias install="pkg install -y"
alias remove="pkg uninstall"
alias clean="pkg clean"

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --all"

# Theme Management
theme-help() {
    print -P "%F{39}┌─────────────── THEME COMMANDS ───────────────┐%f"
    print -P "%F{255}│%f %F{46}theme-help%f      - Show this help"
    print -P "%F{255}│%f %F{46}sys-info%f        - System information"
    print -P "%F{255}│%f %F{46}prompt-demo%f     - Show prompt examples"
    print -P "%F{255}│%f %F{46}change-user%f     - Change username"
    print -P "%F{255}│%f %F{46}color-show%f      - Display color palette"
    print -P "%F{39}└────────────────────────────────────────────────┘%f"
}

sys-info() {
    welcome_banner
    sys_info
    print ""
}

prompt-demo() {
    print -P "%F{39}┌────────────── PROMPT EXAMPLES ───────────────┐%f"
    print -P "%F{255}│%f %F{46}Success:%f"
    print -P "%F{255}│%f %F{39}╭─%f[%F{46}✔%f]%F{39}──%f[%F{199}@rizxdev%f]%F{39}──%f[%F{226}~/projects%f] %F{46}[⎇ main]%f"
    print -P "%F{255}│%f %F{39}╰─%f[%F{51}14:30:22%f]%F{39}───╼%f %F{199}⟫%F{226}⟫%F{46}⟫%f"
    print -P "%F{255}│%f"
    print -P "%F{255}│%f %F{199}Error:%f"
    print -P "%F{255}│%f %F{39}╭─%f[%F{199}✘%f]%F{39}──%f[%F{199}@rizxdev%f]%F{39}──%f[%F{226}~/projects%f]"
    print -P "%F{255}│%f %F{39}╰─%f[%F{51}14:30:22%f]%F{39}───╼%f %F{199}⟫%F{226}⟫%F{46}⟫%f"
    print -P "%F{39}└────────────────────────────────────────────────┘%f"
}

change-user() {
    if [ -z "$1" ]; then
        print -P "%F{199}Usage: change-user <username>%f"
        return 1
    fi
    sed -i "s/@rizxdev/@$1/g" ~/.zshrc
    source ~/.zshrc
    print -P "%F{46}Username changed to @$1%f"
}

color-show() {
    print -P "%F{39}┌────────────── COLOR PALETTE ────────────────┐%f"
    print -P "%F{255}│%f %F{46}Cyber Green%f  %F{199}Cyber Pink%f  %F{39}Cyber Blue%f"
    print -P "%F{255}│%f %F{226}Cyber Yellow%f %F{51}Cyber Cyan%f  %F{255}White%f"
    print -P "%F{39}└────────────────────────────────────────────────┘%f"
}

# ================================================
# STARTUP
# ================================================

# Show welcome
welcome_banner
sys_info

print ""
print -P "%F{46}✓ PRO Theme activated successfully!%f"
print -P "%F{226}Type 'theme-help' for custom commands%f"
print -P "%F{39}══════════════════════════════════════════════%f"
print ""

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory
setopt sharehistory

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Key bindings
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Options
setopt autocd
setopt extendedglob
setopt nobeep

# Final
print -P "%F{46}Ready for commands...%f"
EOF

# Set ZSH as default
echo -e "${BLUE}[5] Setting ZSH as default shell...${NC}"
chsh -s zsh

# Create bash fallback
echo -e "${BLUE}[6] Creating bash configuration...${NC}"
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
║  ✓ Cyberpunk Color Scheme                ║
║  ✓ Multi-line Prompt (Fixed)             ║
║  ✓ Git Integration                       ║
║  ✓ System Info Display                   ║
║  ✓ Custom Theme Commands                 ║
║  ✓ Auto-completion                       ║
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
echo "  theme-help      - Show all commands"
echo "  sys-info        - System information"
echo "  prompt-demo     - Prompt examples"
echo "  change-user abc - Change username"
echo ""
echo -e "${YELLOW}Starting ZSH in 3 seconds...${NC}"
sleep 3
exec zsh
