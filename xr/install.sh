#!/bin/bash

CONFIG_DIR="$HOME/.config/xr"
CONFIG_FILE="$CONFIG_DIR/config.conf"
COMMAND="./command.sh"
NEW_PATH="$HOME/.local/bin"

# Detect shell
USER_SHELL="$(basename "$SHELL")"

case "$USER_SHELL" in
    bash)
        RC_FILE="$HOME/.bashrc"
        ;;
    zsh)
        RC_FILE="$HOME/.zshrc"
        ;;
    fish)
        RC_FILE="$HOME/.config/fish/config.fish"
        ;;
    *)
        echo "Unsupported shell: $USER_SHELL"
        echo "Add $NEW_PATH to your PATH manually."
        RC_FILE=""
        ;;
esac

# Create config file if missing
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Creating config..."
    mkdir -p "$CONFIG_DIR"
    touch "$CONFIG_FILE"
fi

# Ensure ~/.local/bin exists
if [[ ! -d "$NEW_PATH" ]]; then
    echo "Creating $NEW_PATH"
    mkdir -p "$NEW_PATH"
fi

# Add to PATH if rc file is known
if [[ -n "$RC_FILE" ]]; then
    if ! grep -q "$NEW_PATH" "$RC_FILE" 2>/dev/null; then
        echo "Adding $NEW_PATH to PATH in $RC_FILE"

        if [[ "$USER_SHELL" == "fish" ]]; then
            echo "set -gx PATH $NEW_PATH \$PATH" >> "$RC_FILE"
        else
            echo "export PATH=\"$NEW_PATH:\$PATH\"" >> "$RC_FILE"
        fi
    else
        echo "$NEW_PATH already in PATH"
    fi
fi

# Install command
cp "$COMMAND" "$NEW_PATH/xr"
chmod +x "$NEW_PATH/xr"

echo "Installed as xr"
