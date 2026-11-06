#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="${HOME}/.config/ghostty"
DOTFILES_DIR="${HOME}/dotfiles/ghostty/config"

CONFIG_FILE="${CONFIG_DIR}/config.ghostty"
LOCAL_CONFIG_FILE="${CONFIG_DIR}/config-local.ghostty"
SHADERS_LINK="${CONFIG_DIR}/shaders"

mkdir -p "${CONFIG_DIR}"

# Link the main Ghostty configuration if nothing exists at the destination.
if [[ ! -e "${CONFIG_FILE}" && ! -L "${CONFIG_FILE}" ]]; then
    ln -s "${DOTFILES_DIR}/config.ghostty" "${CONFIG_FILE}"
    echo "Linked ${CONFIG_FILE}"
else
    echo "Skipping ${CONFIG_FILE}: already exists"
fi

# Copy the local configuration template only if it does not exist.
if [[ ! -e "${LOCAL_CONFIG_FILE}" && ! -L "${LOCAL_CONFIG_FILE}" ]]; then
    cp "${DOTFILES_DIR}/config-local.ghostty" "${LOCAL_CONFIG_FILE}"
    echo "Copied ${LOCAL_CONFIG_FILE}"
else
    echo "Skipping ${LOCAL_CONFIG_FILE}: already exists"
fi

# Link the shaders directory if nothing exists at the destination.
if [[ ! -e "${SHADERS_LINK}" && ! -L "${SHADERS_LINK}" ]]; then
    ln -s "${HOME}/dotfiles/ghostty/shaders" "${SHADERS_LINK}"
    echo "Linked ${SHADERS_LINK}"
else
    echo "Skipping ${SHADERS_LINK}: already exists"
fi

echo "Ghostty config installed."
