#!/usr/bin/env bash
ZEN_LOCK="/tmp/hypr_zen_mode"
ZEN_WALLPAPER="$HOME/Pictures/Wallpapers/zen.jpg"

if [[ -f "$ZEN_LOCK" ]]; then
    rm -f "$ZEN_LOCK"
    pkill -SIGUSR1 waybar
    hyprctl dispatch fullscreen 0
    PREV_WALL=$(cat /tmp/hypr_prev_wallpaper 2>/dev/null)
    [[ -n "$PREV_WALL" ]] && swww img "$PREV_WALL" --transition-type fade --transition-duration 1
    notify-send "Mode Zen" "Désactivé" --expire-time=1500
else
    touch "$ZEN_LOCK"
    swww query | grep -oP '(?<=image: ).*' | head -1 > /tmp/hypr_prev_wallpaper
    pkill -SIGUSR1 waybar
    hyprctl dispatch fullscreen 0
    [[ -f "$ZEN_WALLPAPER" ]] && swww img "$ZEN_WALLPAPER" --transition-type fade --transition-duration 1
    notify-send "Mode Zen" "Activé" --expire-time=2000
fi
