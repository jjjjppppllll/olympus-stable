# Dossier où sont tes thèmes
W_DIR="$HOME/.config/waybar"

# On liste tes dossiers : Dock, Full-Bar, etc.
LIST=$(ls -d "$W_DIR"/*/ | xargs -n1 basename)

# On lance Rofi DIRECTEMENT avec la liste
CHOICE=$(echo -e "$LIST" | rofi -dmenu -i -p "📊 Select Style")

# Si on choisit un truc, on applique les liens
if [ -n "$CHOICE" ]; then
    ln -sf "$W_DIR/$CHOICE/config.jsonc" "$W_DIR/config.jsonc"
    ln -sf "$W_DIR/$CHOICE/style.css" "$W_DIR/style.css"
    
    pkill waybar
    sleep 0.2
    hyprctl dispatch exec waybar
    notify-send "Style $CHOICE appliqué"
fi
