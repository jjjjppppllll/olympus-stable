# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Salutation d'Olympus
krabby random --no-title
echo "" # Petit espace pour respirer
fastfetch

# Created by `pipx` on 2026-03-28 15:33:53
export PATH="$PATH:/home/athena/.local/bin"

export PATH=$PATH:/home/athena/.spicetify
alias theme='matugen image $1 && spicetify apply'

alias batt80='sudo tlp setcharge 75 80'
alias batt100='sudo tlp fullcharge'

# --- Optimisation Olympus ---

# Raccourcis pour surveiller la consommation
alias pwr='powertop'
alias gpu='sudo radeontop'
alias usage='btop' # Si tu l'as installé, sinon 'top' ou 'htop'

# Maintenance rapide d'Arch
alias up='sudo pacman -Syu'
alias yup='yay -Syu' # Si tu utilises yay pour l'AUR

# Raccourci pour éditer ce fichier et recharger la config
alias zconf='nvim ~/.zshrc'
alias zsrc='source ~/.zshrc && echo "Config rechargée !"'

# Toggle Radio (pour couper le modem s'il se réveille)
alias wwanoff='nmcli radio wwan off'
alias wwanon='nmcli radio wwan on'

# Fix Diode Micro (F4) - à tester si elle reste allumée
alias ledoff="brightnessctl --device='platform::micmute' set 0"

# Fonction d'automatisation GHunt avec Horodatage Précis
gtrace() {
    local email=$1
    if [[ -z "$email" ]]; then
        echo "Usage: gtrace <email>"
        return 1
    fi

    # Extraire la date et l'heure (Ex: 2026-03-30_19h05)
    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    
    # Extraire ce qu'il y a avant le @
    local ident=${email%%@*}
    
    # Chemin du fichier dans ton dossier exports
    local filename="${timestamp}-${ident}_ghunt.txt"
    local output="$HOME/Documents/OSINT/exports/$filename"

    echo "🕷️  Spidering $email..."
    echo "📂 Destination : $filename"

    # Exécution de GHunt via ton alias existant
    # On utilise "command ghunt" pour être sûr d'appeler l'alias/binaire
    ghunt email "$email" > "$output"

    if [[ $? -eq 0 ]]; then
        echo "✅ Rapport généré avec succès dans exports/"
    else
        echo "⚠️  GHunt a rencontré une erreur (vérifie ta session ou l'email)."
    fi
}

investigate() {
    local target=$1
    if [[ -z "$target" ]]; then
        echo "Usage: investigate <username>"
        return 1
    fi

    # Horodatage
    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    
    # Nom de base pour les rapports Maigret
    local report_name="${timestamp}-${target}_maigret"
    local export_dir="$HOME/Documents/OSINT/exports"

    echo "🔍 Enquête Maigret sur : $target"
    echo "📄 Génération des rapports dans $export_dir..."

    # Lancement de maigret avec options de rapport propres
    # --txt : génère un résumé texte des résultats trouvés uniquement
    # --folder : définit où enregistrer les rapports
    python3 -m maigret "$target" --folder "$export_dir" --txt

    # On renomme le fichier généré par maigret pour qu'il suive TA nomenclature
    # Maigret crée par défaut "report_<target>.txt"
    if [[ -f "$export_dir/report_${target}.txt" ]]; then
        mv "$export_dir/report_${target}.txt" "$export_dir/${report_name}.txt"
        echo "✅ Rapport texte propre : ${report_name}.txt"
    fi
}

# Fonction d'automatisation Holehe (Vérification d'inscription par mail)
check_mail() {
    local email=$1
    if [[ -z "$email" ]]; then
        echo "Usage: check_mail <email>"
        return 1
    fi

    # Horodatage précis (comme les autres)
    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    
    # Extraire le préfixe
    local ident=${email%%@*}
    
    # Nom du fichier final
    local filename="${timestamp}-${ident}_holehe.txt"
    local output="$HOME/Documents/OSINT/exports/$filename"

    echo "🔍 Holehe vérifie les inscriptions pour : $email"
    echo "📂 Archivage dans : $filename"

    # Exécution de holehe
    # --only-used : n'affiche que les sites où le compte existe (évite le bruit)
    # --no-color : pour un fichier texte propre
    holehe "$email" --only-used --no-color > "$output"

    if [[ $? -eq 0 ]]; then
        echo "✅ Inscriptions trouvées enregistrées dans exports/"
    else
        echo "⚠️  Holehe a rencontré une erreur."
    fi
}

