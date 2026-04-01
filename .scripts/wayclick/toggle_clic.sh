#!/usr/bin/env bash

# On cherche tous les processus qui contiennent "clic.py" dans leur ligne de commande
# On exclut le grep lui-même pour ne pas se tirer dans le pied
PIDS=$(ps aux | grep "[c]lic.py" | awk '{print $2}')

if [ -n "$PIDS" ]; then
    # Si on trouve un ou plusieurs PIDs, on les tue tous
    echo "Fermeture des processus : $PIDS"
    kill -9 $PIDS
    notify-send "Sons Clavier" "Désactivés 🔇" -i audio-volume-muted -t 1500
else
    # Si rien ne tourne, on lance le moteur proprement
    python $HOME/.scripts/clic.py > /dev/null 2>&1 &
    notify-send "Sons Clavier" "Activés 🔊" -i audio-volume-high -t 1500
fi
