#!/usr/bin/env bash
# Notification musicale avec cover art
# Dépendances : playerctl, notify-send, curl

LAST_TITLE=""

notify_track() {
    local title artist art_url art_file status

    status=$(playerctl status 2>/dev/null)
    [[ "$status" == "Stopped" ]] && return

    title=$(playerctl metadata title 2>/dev/null)
    [[ -z "$title" || "$title" == "$LAST_TITLE" ]] && return

    LAST_TITLE="$title"
    artist=$(playerctl metadata artist 2>/dev/null)
    art_url=$(playerctl metadata mpris:artUrl 2>/dev/null)
    art_file="/tmp/mpris_cover.jpg"

    # Télécharger la cover
    if [[ -n "$art_url" ]]; then
        if [[ "$art_url" == file://* ]]; then
            art_file="${art_url#file://}"
        else
            curl -sL "$art_url" -o "$art_file" &
        fi
    fi

    # Envoyer la notif
    notify-send \
        --app-name="Musique" \
        --urgency=low \
        --expire-time=3000 \
        --icon="$art_file" \
        "$title" \
        "$artist"
}

# Listen mode — déclenche à chaque changement de métadonnées
playerctl --follow metadata --format '{{title}}' 2>/dev/null | \
while read -r line; do
    notify_track
done