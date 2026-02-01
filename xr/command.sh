#!/bin/bash

CONFIG_FILE="$HOME/.config/xr/config.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Config file does not exist!"
    exit 1
fi

OPTION="$1"

if [[ -z "$OPTION" ]]; then
    echo "Usage: xr <option>"
    exit 1
fi

while IFS='|' read -r cmd shortcut; do
    [[ -z "$cmd" || "$cmd" =~ ^# ]] && continue

    if [[ "$shortcut" == "$OPTION" ]]; then
        echo "Running: $cmd"
        # Run the command in a proper interactive shell
        bash -i -c "$cmd"
        exit 0
    fi
done < "$CONFIG_FILE"

echo "Option not found: $OPTION"
exit 1
