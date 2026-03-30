#!/usr/bin/env bash

# Dossier du moteur de sons
cd "$HOME/.scripts/wayclick/"

# Vérification des dépendances pour le son
if ! command -v uv &> /dev/null; then
    notify-send "Erreur" "Le moteur 'uv' n'est pas installé."
    exit 1
fi

# Lancement du moteur de clic avec ta config
# On utilise 'nohup' pour qu'il tourne en arrière-plan
nohup uv run wayclick --config "$HOME/.config/wayclick/config.json" > /dev/null 2>&1 &

notify-send "WayClick" "Sons de clic activés (Pack 1)"