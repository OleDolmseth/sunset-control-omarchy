#!/bin/bash
# Sunset Control uninstaller

set -e

echo "🗑️  Sunset Control Uninstaller"
echo "=============================="
echo ""

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Fjern script
BIN_FILE="$HOME/.local/share/omarchy/bin/sunset-control"
if [ -f "$BIN_FILE" ]; then
    rm "$BIN_FILE"
    print_success "Fjernet $BIN_FILE"
else
    print_info "Script ikke funnet, hopper over"
fi

# Fjern keybinding
BINDINGS_FILE="$HOME/.config/hypr/bindings.conf"
if [ -f "$BINDINGS_FILE" ]; then
    if grep -q "sunset-control" "$BINDINGS_FILE"; then
        sed -i '/sunset-control/d' "$BINDINGS_FILE"
        sed -i '/Sunset Control/d' "$BINDINGS_FILE"
        print_success "Fjernet keybinding fra $BINDINGS_FILE"
        
        print_info "Reloader Hyprland config..."
        hyprctl reload
        print_success "Config reloadet"
    else
        print_info "Ingen keybinding funnet, hopper over"
    fi
fi

# Stopp eventuelle kjørende prosesser
pkill -9 hyprsunset 2>/dev/null || true

echo ""
print_success "Avinstallasjon fullført!"
