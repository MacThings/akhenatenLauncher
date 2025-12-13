#!/bin/bash

SCRIPT_SOURCE="${BASH_SOURCE[0]}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_SOURCE")" >/dev/null 2>&1 && pwd)"

cd "$SCRIPT_DIR"/game

ttf_font=$( defaults read "$HOME/Library/Preferences/de.slsoft.akhenatenLauncher.plist" "gameFontTTF" )

if [[ "$ttf_font" != "" ]]; then
    ./akhenaten --font "$HOME/.config/akhenaten/fonts/$ttf_font" && rm akhenaten-log.txt imgui.ini
else
    ./akhenaten && rm akhenaten-log.txt imgui.ini
fi
