#!/usr/bin/env bash
# Charger les couleurs du thème courant
COLORS_FILE="$HOME/.config/matugen/generated/shell-colors.sh"
[ -f "$COLORS_FILE" ] && source "$COLORS_FILE"
COL_SUB="${COLOR_SUBTEXT:-#a6adc8}"
COL_TXT="${COLOR_TEXT:-#ffffff}"
MAX_TITLE_LEN=28

print_status() {
    window=$(hyprctl activewindow -j 2>/dev/null)
    address=$(jq -r '.address // empty' <<< "$window")

    # No active window → show Desktop + Workspace
    if [[ -z "$address" || "$address" == "null" ]]; then
        ws=$(hyprctl activeworkspace -j | jq -r '.id')

        top_line="Desktop"
        bottom_line="Workspace $ws"

        esc_top=$(sed 's/&/&amp;/g; s/</&lt;/g; s/>/&gt;/g' <<< "$top_line")
        esc_bottom=$(sed 's/&/&amp;/g; s/</&lt;/g; s/>/&gt;/g' <<< "$bottom_line")

        text="<span size='7500' foreground='$COL_SUB' rise='-2000'>$esc_top</span>
<span size='9000' weight='bold' foreground='$COL_TXT'>$esc_bottom</span>"

        jq -nc \
            --arg text "$text" \
            --arg tooltip "$bottom_line" \
            '{ text: $text, class: "custom-window", tooltip: $tooltip }'
        return
    fi

    class=$(jq -r '.class // "Unknown"' <<< "$window")
    title=$(jq -r '.title // ""' <<< "$window")

    app_class="${class,,}"

    # Discord / Vesktop cleanup
    if [[ "$app_class" == *discord* || "$app_class" == *vesktop* ]]; then
        title=$(sed -E 's/^\([0-9]+\)[[:space:]]*//' <<< "$title")
        title=$(sed -E 's/^Discord[[:space:]]*\|[[:space:]]*//' <<< "$title")
    fi

    # Truncate title
    if (( ${#title} > MAX_TITLE_LEN )); then
        title="${title:0:$((MAX_TITLE_LEN-3))}..."
    fi

    esc_top=$(sed 's/&/&amp;/g; s/</&lt;/g; s/>/&gt;/g' <<< "$class")
    esc_bottom=$(sed 's/&/&amp;/g; s/</&lt;/g; s/>/&gt;/g' <<< "$title")

    text="<span size='7500' foreground='#a6adc8' rise='-2000'>$esc_top</span>
<span size='9000' weight='bold' foreground='#ffffff'>$esc_bottom</span>"

    tooltip="$class: $title"

    jq -nc \
        --arg text "$text" \
        --arg tooltip "$tooltip" \
        '{ text: $text, class: "custom-window", tooltip: $tooltip }'
}

# Initial output
print_status

# Écouter les événements Hyprland via le socket
SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
socat -u UNIX-CONNECT:"$SOCKET" - 2>/dev/null | \
while IFS= read -r event; do
case "$event" in
activewindow*|workspace*|closewindow*|openwindow*)
print_status ;;
esac
done