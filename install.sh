#!/data/data/com.termux/files/usr/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
clear
echo -e "${CYAN}"
cat << "EOF"
╔══════════════════════════════════════════╗
║    TERMUX ULTIMATE THEME - RIZXMODS     ║
║         ALL-IN-ONE INSTALLER            ║
╚══════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Check if running in Termux
if [ ! -d "/data/data/com.termux/files/usr" ]; then
    echo -e "${RED}[!] This script must be run in Termux${NC}"
    exit 1
fi

# Update packages
echo -e "${YELLOW}[1] Updating packages...${NC}"
pkg update -y && pkg upgrade -y

# Install dependencies
echo -e "${YELLOW}[2] Installing dependencies...${NC}"
pkg install -y git zsh wget curl neofetch figlet lolcat cowsay nano

# Backup existing files
echo -e "${YELLOW}[3] Backing up existing configs...${NC}"
mkdir -p ~/.termux-backup
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.termux-backup/
[ -f ~/.bashrc ] && cp ~/.bashrc ~/.termux-backup/
[ -f ~/.termux/colors.properties ] && cp ~/.termux/colors.properties ~/.termux-backup/

# Install Dracula Color Scheme
echo -e "${YELLOW}[4] Installing Dracula color scheme...${NC}"
curl -fsSL https://raw.githubusercontent.com/dracula/termux/master/colors.properties -o ~/.termux/colors.properties

# Install Hack Font
echo -e "${YELLOW}[5] Installing Hack Nerd Font...${NC}"
curl -fsSL "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf" -o ~/.termux/font.ttf

# Install Oh-My-Zsh
echo -e "${YELLOW}[6] Installing Oh-My-Zsh...${NC}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install ZSH plugins
echo -e "${YELLOW}[7] Installing ZSH plugins...${NC}"
# Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null || true
# Auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null || true
# Completions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions 2>/dev/null || true

# Create custom theme
echo -e "${YELLOW}[8] Creating custom theme...${NC}"
cat > ~/.oh-my-zsh/custom/themes/rizxmods.zsh-theme << 'EOF'
# RizxMods Custom Theme

# Colors
local red="%F{196}"
local green="%F{082}"
local yellow="%F{226}"
local blue="%F{039}"
local magenta="%F{201}"
local cyan="%F{051}"
local white="%F{255}"
local reset="%f"

# Prompt setup
precmd() {
    # Get exit code
    local exit_code=$?
    
    # Set status symbol
    if [[ $exit_code -eq 0 ]]; then
        STATUS="${green}✓${reset}"
    else
        STATUS="${red}✗${reset}"
    fi
    
    # Git info
    local git_info=""
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        git_branch="$(git branch --show-current)"
        git_info="${magenta}[${git_branch}]${reset}"
    fi
    
    # Set prompt
    PROMPT="${white}┌─[${STATUS}]─[${green}@rizxmods${white}]─[${yellow}%~${white}] ${git_info}
${white}└──╼ ${cyan}❯❯❯ ${reset}"
    
    # Right prompt with time
    RPROMPT="${blue}%T${reset}"
}

setopt prompt_subst
EOF

# Configure .zshrc
echo -e "${YELLOW}[9] Configuring ZSH...${NC}"
cat > ~/.zshrc << 'EOF'
# ============================================
# RIZXMODS TERMUX THEME CONFIGURATION
# ============================================

# Oh-My-Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="rizxmods"

# Plugins
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
    sudo
    copyfile
    dirhistory
    history
)

source $ZSH/oh-my-zsh.sh

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

# Theme related
alias theme-reload="source ~/.zshrc"
alias theme-backup="cp ~/.zshrc ~/.termux-backup/zshrc-\$(date +%Y%m%d)"
alias theme-restore="cp ~/.termux-backup/zshrc-* ~/.zshrc"

# Fun
alias matrix="cmatrix"
alias starwars="telnet towel.blinkenlights.nl"
alias fortune="fortune | cowsay | lolcat"

# Git shortcuts
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph"

# ============================================
# FUNCTIONS
# ============================================

# Welcome message
welcome() {
    clear
    echo ""
    figlet "RIZXMODS" | lolcat
    echo ""
    echo -e "\033[1;36mTermux Ultimate Theme\033[0m"
    echo -e "\033[1;33mType 'help-theme' for custom commands\033[0m"
    echo ""
    neofetch --ascii_distro termux 2>/dev/null || echo "Run: pkg install neofetch"
    echo ""
}

