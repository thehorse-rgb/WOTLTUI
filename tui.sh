#!/bin/bash
clear
echo
echo
echo
echo
echo
echo -e "\e[0;97m┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────┐\e[0m"
echo -e "\e[0;97m│        \e[0;94m █████   ███   █████    ███████    ███████████ █████       ███████████ █████  █████ █████\e[0m            \e[0;97m│"
echo -e "\e[0;97m│       \e[0;94m ▒▒███   ▒███  ▒▒███   ███▒▒▒▒▒███ ▒█▒▒▒███▒▒▒█▒▒███       ▒█▒▒▒███▒▒▒█▒▒███  ▒▒███ ▒▒███\e[0m             \e[0;97m│"
echo -e "\e[0;97m│         \e[0;94m▒███   ▒███   ▒███  ███     ▒▒███▒   ▒███  ▒  ▒███       ▒   ▒███  ▒  ▒███   ▒███  ▒███\e[0m             \e[0;97m│"
echo -e "\e[0;97m│        \e[0;94m ▒███   ▒███   ▒███ ▒███      ▒███    ▒███     ▒███           ▒███     ▒███   ▒███  ▒███\e[0m             \e[0;97m│"
echo -e "\e[0;97m│        \e[0;94m ▒▒███  █████  ███  ▒███      ▒███    ▒███     ▒███           ▒███     ▒███   ▒███  ▒███\e[0m             \e[0;97m│"
echo -e "\e[0;97m│         \e[0;94m ▒▒▒█████▒█████▒   ▒▒███     ███     ▒███     ▒███      █    ▒███     ▒███   ▒███  ▒███\e[0m             \e[0;97m│"
echo -e "\e[0;97m│           \e[0;94m ▒▒███ ▒▒███      ▒▒▒███████▒      █████    ███████████    █████    ▒▒████████   █████\e[0m            \e[0;97m│"
echo -e "\e[0;97m│            \e[0;94m ▒▒▒   ▒▒▒         ▒▒▒▒▒▒▒       ▒▒▒▒▒    ▒▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒      ▒▒▒▒▒▒▒▒   ▒▒▒▒▒\e[0m             \e[0;97m│"
echo -e "\e[0;97m└─────────────────────────────────────────────────────────────────────────────────────────────────────────────┘\e[0m"
echo
echo
echo
echo
echo -e "                 \e[0;37m       ╔═══════════════════════════════════════════════════════╗\e[0m"
echo -e "                 \e[0;37m ──=≡  ║ Copyright (c) 2026 thehorse-rgb. All Rights Reserved. ║  ≡=──\e[0m"
echo -e "                 \e[0;37m       ╚═══════════════════════════════════════════════════════╝\e[0m"
echo
echo
echo
echo
echo -e "\e[0;97m───────────────────────────────────────────────────────────────────────────────────────────────────────────────\e[0m"
echo
echo
mein_menu() {
sleep 1
echo -e "\e[0;94m┏┓┏┓┏┳┓┳┏┓┳┓┏┓┳┓\e[0m"
echo -e "\e[0;94m┃┃┃┃ ┃ ┃┃┃┃┃┣ ┃┃\e[0m"
echo -e "\e[0;94m┗┛┣┛ ┻ ┻┗┛┛┗┗┛┛┗\e[0m"
echo -e "1) Wotlk Verzeichnis wählen/suchen"
echo -e "├─2) Wotlk patchen"
echo -e "└───3) Beenden"

read -p ">> " choice

case "$choice" in
    1)
        sleep 1
# Startverzeichnis (optional über Parameter)
START_DIR="${1:-.}"

# Suche nach wow.exe (case-insensitive)
WOW_EXE=$(find "$START_DIR" -type f -iname "wow.exe" 2>/dev/null | head -n 1)

# Falls nicht gefunden → Benutzer fragen
if [ -z "$WOW_EXE" ]; then
    echo "wow.exe wurde nicht automatisch gefunden."

    while true; do
        read -rp "Bitte Pfad zum Ordner mit wow.exe eingeben: " INPUT_DIR

        if [ -f "$INPUT_DIR/wow.exe" ] || [ -f "$INPUT_DIR/WoW.exe" ]; then
            # flexible Prüfung (case-insensitive)
            WOW_EXE=$(find "$INPUT_DIR" -maxdepth 1 -type f -iname "wow.exe" | head -n 1)
            break
        else
            echo "\e[0;31m[FEHLER]\e[0m In diesem Ordner wurde kein wow.exe gefunden. Versuch es nochmal."
        fi
    done
fi

# Verzeichnis bestimmen
wotlkpath=$(dirname "$WOW_EXE")

# Exportieren
export wotlkpath

echo "WoW-Verzeichnis gesetzt auf:"
echo "$wotlkpath"
mein_menu
        ;;
    2)
# Zielpfad muss existieren
if [ -z "$wotlkpath" ]; then
    echo "wotlkpath ist nicht gesetzt!"
    exit 1
fi

TARGET_DIR="$wotlkpath/Data"
mkdir -p "$TARGET_DIR"

REPO="thehorse-rgb/wowpatchesprivateserver"
API_URL="https://api.github.com/repos/$REPO/git/trees/main?recursive=1"

echo "Lade Dateiliste von GitHub..."

curl -s "$API_URL" | \
grep '"path"' | \
grep -i '\.mpq' | \
cut -d '"' -f 4 | \
while read -r path; do

    filename=$(basename "$path")

    RAW_URL="https://raw.githubusercontent.com/$REPO/main/$path"

    echo "Lade: $filename"

    curl -s -L "$RAW_URL" -o "$TARGET_DIR/$filename"

done

echo "Fertig."
mein_menu
        ;;
    3)
        echo -e "\e[0;94m   ┏┓\e[0m"
        echo -e "\e[0;94m    ┫\e[0m"
        echo -e "\e[0;94m   ┗┛\e[0m"  
        sleep 1
        echo -e "\e[0;94m  ┏┓\e[0m"
        echo -e "\e[0;94m  ┏┛\e[0m"
        echo -e "\e[0;94m  ┗━\e[0m"
        sleep 1
        echo -e "\e[0;94m  ┓\e[0m"
        echo -e "\e[0;94m  ┃\e[0m"
        echo -e "\e[0;94m  ┻\e[0m"
        sleep 1
        echo -e "\e[0;94m┏┓\e[0m"
        echo -e "\e[0;94m┃┫\e[0m"
        echo -e "\e[0;94m┗┛\e[0m"
        sleep 0.2
        clear
        exit 0
        ;;
    *)
        echo "\e[0;31m[FEHLER]\e[0m Ungültige Auswahl bitte wählen sie eine der vorgegebenen Zahlen"
        mein_menu
        ;;
esac

}
mein_menu
