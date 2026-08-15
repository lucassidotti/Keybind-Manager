#!/usr/bin/env bash
set -euo pipefail

root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
bin_home="$HOME/.local/bin"
applications_home="$HOME/.local/share/applications"
hypr_bindings="$config_home/hypr/bindings.lua"
generated="$config_home/hypr/keybind-manager.lua"
state="$config_home/omarchy/keybind-manager/bindings.json"
loader='require("hypr.keybind-manager")'

for dependency in jq gum hyprctl omarchy uwsm-app; do
  command -v "$dependency" >/dev/null || { echo "Missing dependency: $dependency" >&2; exit 1; }
done
[[ -f $hypr_bindings ]] || { echo "Omarchy Hyprland configuration not found: $hypr_bindings" >&2; exit 1; }

install -Dm755 "$root/bin/omarchy-keybind-manager" "$bin_home/omarchy-keybind-manager"
install -Dm644 "$root/desktop/omarchy-keybind-manager.desktop" "$applications_home/omarchy-keybind-manager.desktop"
mkdir -p "$(dirname "$state")"
[[ -f $state ]] || printf '[]\n' >"$state"
[[ -f $generated ]] || install -Dm644 "$root/config/keybind-manager.lua" "$generated"

if ! grep -Fqx "$loader" "$hypr_bindings"; then
  printf '\n-- Omarchy Keybind Manager: user-created application shortcuts.\n%s\n' "$loader" >>"$hypr_bindings"
fi

command -v update-desktop-database >/dev/null && update-desktop-database "$applications_home" || true
hyprctl reload
hyprctl configerrors
echo 'Installed: open Keybind Manager from the Omarchy applications menu.'