# Help command
help-theme() {
    echo ""
    echo -e "\033[1;36m=== RIZXMODS THEME COMMANDS ===\033[0m"
    echo ""
    echo -e "\033[1;33mTheme Commands:\033[0m"
    echo "  theme-reload    - Reload theme"
    echo "  theme-backup    - Backup current config"
    echo "  theme-restore   - Restore from backup"
    echo ""
    echo -e "\033[1;33mFun Commands:\033[0m"
    echo "  matrix          - Matrix animation"
    echo "  starwars        - Watch Star Wars ASCII"
    echo "  fortune         - Random fortune cookie"
    echo ""
}

# Change prompt username
set-username() {
    if [ -z "$1" ]; then
        echo "Usage: set-username <new_name>"
        return 1
    fi
    sed -i "s/@rizxmods/@$1/g" ~/.oh-my-zsh/custom/themes/rizxmods.zsh-theme
    source ~/.zshrc
    echo "Username changed to @$1"
}

# ============================================
# STARTUP
# ============================================

# Show welcome message
welcome

# Auto CD
setopt autocd

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Key bindings
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Completion
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Final message
echo ""
echo -e "\033[1;32m✓ Theme installed successfully!\033[0m"
echo -e "\033[1;36mRestart Termux for best experience\033[0m"
echo ""
EOF

# Create bashrc for bash users
echo -e "${YELLOW}[10] Creating bash configuration...${NC}"
cat > ~/.bashrc << 'EOF'
# RizxMods Bash Theme

# Prompt
PS1='\[\033[1;37m\]┌─[\[\033[1;31m\]$?\[\033[1;37m\]]─[\[\033[1;32m\]@rizxmods\[\033[1;37m\]]─[\[\033[1;33m\]\w\[\033[1;37m\]]\n\[\033[1;37m\]└──╼ \[\033[1;36m\]❯❯❯ \[\033[0m\]'

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias cl='clear'
alias update='pkg update && pkg upgrade -y'

# Welcome
clear
echo ""
echo "┌─────────────────────────────────┐"
echo "│   Bash Theme - @rizxmods        │"
echo "│   Run 'exec zsh' for ZSH        │"
echo "└─────────────────────────────────┘"
echo ""
EOF

# Set ZSH as default
echo -e "${YELLOW}[11] Setting ZSH as default shell...${NC}"
chsh -s zsh

# Create uninstall script
echo -e "${YELLOW}[12] Creating uninstall script...${NC}"
cat > ~/uninstall-theme.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

echo "Uninstalling RizxMods Theme..."
echo ""

# Restore backups
if [ -f ~/.termux-backup/.zshrc ]; then
    cp ~/.termux-backup/.zshrc ~/
    echo "✓ Restored .zshrc"
fi

if [ -f ~/.termux-backup/.bashrc ]; then
    cp ~/.termux-backup/.bashrc ~/
    echo "✓ Restored .bashrc"
fi

if [ -f ~/.termux-backup/colors.properties ]; then
    cp ~/.termux-backup/colors.properties ~/.termux/
    echo "✓ Restored colors.properties"
fi

# Remove theme files
rm -f ~/.oh-my-zsh/custom/themes/rizxmods.zsh-theme
rm -f ~/termux-theme

echo ""
echo "Theme uninstalled!"
echo "Restart Termux to apply changes"
EOF
chmod +x ~/uninstall-theme.sh

# Reload Termux settings
echo -e "${YELLOW}[13] Reloading Termux settings...${NC}"
termux-reload-settings

# Final output
echo -e "${GREEN}"
cat << "EOF"
╔══════════════════════════════════════════╗
║         INSTALLATION COMPLETE!           ║
╠══════════════════════════════════════════╣
║ ✔  Color Scheme: Dracula                ║
║ ✔  Font: Hack Nerd Font                 ║
║ ✔  Theme: Custom RizxMods               ║
║ ✔  Prompt: Dynamic ✓/✗ status           ║
║ ✔  Plugins: Syntax & Auto-suggest       ║
║ ✔  Aliases: Custom shortcuts            ║
╚══════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${CYAN}"
echo "=== USAGE ==="
echo "Command line will now show:"
echo "┌─[✓]─[@rizxmods]─[~]"
echo "└──╼ ❯❯❯ "
echo ""
echo "=== COMMANDS ==="
echo "help-theme     - Show theme commands"
echo "set-username   - Change prompt name"
echo "theme-reload   - Reload theme"
echo "uninstall-theme.sh - Remove theme"
echo ""
echo "=== NOTE ==="
echo "Close and reopen Termux for best results"
echo -e "${NC}"

# Source the new zshrc
source ~/.zshrc 2>/dev/null || exec zsh
