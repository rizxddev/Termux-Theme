#!/data/data/com.termux/files/usr/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Banner
clear
echo -e "${CYAN}"
cat << "EOF"
╔══════════════════════════════════════╗
║       TERMUX THEME - RIZXMODS       ║
╚══════════════════════════════════════╝
EOF
echo -e "${NC}"

# Update and install FIXED packages
echo -e "${YELLOW}[1] Updating packages...${NC}"
pkg update -y && pkg upgrade -y

echo -e "${YELLOW}[2] Installing dependencies (FIXED)...${NC}"
pkg install -y git zsh wget curl neofetch figlet nano

# Install ruby for lolcat (if needed)
pkg install -y ruby || echo "Ruby optional, skipping..."

# Backup
echo -e "${YELLOW}[3] Backing up configs...${NC}"
mkdir -p ~/.termux-backup
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.termux-backup/
[ -f ~/.bashrc ] && cp ~/.bashrc ~/.termux-backup/

# Install color scheme (FIXED URL)
echo -e "${YELLOW}[4] Installing Dracula colors...${NC}"
mkdir -p ~/.termux
cat > ~/.termux/colors.properties << 'EOF'
# Dracula Theme for Termux
background=#282a36
foreground=#f8f8f2
cursor=#f8f8f2
color0=#000000
color1=#ff5555
color2=#50fa7b
color3=#f1fa8c
color4=#bd93f9
color5=#ff79c6
color6=#8be9fd
color7=#bfbfbf
color8=#4d4d4d
color9=#ff6e67
color10=#5af78e
color11=#f4f99d
color12=#caa9fa
color13=#ff92d0
color14=#9aedfe
color15=#e6e6e6
EOF

