#!/usr/bin/env bash

# 📂 CONFIGURATION
WAYBAR_DIR="$HOME/.config/waybar"

# 1. RÉCUPÉRATION DES THÈMES
THEMES=$(ls -d "$WAYBAR_DIR"/*/ | xargs -n1 basename)

# 2. STYLE ROFI (Nettoyé de tout guillemet conflictuel)
ROFI_STYLE="window { width: 400px; border: 2px; border-radius: 12px; background-color: #1e1e2e; border-color: #89b4fa; } mainbox { padding: 10px; } listview { lines: 8; scrollbar: false; spacing: 5px; } element { padding: 8px; border-radius: 8px; } element-text { text-color: #cdd6f2; } element selected { background-color: #45475a; } element-text selected { text-color: #89b4fa; }"

# 3. FOCUS FIX
(for i in {1..5}; do sleep 0.05; hyprctl dispatch focuswindow "class:^(Rofi)$" > /dev/null 2>&1; done) &

# 4. SÉLECTION
CHOICE=$(echo -e "$THEMES" | rofi -dmenu -i -p "Waybar Style" -config ~/.config/rofi/dmenu.rasi)

[[ -z "$CHOICE" ]] && exit 0

# 5. APPLICATION
T_DIR="$WAYBAR_DIR/$CHOICE"

# On cherche les fichiers config et style (version robuste)
CONF=$(find "$T_DIR" -maxdepth 1 -name "config*" | head -n 1)
STYL=$(find "$T_DIR" -maxdepth 1 -name "style*" | head -n 1)

if [ -f "$CONF" ] && [ -f "$STYL" ]; then
    # Suppression des anciens liens
    rm -f "$WAYBAR_DIR/config.jsonc" "$WAYBAR_DIR/style.css"
    
    # Création des nouveaux liens
    ln -sf "$CONF" "$WAYBAR_DIR/config.jsonc"
    ln -sf "$STYL" "$WAYBAR_DIR/style.css"
    
    # Relance propre de Waybar
    pkill waybar
    sleep 0.2
    hyprctl dispatch exec waybar
    notify-send "Waybar" "Style $CHOICE activé"
else
    notify-send "Erreur" "Fichiers introuvables dans $CHOICE"
fi