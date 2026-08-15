#!/usr/bin/env bash
set -euo pipefail

root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
source "$root/bin/omarchy-keybind-manager"

assert_eq() {
  [[ $1 == "$2" ]] || { printf 'Expected: %s\nActual:   %s\n' "$2" "$1" >&2; exit 1; }
}

assert_eq "$(normalize_key 'win+ctrl+shift+m')" 'SUPER + CTRL + SHIFT + M'
assert_eq "$(normalize_key 'f12')" 'F12'
assert_eq "$(normalize_key 'super+super+x')" 'SUPER + X'
if normalize_key 'super+alt+' >/dev/null; then echo 'Invalid shortcut accepted' >&2; exit 1; fi

assert_eq "$(env -u LC_ALL -u LC_MESSAGES LANG=en_US.UTF-8 bash -c 'source "$1"; t add' _ "$root/bin/omarchy-keybind-manager")" 'Assign application'
assert_eq "$(env -u LC_ALL -u LC_MESSAGES LANG=es_AR.UTF-8 bash -c 'source "$1"; t add' _ "$root/bin/omarchy-keybind-manager")" 'Asignar aplicación'

printf 'All tests passed.\n'
