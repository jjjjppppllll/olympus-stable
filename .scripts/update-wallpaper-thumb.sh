#!/usr/bin/env bash
if [[ -n "$1" ]]; then
    WALL="$1"
else
    WALL=$(swww query 2>/dev/null | grep -oP '(?<=image: ).*' | head -1)
fi
[[ -z "$WALL" ]] && exit 0

TS=$(date +%s)
THUMB="$HOME/.config/fastfetch/thumb_${TS}.jpg"

ffmpeg -i "$WALL" -vf "crop=ih*2/3:ih,scale=400:-1" "$THUMB" -y -q:v 3 2>/dev/null

find "$HOME/.config/fastfetch/" -name "thumb_*.jpg" ! -name "thumb_${TS}.jpg" -delete 2>/dev/null
sed -i "s|thumb_[0-9]*.jpg|thumb_${TS}.jpg|g" "$HOME/.config/fastfetch/config.jsonc"
