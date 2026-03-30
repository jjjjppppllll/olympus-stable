#!/bin/bash
# ~/.scripts/toggle-keyboard.sh

# 1. Récupération du layout actuel (format JSON pour éviter les erreurs de parsing)
CURRENT=$(hyprctl getoption input:kb_layout -j | jq -r '.str' | tr -d '"')

if [ "$CURRENT" = "fr" ]; then
    # Passage en US International
    # On utilise --batch pour envoyer les deux ordres d'un coup
    hyprctl --batch "keyword input:kb_layout us; keyword input:kb_variant intl"
    
    # On sauvegarde l'état pour que Matugen puisse le restaurer
    echo "us" > /tmp/hypr_kb_layout
    echo "intl" > /tmp/hypr_kb_variant
else
    # Retour en FR
    # IMPORTANT : On vide la variante AVANT de changer le layout pour éviter l'erreur rouge
    hyprctl keyword input:kb_variant ""
    hyprctl keyword input:kb_layout fr
    
    # On sauvegarde l'état pour que Matugen puisse le restaurer
    echo "fr" > /tmp/hypr_kb_layout
    echo "" > /tmp/hypr_kb_variant
fi