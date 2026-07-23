# webapp-gen

Generator aplikacji webowych dla Chromium - twórz osobne aplikacje z dowolnej strony.

<p align="center">
<img src="webapp-gen-preview.png" width="700" alt="webapp-gen preview">
</p>

**[Polski] | [English](README.md)**

## Co to robi

Tworzy izolowane aplikacje webowe używając `chromium --app`. Każda apka ma własny profil, ikonę, wpis w menu i pokazuje się jako osobne drzewo procesów `nazwa-app → chromium` w btop/htop.

- osobny proces - wrapper `~/.local/bin/webapp-list/app-app`
- osobne dane - `~/.config/app-app/` (ciasteczka, storage)
- integracja z pulpitem - `.desktop` + `StartupWMClass`
- flagi per apka + własne `CUSTOM_FLAGS`
- bez roota, bez `pkexec`
- język PL/EN wybierany przy pierwszym uruchomieniu

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
# bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# fish
fish_add_path ~/.local/bin
```

**Wymagania:**
- Chromium lub przeglądarka oparta o Chromium
- `update-desktop-database` (opcjonalnie)

## Użycie

```bash
 =======================-------- 
 ===   webapp-gen 
 ==================== + + v0.9.1 

 1. Instalacja
 2. Lista (Info/Edycja/Usuń)
 3. Ustawienia
 4. Wyjście / Q = Wyjście

 Wybierz opcję [1-4] lub 'q' aby wyjść:
```

### 1. Instalacja
1. `Nazwa (bez spacji)` - tylko `a-zA-Z0-9_-`, np. `youtube`, `claude`
2. `URL` - np. `https://youtube.com`
3. Wybór flag Chromium - pytania Y/N
4. Dodatkowe własne flagi - własne flagi (ENTER = brak)
5. Ikona - nazwa pliku z domyślnego folderu ikon lub pełna ścieżka. Kopiowana do `~/.local/share/icons/webapp-ico/`

Walidacja: pusta nazwa -> błąd, istniejąca apka -> `Błąd: Appka '%s' już istnieje!`

### 2. Lista (Info/Edycja/Usuń)
Nowość w 0.9-alpha - wszystko w jednym miejscu.

```
 =======================-------- 
 ===   Zainstalowane 
 ==================== + + v0.9.1 

 1. google
 2. youtube


 p - powrót 
 q - wyjście 

 Wybierz numer appki (p=powrót, q=wyjście):
```

Po wybraniu:

```
 =======================-------- 
 ===   Szczegóły 
 ==================== + + v0.9.1 

  Nazwa: youtube
  URL: https://youtube.com
  Ikona: /home/user/.local/share/icons/webapp-ico/youtube.png
  Wrapper: /home/user/.local/bin/webapp-list/youtube-app
  Desktop: /home/user/.local/share/applications/youtube.desktop
  Config: /home/user/.config/webapp-gen/apps/youtube.cfg
  Flagi: --disable-features=Translate,OptimizationGuide --disable-background-networking
  Custom: --force-device-scale-factor=1.25

--- Akcje ---

  e - Edytuj
  r - Usuń
  p - Powrót do listy
  q - Wyjście
```

- `e` - Edytuj: zmiana URL (ENTER = zostaw), ponowny wybór flag, edycja custom flag `ENTER=zostaw / n=nowe / c=usuń`, zmiana ikony.
- `r` - Usuń z potwierdzeniem `[y/N]`.
- `p/q` - nawigacja.

### 3. Ustawienia
Zmiana języka `pl/en` i domyślnej ścieżki ikon. Zapis w `~/.config/webapp-gen/config.cfg`.

Przy pierwszym uruchomieniu:

```
 ╔════════════════════════════════════════╗
 ║          webapp-gen - FIRST RUN        ║
 ╚════════════════════════════════════════╝

 Select language / Wybierz język:
  1. Polski
  2. English

 Choose / Wybierz [1-2]: 1

 Wybrano: Polski

 Podaj domyślną ścieżkę dla ikon:
  (ENTER dla domyślnej: /home/USER)
 Ustaw ścieżkę: /home/USER/Obrazy
```

### Skróty CLI

```bash
  Użycie: 
  webapp-gen                  ->  interaktywne menu (1-4) 
  webapp-gen -list            ->  lista + szczegóły e/r/p/q 
  webapp-gen -edit            ->  edytuj appkę 
  webapp-gen -remove          ->  usuń appkę 
  webapp-gen -info name       ->  info o appce po nazwie 
  webapp-gen -name-e name     ->  edytuj appkę po nazwie 
  webapp-gen -name-r name     ->  usuń appkę po nazwie 
  webapp-gen -config          ->  konfiguracja 
  webapp-gen -h               ->  Help menu

  VERSION:                    -> v0.9.9  
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

Przykład `~/.config/webapp-gen/apps/youtube.cfg`:
```ini
NAME="youtube"
URL="https://youtube.com/"
ICON="/home/user/.local/share/icons/webapp-ico/youtube.png"
FLAGS="--disable-features=Translate,OptimizationGuide --disable-background-networking"
CUSTOM_FLAGS="--force-device-scale-factor=1.5"
```

Konfiguracja globalna `~/.config/webapp-gen/config.cfg`:
```ini
# webapp-gen config
LANG_CHOICE="pl"
DEFAULT_ICON_PATH="/home/user/Obrazy"
```

## Flagi Chromium

Wybierane podczas instalacji/edycji:

| Flaga | Opis | Domyślnie |
|---|---|---|
| `--disable-features=Translate,OptimizationGuide` | Wyłącza tłumacz Google | ✅ Y |
| `--disable-background-networking` | Wyłącza ruch w tle | ✅ Y |
| `--disable-extensions` | Wyłącza rozszerzenia | ❌ N |
| `--disable-sync` | Wyłącza synchronizację Google | ❌ N |
| `--disable-gpu` | Wyłącza akcelerację GPU | ❌ N |
| `--incognito` | Tryb incognito | ❌ N |
| `--start-maximized` | Start zmaksymalizowany | ❌ N |

`CUSTOM_FLAGS` edytujesz osobno:
- w menu: `ENTER=zostaw / n=nowe / c=usuń`
- ręcznie w `.cfg`
- przydatne: `--force-device-scale-factor=1.25`, `--ozone-platform-hint=auto`

## Jak to działa - X11 vs Wayland

Wrapper generowany przez `write_app_files()`:

```bash
#!/bin/bash
source "/home/user/.config/webapp-gen/apps/youtube.cfg"
NAME="${NAME:-$NAZWA}" # kompatybilność ze starą zmienną NAZWA
chromium --class="${NAME}" ${FLAGS} ${CUSTOM_FLAGS} --user-data-dir="/home/user/.config/${NAME}-app" --app="${URL}"
```

Dzięki temu w btopie widzisz `youtube-app → chromium` zamiast samego `chromium`.

- **X11:** grupowanie ikon działa przez `StartupWMClass`
- **Wayland:** Wayland używa `app_id`, Chromium ustawia je z `--class`, więc `--class=nazwa` + `StartupWMClass=nazwa` naprawia grupowanie na GNOME/KDE

## Licencja

MIT - rób co chcesz!
