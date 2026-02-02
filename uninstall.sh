#!/data/data/com.termux/files/usr/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${RED}"
echo "╔══════════════════════════════════════╗"
echo "║    UNINSTALL TERMUX THEME           ║"
echo "║    RIZXMODS EDITION                 ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"

echo ""
echo -e "${YELLOW}This will remove:${NC}"
echo "• Custom theme configuration"
echo "• ZSH settings"
echo "• Color schemes"
echo "• Custom aliases"
echo ""

read -p "Are you sure? (y/N): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Cancelled.${NC}"
    exit 0
fi

echo ""
echo -e "${YELLOW}[1] Restoring default colors...${NC}"
cat > ~/.termux/colors.properties << 'EOF'
# Termux Default Colors
background=#000000
foreground=#ffffff
color0=#000000
color1=#FF0000
color2=#00FF00
color3=#FFFF00
color4=#0000FF
color5=#FF00FF
color6=#00FFFF
color7=#FFFFFF
color8=#555555
color9=#FF5555
color10=#55FF55
color11=#FFFF55
color12=#5555FF
color13=#FF55FF
color14=#55FFFF
color15=#FFFFFF
EOF

echo -e "${YELLOW}[2] Removing theme files...${NC}"
rm -f ~/.zshrc
rm -f ~/.bashrc
rm -f ~/.termux/font.ttf 2>/dev/null

echo -e "${YELLOW}[3] Resetting to bash...${NC}"
chsh -s bash

echo -e "${YELLOW}[4] Creating default bashrc...${NC}"
cat > ~/.bashrc << 'EOF'
# Default Termux bashrc
PS1='\w \$ '
alias ls='ls --color=auto'
EOF

echo -e "${YELLOW}[5] Reloading settings...${NC}"
termux-reload-settings

echo ""
echo -e "${GREEN}"
echo "╔══════════════════════════════════════╗"
echo "║      THEME UNINSTALLED!             ║"
echo "║      Restart Termux to apply        ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"

echo ""
echo -e "${YELLOW}To reinstall:${NC}"
echo "• Simple theme: bash install.sh"
echo "• PRO theme:    bash install2.sh"
echo ""

# Restart bash
exec bash