# Install font (FIXED - menggunakan font Termux default yang bagus)
echo -e "${YELLOW}[5] Installing font...${NC}"
curl -fsSL "https://github.com/termux/termux-styling/raw/master/app/src/main/assets/fonts/Meslo.ttf" -o ~/.termux/font.ttf 2>/dev/null || \
cp /data/data/com.termux/files/usr/share/termux-styling/fonts/*.ttf ~/.termux/font.ttf 2>/dev/null || \
echo "Using default font"

# Install ZSH manually (FIXED)
echo -e "${YELLOW}[6] Installing ZSH manually...${NC}"
if ! command -v zsh &> /dev/null; then
    pkg install -y zsh
fi

# Create custom prompt directly (NO Oh-My-Zsh needed)
echo -e "${YELLOW}[7] Creating custom prompt...${NC}"
cat > ~/.zshrc << 'EOF'
# ============================================
# RIZXMODS SIMPLE TERMUX THEME
# ============================================

# Enable colors
autoload -U colors && colors

# Prompt setup
precmd() {
    # Get exit code
    local exit_code=$?
    
    # Set status symbol
    if [[ $exit_code -eq 0 ]]; then
        STATUS="%F{green}✓%f"
    else
        STATUS="%F{red}✗%f"
    fi
    
    # Git info if available
    if command -v git &> /dev/null && git rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
        GIT_BRANCH="$(git branch --show-current 2>/dev/null)"
        if [ -n "$GIT_BRANCH" ]; then
            GIT_INFO="%F{magenta}[$GIT_BRANCH]%f"
        else
            GIT_INFO=""
        fi
    else
        GIT_INFO=""
    fi
    
    # Set prompt
    PROMPT="%F{white}┌─[$STATUS]─[%F{green}@rizxmods%F{white}]─[%F{yellow}%~%F{white}] $GIT_INFO
%F{white}└──╼ %F{cyan}❯❯❯ %f"
    
    # Right prompt with time
    RPROMPT="%F{blue}%T%f"
}

# Enable prompt substitution
setopt prompt_subst

# ============================================
# ALIASES
# ============================================

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"

# Listing
alias ls="ls --color=auto"
alias ll="ls -la"
alias la="ls -a"
alias l="ls -CF"

# System
alias update="pkg update && pkg upgrade -y"
alias install="pkg install -y"
alias remove="pkg uninstall"
alias clean="pkg clean"
alias search="pkg search"

# Theme
alias theme-reload="source ~/.zshrc"
alias zshrc="nano ~/.zshrc"

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph"

# ============================================
# FUNCTIONS
# ============================================

# Welcome message
welcome() {
    clear
    echo ""
    echo -e "\033[1;36m"
    echo "┌──────────────────────────────────────┐"
    echo "│     TERMUX RIZXMODS THEME v2.0      │"
    echo "└──────────────────────────────────────┘"
    echo -e "\033[0m"
    echo ""
    echo -e "Prompt: \033[1;33m┌─[✗]─[@rizxmods]─[~]\033[0m"
    echo -e "        \033[1;33m└──╼ ❯❯❯\033[0m"
    echo ""
    
    # Show system info
    echo -e "\033[1;32mSystem Info:\033[0m"
    echo "OS: $(uname -o)"
    echo "Shell: $(echo $SHELL)"
    echo "Termux: $(pkg list-installed termux-api 2>/dev/null | head -1 || echo 'Installed')"
    echo ""
}

# Help command
help-theme() {
    echo ""
    echo -e "\033[1;36m=== RIZXMODS THEME COMMANDS ===\033[0m"
    echo ""
    echo -e "\033[1;32mPrompt:\033[0m"
    echo "  ✓  Green = last command success"
    echo "  ✗  Red = last command failed"
    echo ""
    echo -e "\033[1;32mQuick Commands:\033[0m"
    echo "  theme-reload    - Reload theme config"
    echo "  update          - Update packages"
    echo "  set-username    - Change prompt name"
    echo ""
}

# Change username
set-username() {
    if [ -z "$1" ]; then
        echo "Usage: set-username <new_name>"
        return 1
    fi
    sed -i "s/@rizxmods/@$1/g" ~/.zshrc
    source ~/.zshrc
    echo "Username changed to @$1"
}

# ============================================
# STARTUP
# ============================================

# Show welcome
welcome

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# Auto CD
setopt autocd

# Tab completion
autoload -U compinit
zstyle ':completion:*' menu select
compinit

# Key bindings
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# Final message
echo -e "\033[1;32m✓ Theme installed successfully!\033[0m"
echo -e "Type 'help-theme' for custom commands"
echo ""
EOF

# Create bashrc backup
echo -e "${YELLOW}[8] Creating bash configuration...${NC}"
cat > ~/.bashrc << 'EOF'
# RizxMods Bash Theme
PS1='\[\033[1;37m\]┌─[\[\033[1;31m\]$?\[\033[1;37m\]]─[\[\033[1;32m\]@rizxmods\[\033[1;37m\]]─[\[\033[1;33m\]\w\[\033[1;37m\]]\n\[\033[1;37m\]└──╼ \[\033[1;36m\]❯❯❯ \[\033[0m\]'

alias ls='ls --color=auto'
alias ll='ls -la'
alias cl='clear'
alias zsh='exec zsh'

clear
echo ""
echo "┌─────────────────────────────────┐"
echo "│   Bash Theme - @rizxmods        │"
echo "│   Type 'zsh' for full theme     │"
echo "└─────────────────────────────────┘"
echo ""
EOF

# Make ZSH default
echo -e "${YELLOW}[9] Setting ZSH as default shell...${NC}"
chsh -s zsh

# Create uninstall script
echo -e "${YELLOW}[10] Creating uninstall script...${NC}"
cat > ~/uninstall-rizxmods-theme.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

echo "Uninstalling RizxMods Theme..."
echo ""

# Restore backups
if [ -f ~/.termux-backup/.zshrc ]; then
    cp ~/.termux-backup/.zshrc ~/
    echo "✓ Restored .zshrc"
else
    rm ~/.zshrc
fi

if [ -f ~/.termux-backup/.bashrc ]; then
    cp ~/.termux-backup/.bashrc ~/
    echo "✓ Restored .bashrc"
else
    echo "# Default bashrc" > ~/.bashrc
fi

# Reset to bash
chsh -s bash

echo ""
echo "Theme uninstalled!"
echo "Restart Termux to apply"
EOF
chmod +x ~/uninstall-rizxmods-theme.sh

# Reload settings
echo -e "${YELLOW}[11] Reloading settings...${NC}"
termux-reload-settings

# Final
echo -e "${GREEN}"
cat << "EOF"
╔══════════════════════════════════════╗
║         INSTALLATION COMPLETE!      ║
╠══════════════════════════════════════╣
║ ✔  Color Scheme: Dracula            ║
║ ✔  Font: Meslo (Termux)             ║
║ ✔  Prompt: Custom RizxMods          ║
║ ✔  Dynamic ✓/✗ status               ║
║ ✔  Git integration                  ║
║ ✔  Aliases & functions              ║
╚══════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${CYAN}"
echo "=== YOUR PROMPT NOW ==="
echo "┌─[✓]─[@rizxmods]─[~]"
echo "└──╼ ❯❯❯ "
echo ""
echo "=== QUICK COMMANDS ==="
echo "help-theme       - Show theme commands"
echo "set-username abc - Change to @abc"
echo "theme-reload     - Reload theme"
echo "bash             - Switch to bash"
echo ""
echo "Close & reopen Termux or type:"
echo -e "${YELLOW}exec zsh${NC}"
echo ""

# Start ZSH
exec zsh
