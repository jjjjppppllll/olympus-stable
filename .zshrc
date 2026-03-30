####################
####################
# OLYMPUS ZSHRC V1.0
####################
####################

##########
# SYS VARS
##########

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

###################
# SYS CUSTOMIZATION
###################

# FASTFETCH PKM
krabby random --no-title
echo ""
fastfetch

# Created by `pipx` on 2026-03-28 15:33:53
export PATH="$PATH:/home/athena/.local/bin"

# SPICETIFY
export PATH=$PATH:/home/athena/.spicetify
alias theme='matugen image $1 && spicetify apply'

##################
# SYS OPTIMIZATION
##################

# POWER MONITOR
alias pwr='powertop'
alias gpu='sudo radeontop'
alias usage='btop'

# POWER LIMIT
alias batt80='sudo tlp setcharge 75 80'
alias batt100='sudo tlp fullcharge'

# QUICK UPDATE
alias up='sudo pacman -Syu'
alias yup='yay -Syu' # Si tu utilises yay pour l'AUR

# ZSHRC EDIT
alias zconf='nvim ~/.zshrc'
alias zsrc='source ~/.zshrc && echo "Config rechargée !"'

# STEALTHMODE
alias wwanoff='nmcli radio wwan off'
alias wwanon='nmcli radio wwan on'

# Fix Diode Micro (F4) - à tester si elle reste allumée
alias ledoff="brightnessctl --device='platform::micmute' set 0"

#######
# OSINT
#######

# GHUNT
gtrace() {
    local email=$1
    if [[ -z "$email" ]]; then
        echo "Usage: gtrace <email>"
        return 1
    fi

    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    
    local ident=${email%%@*}
    
    local filename="${timestamp}-${ident}_ghunt.txt"
    local output="$HOME/Documents/OSINT/exports/$filename"

    echo "🕷️  Spidering $email..."
    echo "📂 Destination : $filename"

    ghunt email "$email" > "$output"

    if [[ $? -eq 0 ]]; then
        echo "✅ Rapport généré avec succès dans exports/"
    else
        echo "⚠️  GHunt a rencontré une erreur (vérifie ta session ou l'email)."
    fi
}

# MAIGRET
investigate() {
    local target=$1
    if [[ -z "$target" ]]; then
        echo "Usage: investigate <username>"
        return 1
    fi

    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    
    local report_name="${timestamp}-${target}_maigret"
    local export_dir="$HOME/Documents/OSINT/exports"

    echo "🔍 Enquête Maigret sur : $target"
    echo "📄 Génération des rapports dans $export_dir..."

    python3 -m maigret "$target" --folder "$export_dir" --txt

    if [[ -f "$export_dir/report_${target}.txt" ]]; then
        mv "$export_dir/report_${target}.txt" "$export_dir/${report_name}.txt"
        echo "✅ Rapport texte propre : ${report_name}.txt"
    fi
}

# HOLEHE
check_mail() {
    local email=$1
    if [[ -z "$email" ]]; then
        echo "Usage: check_mail <email>"
        return 1
    fi

    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    
    local ident=${email%%@*}
    
    local filename="${timestamp}-${ident}_holehe.txt"
    local output="$HOME/Documents/OSINT/exports/$filename"

    echo "🔍 Holehe vérifie les inscriptions pour : $email"
    echo "📂 Archivage dans : $filename"

    holehe "$email" --only-used --no-color > "$output"

    if [[ $? -eq 0 ]]; then
        echo "✅ Inscriptions trouvées enregistrées dans exports/"
    else
        echo "⚠️  Holehe a rencontré une erreur."
    fi
}

# SHERLOCK
hunt_user() {
    local target=$1
    if [[ -z "$target" ]]; then
        echo "Usage: hunt_user <username>"
        return 1
    fi

    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    
    local filename="${timestamp}-${target}_sherlock.txt"
    local output="$HOME/Documents/OSINT/exports/$filename"

    echo "🕵️  Sherlock traque le pseudo : $target"
    echo "📂 Archivage dans : $filename"

    sherlock "$target" --print-found --no-color > "$output"

    if [[ $? -eq 0 ]]; then
        rm -f "${target}.txt" 2>/dev/null
        echo "✅ Sherlock a terminé. Rapport dans exports/"
    else
        echo "⚠️  Sherlock a rencontré un problème."
    fi
}

# SOCIALSCAN
scan_social() {
    local target=$1
    if [[ -z "$target" ]]; then
        echo "Usage: scan_social <email_or_username>"
        return 1
    fi

    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    
    local ident=${target%%@*}
    
    local filename="${timestamp}-${ident}_socialscan.txt"
    local output="$HOME/Documents/OSINT/exports/$filename"

    echo "🔍 Socialscan interroge les plateformes pour : $target"
    echo "📂 Archivage dans : $filename"

    socialscan "$target" > "$output"

    if [[ $? -eq 0 ]]; then
        echo "✅ Socialscan a terminé. Rapport dans exports/"
    else
        echo "⚠️  Socialscan a rencontré une erreur (vérifie s'il est bien installé)."
    fi
}

# INSTAGRAM
archive_insta() {
    local target=$1
    local sock_user="INSTA_USERNAME"
    
    if [[ -z "$target" ]]; then
        echo "Usage: archive_insta <username>"
        return 1
    fi

    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    local export_dir="$HOME/Documents/OSINT/exports/${timestamp}-${target}_instagram"
    mkdir -p "$export_dir"

    echo "📸 Tentative d'archivage de : $target avec le compte $sock_user"
    
    instaloader --login "$sock_user" --dirname-pattern="$export_dir" --no-video-thumbnails "$target"

    if [[ $? -eq 0 ]]; then
        echo "✅ Mission accomplie dans : $export_dir"
    else
        echo "❌ Échec. Instagram a bloqué la requête (403/401). Change de session ou de VPN."
    fi
}

# NEW CASE FORGE
new_case() {
    local case_name=$1
    if [[ -z "$case_name" ]]; then
        echo "Usage: new_case <nom_de_l_affaire>"
        return 1
    fi

    local date=$(date +%Y-%m-%d)
    local full_path="$HOME/Documents/OSINT/Targets/${date}_${case_name}"

    mkdir -p "$full_path"/{reports,evidence,notes,screenshots}

    echo "🏛️  Nouvelle affaire ouverte : ${date}_${case_name}"
    echo "📂 Chemin : $full_path"
    
    cd "$full_path"
    
    touch "notes/investigation_log.md"
}

# PHONEINFOGA
trace_phone() {
    local phone=$1
    if [[ -z "$phone" ]]; then
        echo "Usage: trace_phone +33612345678"
        return 1
    fi

    local timestamp=$(date +"%Y-%m-%d_%Hh%M")
    local clean_phone=$(echo "$phone" | sed 's/+//g')
    local filename="${timestamp}-${clean_phone}_phoneinfoga.txt"
    local output="$HOME/Documents/OSINT/exports/$filename"

    echo "📞 Analyse du numéro : $phone"
    echo "📂 Archivage dans : $filename"

    phoneinfoga scan -n "$phone" > "$output"

    if [[ $? -eq 0 ]]; then
        echo "✅ Analyse terminée. Rapport disponible dans exports/"
        echo "💡 Astuce : Regarde les liens 'Google Dorks' dans le rapport pour fouiller le web."
    else
        echo "⚠️  PhoneInfoga a rencontré une erreur. Vérifie l'installation ou le format (+33...)."
    fi
}
