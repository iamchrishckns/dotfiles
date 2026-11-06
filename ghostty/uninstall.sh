#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="${HOME}/.config/ghostty"
DOTFILES_DIR="${HOME}/dotfiles/ghostty/config"

CONFIG_FILE="${CONFIG_DIR}/config.ghostty"
LOCAL_CONFIG_FILE="${CONFIG_DIR}/config-local.ghostty"
SHADERS_LINK="${CONFIG_DIR}/shaders"

remove_managed_symlink() {
    local link_path="$1"
    local expected_target="$2"

    if [[ -L "${link_path}" ]]; then
        local actual_target
        actual_target="$(readlink "${link_path}")"

        if [[ "${actual_target}" == "${expected_target}" ]]; then
            rm "${link_path}"
            echo "Removed ${link_path}"
        else
            echo "Skipping ${link_path}: points somewhere else"
        fi
    elif [[ -e "${link_path}" ]]; then
        echo "Skipping ${link_path}: not a symlink"
    else
        echo "Skipping ${link_path}: does not exist"
    fi
}

remove_managed_symlink "${CONFIG_FILE}" "${DOTFILES_DIR}/config.ghostty"
remove_managed_symlink "${SHADERS_LINK}" "${HOME}/dotfiles/ghostty/shaders"

# The local config is user-specific and may have been modified, so do not
# remove it automatically.
if [[ -e "${LOCAL_CONFIG_FILE}" || -L "${LOCAL_CONFIG_FILE}" ]]; then
    echo "Preserved ${LOCAL_CONFIG_FILE}"
    echo "Remove it manually if you no longer need it."
fi

# Remove the directory only when it is empty.
if [[ -d "${CONFIG_DIR}" ]] && [[ -z "$(find "${CONFIG_DIR}" -mindepth 1 -print -quit)" ]]; then
    rmdir "${CONFIG_DIR}"
    echo "Removed empty ${CONFIG_DIR}"
fi

echo "Ghostty config uninstalled."
