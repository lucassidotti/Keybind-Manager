# Omarchy Keybind Manager

A TUI for creating and managing personal application shortcuts in
[Omarchy](https://omarchy.org/) and Hyprland. It writes Omarchy's native Lua
format, so shortcuts created here also appear in
`omarchy menu keybindings --print`.

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)

## Features

- Choose an installed application or enter a custom command.
- Accept flexible shortcut input such as `win+shift+z`, `SUPER + SHIFT + Z`,
  and `meta-z`; all are normalized.
- Detect existing Omarchy shortcuts before saving.
- Offer a similar available shortcut or let you overwrite a conflicting one.
- Generate the required `hl.unbind()` before `o.bind()` when overwriting.
- Store only your personal shortcuts in
  `~/.config/omarchy/keybind-manager/bindings.json`.

The interface opens in Omarchy's default terminal and uses `gum`, so it follows
the active system theme. It supports Spanish for `es_*` locales and English for
all other locales.

The window opens centered at `760×560` with its own app ID. Its rule does not
override theme colors, borders, opacity, or animations.

## Requirements

Omarchy 4, Hyprland, Bash, `gum`, `jq`, `uwsm-app`, and `hyprctl`. These are
normally present in a standard Omarchy installation.

## Installation

```bash
git clone https://github.com/lucassidotti/Keybind-Manager.git
cd Keybind-Manager
./install.sh
```

The installer places the executable in `~/.local/bin`, adds **Keybind Manager**
to the applications menu, and adds one loader line to
`~/.config/hypr/bindings.lua`. It never modifies `/usr/share/omarchy`.

## Usage

Open **Keybind Manager** from the Omarchy applications menu, or run:

```bash
omarchy-launch-tui --app-id=org.omarchy.keybind-manager omarchy-keybind-manager
```

Changes apply immediately. To inspect all active shortcuts, run:

```bash
omarchy menu keybindings --print
```

## Managed files

| File | Purpose |
| --- | --- |
| `~/.config/omarchy/keybind-manager/bindings.json` | Personal shortcut database. |
| `~/.config/hypr/keybind-manager.lua` | Generated Lua loaded by Hyprland. |
| `~/.config/hypr/keybind-manager-window.lua` | Centered, compact window rule. |
| `~/.config/hypr/bindings.lua` | Receives only `require("hypr.keybind-manager")`. |

## Updating

Your shortcuts are kept in `~/.config`, so updating does not remove them. From
your local clone, run:

```bash
git pull --ff-only
./install.sh
```

After an update, close and reopen Keybind Manager. Publishing versioned GitHub
releases with a changelog is the recommended distribution path for the
community: users can choose stable versions and report regressions accurately,
without the app silently downloading or changing their system configuration.

## Development and verification

```bash
./tests/test.sh
bash -n bin/omarchy-keybind-manager install.sh uninstall.sh
desktop-file-validate desktop/omarchy-keybind-manager.desktop
```

After changing the Hyprland integration, also run:

```bash
hyprctl reload
hyprctl configerrors
```

## Uninstalling

```bash
./uninstall.sh
```

Saved shortcuts are kept. To remove them as well:

```bash
./uninstall.sh --purge
```

## License

[MIT](LICENSE).
