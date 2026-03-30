#!/usr/bin/env bash

# On définit le dossier UNIQUE pour les animations
ANIM_DIR="$HOME/.config/hypr/animations"
mkdir -p "$ANIM_DIR"

# Style Rofi Compact
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
# 🎨 SÉLECTION (On ne liste QUE ce qui est dans $ANIM_DIR)
# ===================================================================
force_focus
CHOICE=$(ls "$ANIM_DIR" 2>/dev/null | grep ".conf" | grep -v "current_animations.conf" | sed 's/\.conf//' | rofi -dmenu -i -p "✨ Animations" -config ~/.config/rofi/dmenu.rasi)
[[ -z "$CHOICE" ]] && exit 0

# ===================================================================
# 🚀 APPLICATION
# ===================================================================
SOURCE_FILE="$ANIM_DIR/$CHOICE.conf"
TARGET_LINK="$ANIM_DIR/current_animations.conf"

if [[ -f "$SOURCE_FILE" ]]; then
    ln -sf "$SOURCE_FILE" "$TARGET_LINK"
    hyprctl reload
    notify-send -a "System" "✨ Animations : $CHOICE appliquées"
else
    notify-send -a "System" "❌ Erreur : Fichier introuvable"
fi