#!/bin/bash


CONFIG_FILE="$HOME/.config/xr/config.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Config file does not exist!"
    exit 1
fi

# $1 is the option you want to run, e.g., --vim
OPTION="$1"

while IFS='|' read -r cmd shortcut; do
    # skip empty lines or comments
    [[ -z "$cmd" || "$cmd" =~ ^# ]] && continue

    if [[ "$shortcut" == "$OPTION" ]]; then
        echo "Running: $cmd"
        eval "$cmd"
        exit 0
    fi
done < "$CONFIG_FILE"

echo "Option not found: $OPTION"
exit 1
