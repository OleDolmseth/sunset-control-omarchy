# Sunset Control for Omarchy

Interaktiv fargetemperatur-kontroll for hyprsunset med fzf-meny.

![Demo](demo.gif)

## Funksjoner

- 🌅 Interaktiv fzf-meny med 9 forhåndsdefinerte temperaturer
- ⌨️ Tastatursnarvei for rask tilgang
- 🔔 Notifikasjoner ved endring
- 🎨 Smooth overganger uten "flash"
- 💫 Overlever terminal-lukking

## Forutsetninger

- Omarchy Linux (eller Arch + Hyprland)
- `hyprsunset` (inkludert i Omarchy)
- `fzf` (fuzzy finder)
- En terminal (ghostty, alacritty, kitty, etc.)

## Installasjon

### Automatisk (anbefalt)
```bash
git clone https://github.com/dittbrukernavn/sunset-control-omarchy.git
cd sunset-control-omarchy
./install.sh
```

### Manuell installasjon

Se [Manuell Installasjon](#manuell-installasjon) lenger ned.

### 1. Installer avhengigheter
```bash
sudo pacman -S fzf
```

### 2. Installer scriptet
```bash
# Kopier scriptet til Omarchy sin bin-mappe
cp sunset-control ~/.local/share/omarchy/bin/

# Gjør det kjørbart
chmod +x ~/.local/share/omarchy/bin/sunset-control
```

### 3. Test scriptet
```bash
sunset-control
```

### 4. Legg til keybinding (valgfritt)

Åpne `~/.config/hypr/bindings.conf` og legg til:

**For Ghostty:**
```
bindd = SUPER_SHIFT, L, Sunset Control, exec, ghostty -e sunset-control
```

**For Alacritty:**
```
bindd = SUPER_SHIFT, L, Sunset Control, exec, alacritty -e sunset-control
```

**For Kitty:**
```
bindd = SUPER_SHIFT, L, Sunset Control, exec, kitty -e sunset-control
```

Last inn konfigen på nytt:
```bash
hyprctl reload
```

## Bruk

### Fra terminal:
```bash
sunset-control
```

### Med keybinding:
Trykk `SUPER + SHIFT + L`

### Navigering i menyen:
- Bruk **↑↓** for å navigere
- Skriv for å **fuzzy-søke** (f.eks. "natt")
- Trykk **Enter** for å velge
- Trykk **ESC** for å avbryte

## Tilpasning

### Endre temperaturer

Rediger scriptet:
```bash
nvim ~/.local/share/omarchy/bin/sunset-control
```

Endre `temps=()`-arrayen etter ønske.

### Endre keybinding

Rediger `~/.config/hypr/bindings.conf` og bytt `SUPER_SHIFT, L` til ønsket tastekombinasjon.

## Troubleshooting

### "command not found: sunset-control"

Sjekk at scriptet er i PATH:
```bash
which sunset-control
```

Hvis ikke, bruk full path i keybindingen:
```bash
/home/DITTBRUKERNAVN/.local/share/omarchy/bin/sunset-control
```

### Temperaturen forsvinner etter å ha lukket terminalen

Sørg for at scriptet bruker `nohup` og `disown` (dette skal være i scriptet allerede).

### Keybindingen funker ikke

1. Sjekk at tasten ikke er i bruk:
```bash
   grep "SUPER.*SHIFT.*L" ~/.config/hypr/bindings.conf
```

2. Prøv en annen tast (f.eks. `SUPER_SHIFT, S`)

## Hva du lærer

Dette prosjektet demonstrerer:
- Bash scripting (arrays, conditionals, process management)
- fzf for interaktive menyer
- Process lifecycle (`nohup`, `disown`, `pkill`)
- Hyprland keybindings
- Linux PATH og executable permissions

## Lisens

MIT License - bruk fritt!

## Bidrag

Pull requests er velkomne! For større endringer, åpne en issue først.

## Kreditter

Laget som et læringsprosjekt for Omarchy Linux.
Inspirert av behovet for enkel fargetemperatur-kontroll.
