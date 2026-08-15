# Omarchy Keybind Manager

Gestor TUI de atajos personales para [Omarchy](https://omarchy.org/) y Hyprland. Usa el formato Lua nativo de Omarchy, por lo que los atajos creados también aparecen en `omarchy menu keybindings --print`.

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)

## Qué hace

- Elegí una aplicación instalada o escribí un comando.
- Ingresá el atajo con formato flexible: `win+shift+z`, `SUPER + SHIFT + Z` y `meta-z` se normalizan.
- Detecta atajos existentes de Omarchy antes de guardar.
- Ofrece una alternativa similar o permite sobrescribir el atajo en conflicto.
- Al sobrescribir, genera el `hl.unbind()` necesario antes de crear el `o.bind()`.
- Guarda únicamente tus atajos en `~/.config/omarchy/keybind-manager/bindings.json`.

La UI se abre en la terminal predeterminada de Omarchy y utiliza `gum`, por lo que adopta el tema del sistema.
Detecta `LC_ALL`, `LC_MESSAGES` o `LANG`: actualmente ofrece español para locales `es_*` e inglés para el resto; el inglés es el fallback seguro.

La ventana abre centrada y flotante a `760×560`, identificada por su app-id exclusivo. La regla no fuerza colores, bordes, opacidad ni animaciones: conserva los parámetros del tema Omarchy activo.

## Requisitos

Omarchy 4, Hyprland, `gum`, `jq`, `uwsm-app` y Bash. En una instalación normal de Omarchy ya están presentes.

## Instalación

```bash
git clone https://github.com/TU_USUARIO/omarchy-keybind-manager.git
cd omarchy-keybind-manager
./install.sh
```

El instalador coloca el ejecutable en `~/.local/bin`, crea la entrada **Keybind Manager** en el menú de aplicaciones y añade una única línea de carga a `~/.config/hypr/bindings.lua`. Nunca modifica `/usr/share/omarchy`.

## Uso

Abrí **Keybind Manager** desde el menú de aplicaciones de Omarchy, o ejecutá:

```bash
omarchy-launch-tui --app-id=org.omarchy.keybind-manager omarchy-keybind-manager
```

Las entradas se aplican inmediatamente y se pueden comprobar con:

```bash
omarchy menu keybindings --print
```

## Archivos que administra

| Archivo | Propósito |
| --- | --- |
| `~/.config/omarchy/keybind-manager/bindings.json` | Base de datos de atajos personales. |
| `~/.config/hypr/keybind-manager.lua` | Lua generado y cargado por Hyprland. |
| `~/.config/hypr/keybind-manager-window.lua` | Regla de ventana compacta y centrada. |
| `~/.config/hypr/bindings.lua` | Sólo añade `require("hypr.keybind-manager")`. |

## Desarrollo y verificación

```bash
./tests/test.sh
bash -n bin/omarchy-keybind-manager install.sh uninstall.sh
desktop-file-validate desktop/omarchy-keybind-manager.desktop
```

Después de cambiar la integración con Hyprland, verificá además:

```bash
hyprctl reload
hyprctl configerrors
```

## Actualizaciones para la comunidad

La instalación conserva los atajos del usuario en `~/.config`, por lo que se
puede actualizar sin perderlos. Quien haya clonado el repositorio puede hacerlo
desde su copia local:

```bash
git pull --ff-only
./install.sh
```

Para distribuirlo más ampliamente, la vía recomendada es publicar *releases*
versionadas en GitHub (un `.tar.gz` con este mismo instalador) y mantener un
changelog. Eso permite que la comunidad instale versiones estables, reporte
regresiones por versión y actualice repitiendo la instalación, sin que la app
ejecute descargas o cambios automáticos en la configuración del sistema.

## Desinstalación

```bash
./uninstall.sh
```

Conserva tus atajos guardados. Para eliminarlos también:

```bash
./uninstall.sh --purge
```

## Licencia

[MIT](LICENSE).
