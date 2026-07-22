# webapp-gen

Create isolated web apps from any website using Chromium in `--app` mode. Each app has its own profile, icon, `.desktop` entry and shows as a separate process tree `app-name-app → chromium` in btop/htop.

<p align="center">
<img src="webapp-gen-preview.png" width="700" alt="webapp-gen preview">
</p>

**[English] | [Polski](README_pl.md)**

## Features

- **Separate process** - wrapper `~/.local/bin/webapp-list/app-app` keeps all chromium processes under one parent, visible in process managers
- **Separate data** - each app has its own `~/.config/app-app/` profile, cookies, storage
- **Proper desktop integration** - `.desktop` file with `StartupWMClass` for correct icon grouping on X11 and Wayland
- **Custom flags** - choose Chromium flags per app
- **No root needed** - everything lives in `~/.local` and `~/.config`

## Installation

No root, no `pkexec`, no polkit required.

```bash
git clone https://github.com/KamiLulek/webapp-gen
cd webapp-gen
mkdir -p ~/.local/bin/webapp-list
cp webapp-gen ~/.local/bin/
chmod +x ~/.local/bin/webapp-gen
```

Make sure `~/.local/bin` is in your PATH:

```bash
# check
echo $PATH | grep -q "$HOME/.local/bin" && echo "OK" || echo "Add to PATH"

# if not, add (bash)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# fish
fish_add_path ~/.local/bin
```

**Requirements:**
- Chromium or Chromium-based browser (`chromium`, `chromium-browser`, `google-chrome`, `brave`)
- `update-desktop-database` (optional, for menu refresh)

## Usage

```bash
webapp-gen

=== webapp-gen ===
1. Install new app
2. List installed
3. Edit app
4. Configuration
5. Remove app
6. Exit

Choose option [1-6]:
```

Or directly:

```bash
webapp-gen -list
webapp-gen -edit
webapp-gen -remove
webapp-gen -config
```

## Configuration

On first run script asks for:

- Language (pl/en)
- Default icon path - where to look for icons when you provide only filename

You can change it anytime with option 4 in menu or editing:

```
~/.config/webapp-gen/config.cfg
```

Example:

```ini
# webapp-gen config
LANG_CHOICE="en"
DEFAULT_ICON_PATH="/home/lula/Pictures"
```

## Where files are stored

| What | Location | Description |
|---|---|---|
| App wrapper | `~/.local/bin/webapp-list/<name>-app` | Bash script that launches the app |
| App config | `~/.config/webapp-gen/apps/<name>.cfg` | URL, flags, icon path |
| Desktop entry | `~/.local/share/applications/<name>.desktop` | Menu entry |
| Icon | `~/.local/share/icons/webapp-ico/<name>.*` | Copied icon |
| App data | `~/.config/<name>-app/` | Chromium profile, cookies, storage |
| Script config | `~/.config/webapp-gen/config.cfg` | Language and default icon path |

## Chromium Flags

You can select flags during installation:

| Flag | Description | Default |
|---|---|---|
| `--disable-features=Translate,OptimizationGuide` | Disables Google Translate and suggestions | ✅ |
| `--disable-background-networking` | Disables background networking | ✅ |
| `--disable-extensions` | Disables all extensions | ❌ |
| `--disable-sync` | Disables Google account sync | ❌ |
| `--disable-gpu` | Disables GPU acceleration | ❌ |
| `--incognito` | Always start in incognito | ❌ |
| `--start-maximized` | Start window maximized | ❌ |

## Custom flags

You can add your own flags in:

```
~/.config/webapp-gen/apps/<name>.cfg
```

Example:

```ini
NAME="YouTube"
URL="https://youtube.com/"
ICON="/home/lula/.local/share/icons/webapp-ico/youtube.png"
FLAGS="--disable-features=Translate,OptimizationGuide --force-device-scale-factor=1.5 --ozone-platform-hint=auto"
CUSTOM_FLAGS=""
```

Docs:
- https://peter.sh/experiments/chromium-command-line-switches/
- https://chromium.googlesource.com/chromium/src/+/main/docs/linux/debugging.md
- `chrome://flags`

## How it works - X11 vs Wayland

Each app is a bash wrapper:

```bash
#!/bin/bash
source ~/.config/webapp-gen/apps/claude.cfg
chromium --class="${NAZWA}" --ozone-platform-hint=auto ${FLAGS} --user-data-dir="$HOME/.config/${NAZWA}-app" --app="${URL}"
```

- The bash process `claude-app` stays as parent, so in `btop`/`htop` you see `claude-app → chromium` instead of just `chromium`. This makes it easy to identify apps.

- **X11:** Window grouping works out of the box via `StartupWMClass` in `.desktop` file.

- **Wayland:** Wayland uses `app_id` instead of `WM_CLASS`. Chromium sets `app_id` from `--class`, so we set `--class=name` and `StartupWMClass=name`. With `--ozone-platform-hint=auto` icon grouping works correctly on GNOME and KDE Wayland.

## License

MIT License - feel free to use and modify!

## Contributing

Pull requests and issues welcome! 🚀
