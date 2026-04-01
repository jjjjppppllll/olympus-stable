#!/usr/bin/env bash

# CONFIGURATION
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
ROFI_THEME="$HOME/.config/rofi/wallpaper.rasi"

# On vérifie que le dossier existe
[[ ! -d "$WALLPAPER_DIR" ]] && notify-send "Erreur" "Dossier Wallpapers introuvable" && exit 1

cd "$WALLPAPER_DIR" || exit 1

# GÉNÉRATION DE LA LISTE POUR ROFI
# On utilise une méthode plus safe pour les noms de fichiers
SELECTED=$(find . -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.jpeg" -o -iname "*.webp" \) -printf "%f\n" | sort | while read -r f; do
    echo -en "$f\0icon\x1f$WALLPAPER_DIR/$f\n"
done | rofi -dmenu -i -show-icons -theme "$ROFI_THEME" -p " 󰸉 Wallpaper")

# Si on appuie sur Echap
[[ -z "$SELECTED" ]] && exit 0

FULL_PATH="$WALLPAPER_DIR/$SELECTED"

# 1. CHANGEMENT VISUEL IMMÉDIAT
swww img "$FULL_PATH" \
    --transition-type grow \
    --transition-duration 2 \
    --transition-fps 60 &

# 2. GÉNÉRATION DES COULEURS (Matugen s'occupe de SwayNC via le config.toml)
matugen image "$FULL_PATH" --source-color-index 0 -q

# 3. MISE À JOUR DE LA VIGNETTE (Pour Fastfetch ou autre)
~/.scripts/update-wallpaper-thumb.sh "$FULL_PATH"

# 4. NOTIFICATION FINALE
# Ajout d'une icône à la notif pour voir le résultat
notify-send -a "Wallpaper" -i "$FULL_PATH" "$(basename "$FULL_PATH")" "Hopla geiss !" -u low -t 2000