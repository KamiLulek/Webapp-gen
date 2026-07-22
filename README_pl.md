# webapp-gen

Generator aplikacji webowych dla Chromium - twórz osobne aplikacje z dowolnej strony.

<p align="center">
<img src="webapp-gen-preview.png" width="700" alt="webapp-gen preview">
</p>

**[Polski] | [English](README.md)**

## Co to robi

Tworzy izolowane aplikacje webowe używając `chromium --app`. Każda apka ma własny profil, ikonę, wpis w menu i pokazuje się jako osobne drzewo procesów `nazwa-app → chromium` w btop/htop.

## Instalacja

Bez roota, bez `pkexec`.

```bash
git clone https://github.com/KamiLulek/webapp-gen
cd webapp-gen
mkdir -p ~/.local/bin/webapp-list
cp webapp-gen ~/.local/bin/
chmod +x ~/.local/bin/webapp-gen
```

Upewnij się że `~/.local/bin` jest w PATH:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Wymagania:**
- Chromium lub przeglądarka oparta o Chromium
- `update-desktop-database` (opcjonalnie)

### Migracja ze starej wersji

```bash
sudo rm -rf /usr/local/bin/webapp-list /usr/local/bin/*-app
```

## Użycie

```bash
webapp-gen

=== webapp-gen ===
1. Instaluj nową appkę
2. Lista zainstalowanych
3. Edytuj appkę
4. Konfiguracja
5. Usuń appkę
6. Wyjście
```

## Gdzie są pliki

| Co | Gdzie |
|---|---|
| Wrapper | `~/.local/bin/webapp-list/<nazwa>-app` |
| Konfiguracja apki | `~/.config/webapp-gen/apps/<nazwa>.cfg` |
| Skrót w menu | `~/.local/share/applications/<nazwa>.desktop` |
| Ikona | `~/.local/share/icons/webapp-ico/<nazwa>.*` |
| Dane apki | `~/.config/<nazwa>-app/` |
| Konfiguracja skryptu | `~/.config/webapp-gen/config.cfg` |

## Flagi Chromium

| Flaga | Opis | Domyślnie |
|---|---|---|
| `--disable-features=Translate,OptimizationGuide` | Wyłącza tłumacz Google | ✅ |
| `--disable-background-networking` | Wyłącza ruch w tle | ✅ |
| `--disable-extensions` | Wyłącza rozszerzenia | ❌ |
| `--disable-sync` | Wyłącza synchronizację Google | ❌ |
| `--disable-gpu` | Wyłącza akcelerację GPU | ❌ |
| `--incognito` | Tryb incognito | ❌ |
| `--start-maximized` | Start zmaksymalizowany | ❌ |

Własne flagi możesz dodać w `~/.config/webapp-gen/apps/<nazwa>.cfg`

## Jak to działa - X11 vs Wayland

Wrapper bash `nazwa-app` odpala:

```bash
chromium --class="${NAZWA}" --ozone-platform-hint=auto --user-data-dir="$HOME/.config/${NAZWA}-app" --app="${URL}"
```

Dzięki temu w btopie widzisz `claude-app → chromium` zamiast samego `chromium`.

- **X11:** grupowanie ikon działa przez `StartupWMClass`
- **Wayland:** Wayland używa `app_id`, Chromium ustawia je z `--class`, więc `--class=nazwa` + `StartupWMClass=nazwa` + `--ozone-platform-hint=auto` naprawia grupowanie na GNOME/KDE

## Licencja

MIT - rób co chcesz!
