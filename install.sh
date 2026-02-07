#!/bin/bash
# Sunset Control installer for Omarchy

set -e  # Stopp ved feil

echo "🌅 Sunset Control Installer for Omarchy"
echo "========================================"
echo ""

# Farger for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Funksjon for å printe med farge
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Sjekk at vi kjører på Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    print_error "Dette scriptet er kun for Linux"
    exit 1
fi

# Sjekk avhengigheter
print_info "Sjekker avhengigheter..."

if ! command -v fzf &> /dev/null; then
    print_info "fzf ikke funnet. Installerer..."
    sudo pacman -S --noconfirm fzf
    print_success "fzf installert"
else
    print_success "fzf funnet"
fi

if ! command -v hyprsunset &> /dev/null; then
    print_error "hyprsunset ikke funnet. Sørg for at du kjører Omarchy."
    exit 1
else
    print_success "hyprsunset funnet"
fi

# Lag bin-mappe hvis den ikke finnes
BIN_DIR="$HOME/.local/share/omarchy/bin"
if [ ! -d "$BIN_DIR" ]; then
    print_info "Lager $BIN_DIR..."
    mkdir -p "$BIN_DIR"
    print_success "Mappe laget"
fi

# Kopier script
print_info "Installerer sunset-control..."
cp sunset-control "$BIN_DIR/sunset-control"
chmod +x "$BIN_DIR/sunset-control"
print_success "Script installert til $BIN_DIR/sunset-control"

# Sjekk om scriptet er i PATH
if command -v sunset-control &> /dev/null; then
    print_success "sunset-control er i PATH"
else
    print_info "sunset-control er IKKE i PATH, men kan kjøres med full path"
fi

# Spør om keybinding
echo ""
print_info "Vil du legge til keybinding? (SUPER + SHIFT + L)"
read -p "Legg til keybinding? [y/N]: " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Detekter hvilken terminal som brukes
    TERMINAL=""
    if command -v ghostty &> /dev/null; then
        TERMINAL="ghostty"
    elif command -v alacritty &> /dev/null; then
        TERMINAL="alacritty"
    elif command -v kitty &> /dev/null; then
        TERMINAL="kitty"
    else
        print_error "Ingen støttet terminal funnet (ghostty, alacritty, kitty)"
        exit 1
    fi
    
    print_info "Bruker terminal: $TERMINAL"
    
    BINDINGS_FILE="$HOME/.config/hypr/bindings.conf"
    
    if [ ! -f "$BINDINGS_FILE" ]; then
        print_error "Finner ikke $BINDINGS_FILE"
        print_info "Legg til denne linjen manuelt i din Hyprland config:"
        echo "bindd = SUPER_SHIFT, L, Sunset Control, exec, $TERMINAL -e sunset-control"
    else
        # Sjekk om bindingen allerede finnes
        if grep -q "sunset-control" "$BINDINGS_FILE"; then
            print_info "Keybinding finnes allerede, hopper over"
        else
            echo "" >> "$BINDINGS_FILE"
            echo "# Sunset Control - Blue light filter" >> "$BINDINGS_FILE"
            echo "bindd = SUPER_SHIFT, L, Sunset Control, exec, $TERMINAL -e sunset-control" >> "$BINDINGS_FILE"
            print_success "Keybinding lagt til i $BINDINGS_FILE"
            
            # Reload Hyprland config
            print_info "Reloader Hyprland config..."
            hyprctl reload
            print_success "Config reloadet"
        fi
    fi
fi

echo ""
print_success "Installasjon fullført! 🎉"
echo ""
print_info "Bruk:"
echo "  - Kjør fra terminal: sunset-control"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "  - Keybinding: SUPER + SHIFT + L"
fi
echo ""
print_info "For å avinstallere, kjør: ./uninstall.sh"
