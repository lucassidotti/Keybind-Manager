#!/usr/bin/env bash
set -euo pipefail

purge=false
[[ ${1:-} == '--purge' ]] && purge=true
[[ -z ${1:-} || ${1:-} == '--purge' ]] || { echo 'Usage: ./uninstall.sh [--purge]' >&2; exit 2; }

config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
hypr_bindings="$config_home/hypr/bindings.lua"
loader='require("hypr.keybind-manager")'

rm -f "$HOME/.local/bin/omarchy-keybind-manager" "$HOME/.local/share/applications/omarchy-keybind-manager.desktop"
[[ -f $hypr_bindings ]] && sed -i "\\|^${loader}$|d" "$hypr_bindings"
rm -f "$config_home/hypr/keybind-manager.lua"
if $purge; then rm -rf "$config_home/omarchy/keybind-manager"; fi
command -v update-desktop-database >/dev/null && update-desktop-database "$HOME/.local/share/applications" || true
hyprctl reload 2>/dev/null || true
echo 'Uninstalled. Your saved shortcuts were kept.'
