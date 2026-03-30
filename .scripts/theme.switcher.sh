#!/usr/bin/env bash
PRESET_DIR="$HOME/.themes/presets"
WALL_DIR="$HOME/.themes/wallpapers"

CHOICE=$( (ls "$PRESET_DIR"; echo "Matugen") | \
    rofi -dmenu -i -p "󰃟 Thème" -config ~/.config/rofi/dmenu.rasi)

[[ -z "$CHOICE" ]] && exit 0

if [[ "$CHOICE" == "Matugen" ]]; then
    FULL_PATH=$(ls ~/Pictures/Wallpapers/*.{jpg,png,jpeg} 2>/dev/null | shuf -n 1)
    [[ -z "$FULL_PATH" ]] && exit 1
    swww img "$FULL_PATH" --transition-type center --transition-fps 60
    matugen image "$FULL_PATH"
else
    WALL_PATH=$(ls "$WALL_DIR/$CHOICE"/*.{jpg,png,jpeg} 2>/dev/null | shuf -n 1)
    [[ -n "$WALL_PATH" ]] && swww img "$WALL_PATH" --transition-type center --transition-fps 60

    [[ -f "$PRESET_DIR/$CHOICE/rofi/colors.rasi" ]] && \
        ln -sf "$PRESET_DIR/$CHOICE/rofi/colors.rasi" ~/.config/rofi/colors.rasi
    [[ -f "$PRESET_DIR/$CHOICE/waybar/theme.css" ]] && \
        ln -sf "$PRESET_DIR/$CHOICE/waybar/theme.css" ~/.config/waybar/theme.css
    [[ -f "$PRESET_DIR/$CHOICE/kitty/theme.conf" ]] && \
        ln -sf "$PRESET_DIR/$CHOICE/kitty/theme.conf" ~/.config/kitty/theme.conf

    pkill -SIGUSR1 kitty 2>/dev/null
fi

pkill -SIGUSR2 waybar
~/.scripts/update-wallpaper-thumb.sh
notify-send "Thème" "$CHOICE appliqué" --expire-time=2000
