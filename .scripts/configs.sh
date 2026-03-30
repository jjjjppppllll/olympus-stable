#!/usr/bin/env bash

# ===================================================================
# 📂 CONFIGURATION
# ===================================================================
HYPR_DIR="$HOME/.config/hypr"
WAYBAR_DIR="$HOME/.config/waybar"
# On cherche le dossier animations
[ -d "$HYPR_DIR/configs/animations" ] && ANIM_DIR="$HYPR_DIR/configs/animations" || ANIM_DIR="$HYPR_DIR"

EDITOR="codium"

# Style Rofi : "lines: 5" limite la hauteur, "fixed-height: 0" réduit le vide
ROFI_STYLE='
  window { width: 30%; border: 2px; border-radius: 12px; background-color: #1e1e2e; }
  listview { lines: 5; fixed-height: 0; scrollbar: false; }
  element { padding: 8px; }
  element-text { font: "JetBrains Mono 13"; vertical-align: 0.5; }
'

force_focus() {
    (for i in {1..5}; do sleep 0.05; hyprctl dispatch focuswindow "class:^(Rofi)$" > /dev/null 2>&1; done) &
}

# ===================================================================
# 🎨 MENU 1 : CHOIX DU DOSSIER
# ===================================================================
OPTIONS="1. Hyprland\n2. Waybar\n3. Animations"

force_focus
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "📁 Dossier" -config ~/.config/rofi/dmenu.rasi)

[[ -z "$CHOICE" ]] && exit 0

# ===================================================================
# 📝 MENU 2 : CHOIX DU FICHIER & OUVERTURE
# ===================================================================
case "$CHOICE" in
    *Hyprland)   TARGET_DIR="$HYPR_DIR"   ; FILTER="\.conf$" ;;
    *Waybar)     TARGET_DIR="$WAYBAR_DIR" ; FILTER="\.jsonc$|\.css$|\.conf$" ;;
    *Animations) TARGET_DIR="$ANIM_DIR"   ; FILTER="\.conf$" ;;
esac

if [ -d "$TARGET_DIR" ]; then
    force_focus
FILE=$(ls "$TARGET_DIR" | grep -E "$FILTER" | rofi -dmenu -i -p "📝 Fichier" -config ~/.config/rofi/dmenu.rasi)

    if [[ -n "$FILE" ]]; then
        $EDITOR "$TARGET_DIR/$FILE"
    fi
fi