# Fonction d'automatisation Sherlock (Recherche rapide de pseudo)
hunt_user() {
    local target=$1
    if [[ -z "$target" ]]; then
        echo "Usage: hunt_user <username>"
        return 1
    fi

    # Horodatage
    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    
    # Nom du fichier final
    local filename="${timestamp}-${target}_sherlock.txt"
    local output="$HOME/Documents/OSINT/exports/$filename"

    echo "🕵️  Sherlock traque le pseudo : $target"
    echo "📂 Archivage dans : $filename"

    # Exécution de Sherlock
    # --folderout : définit le dossier où Sherlock crée son propre rapport
    # --print-found : n'affiche que les comptes trouvés (plus propre)
    # On redirige le résultat texte final vers ton dossier exports
    
    # Note : Si 'sherlock' n'est pas dans ton PATH, remplace par 
    # python3 ~/Documents/OSINT/tools/sherlock/sherlock "$target"
    sherlock "$target" --print-found --no-color > "$output"

    if [[ $? -eq 0 ]]; then
        # Sherlock crée aussi un fichier .txt par défaut dans son propre dossier, 
        # on peut le supprimer car on a déjà redirigé la sortie vers 'exports'
        rm -f "${target}.txt" 2>/dev/null
        echo "✅ Sherlock a terminé. Rapport dans exports/"
    else
        echo "⚠️  Sherlock a rencontré un problème."
    fi
}

# Fonction d'automatisation Socialscan (Vérification rapide Email/Pseudo)
scan_social() {
    local target=$1
    if [[ -z "$target" ]]; then
        echo "Usage: scan_social <email_or_username>"
        return 1
    fi

    # Horodatage
    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    
    # Extraire l'identifiant (gère email ou pseudo simple)
    local ident=${target%%@*}
    
    # Nom du fichier final
    local filename="${timestamp}-${ident}_socialscan.txt"
    local output="$HOME/Documents/OSINT/exports/$filename"

    echo "🔍 Socialscan interroge les plateformes pour : $target"
    echo "📂 Archivage dans : $filename"

    # Exécution de socialscan
    # On redirige le résultat vers le fichier
    socialscan "$target" > "$output"

    if [[ $? -eq 0 ]]; then
        echo "✅ Socialscan a terminé. Rapport dans exports/"
    else
        echo "⚠️  Socialscan a rencontré une erreur (vérifie s'il est bien installé)."
    fi
}

archive_insta() {
    local target=$1
    local sock_user="TON_NOM_UTILISATEUR_INSTA" # <--- METS TON PSEUDO ICI
    
    if [[ -z "$target" ]]; then
        echo "Usage: archive_insta <username>"
        return 1
    fi

    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    local export_dir="$HOME/Documents/OSINT/exports/${timestamp}-${target}_instagram"
    mkdir -p "$export_dir"

    echo "📸 Tentative d'archivage de : $target avec le compte $sock_user"
    
    # On ajoute --login pour éviter le 403
    # --no-video-thumbnails pour gagner du temps et de la place
    instaloader --login "$sock_user" --dirname-pattern="$export_dir" --no-video-thumbnails "$target"

    if [[ $? -eq 0 ]]; then
        echo "✅ Mission accomplie dans : $export_dir"
    else
        echo "❌ Échec. Instagram a bloqué la requête (403/401). Change de session ou de VPN."
    fi
}

# La Forge d'Enquête : Crée une structure de dossier propre
new_case() {
    local case_name=$1
    if [[ -z "$case_name" ]]; then
        echo "Usage: new_case <nom_de_l_affaire>"
        return 1
    fi

    local date=$(date +%Y-%m-%d)
    local full_path="$HOME/Documents/OSINT/Targets/${date}_${case_name}"

    # Création de l'arborescence de combat
    mkdir -p "$full_path"/{reports,evidence,notes,screenshots}

    echo "🏛️  Nouvelle affaire ouverte : ${date}_${case_name}"
    echo "📂 Chemin : $full_path"
    
    # On se déplace directement dedans pour commencer à bosser
    cd "$full_path"
    
    # On crée un fichier de notes vide pour démarrer
    touch "notes/investigation_log.md"
}

# Fonction d'analyse de numéro de téléphone (OSINT)
trace_phone() {
    local phone=$1
    if [[ -z "$phone" ]]; then
        echo "Usage: trace_phone +33612345678"
        return 1
    fi

    # Horodatage
    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    
    # Nettoyage du numéro pour le nom de fichier (on enlève le +)
    local clean_phone=$(echo "$phone" | sed 's/+//g')
    
    # Nom du fichier final
    local filename="${timestamp}-${clean_phone}_phoneinfoga.txt"
    local output="$HOME/Documents/OSINT/exports/$filename"

    echo "📞 Analyse du numéro : $phone"
    echo "📂 Archivage dans : $filename"

    # Exécution de PhoneInfoga
    # scan : lance l'analyse
    # -n : spécifie le numéro (format international requis)
    phoneinfoga scan -n "$phone" > "$output"

    if [[ $? -eq 0 ]]; then
        echo "✅ Analyse terminée. Rapport disponible dans exports/"
        echo "💡 Astuce : Regarde les liens 'Google Dorks' dans le rapport pour fouiller le web."
    else
        echo "⚠️  PhoneInfoga a rencontré une erreur. Vérifie l'installation ou le format (+33...)."
    fi
}
