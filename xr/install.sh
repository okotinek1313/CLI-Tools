#!/bin/bash

CONFIG_DIR="$HOME/.config/xr"
CONFIG_FILE="$CONFIG_DIR/config.conf"
COMMAND="./command.sh"
NEW_PATH="$HOME/.local/bin"

# Check if the config file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Creating Config"
    mkdir -p "$CONFIG_DIR"
    touch "$CONFIG_FILE"
    echo "Config file created at $CONFIG_FILE"
else
    echo "Config file exists: $CONFIG_FILE"
fi

# Check if the directory exists
if [[ ! -d "$NEW_PATH" ]]; then
    echo "Creating $NEW_PATH"
    mkdir -p "$NEW_PATH"
else
    echo "$NEW_PATH already exists."
fi

# Add NEW_PATH to PATH in .bashrc if not already present
if [[ ":$PATH:" != *":$NEW_PATH:"* ]]; then
    echo "Adding $NEW_PATH to PATH"
    echo "export PATH=\"$NEW_PATH:\$PATH\"" >> "$HOME/.bashrc"
fi

# Install command
cp "$COMMAND" "$NEW_PATH/xr"
chmod +x "$NEW_PATH/xr"
