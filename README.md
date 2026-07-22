# webapp-gen

Web app generator for Chromium - create apps from a selected website.

- [Polski](#polski)
- [English](#english)


---<p align="center">
![alt text](https://github.com/KamiLulek/Webapp-gen/blob/main/webapp-gen-preview.png?raw=true)</p>
---

# Polski
  - [Opis](#opis)
  - [Instalacja](#instalacja)
  - [Użycie](#użycie)
  - [Konfiguracja](#konfiguracja)
  - [Gdzie zapisywane są pliki](#pliki)
  - [Flagi Chromium](#flagi-chromium)
    
## Opis

**webapp-gen** to skrypt bashowy, który tworzy osobne aplikacje webowe z wybranych stron przy użyciu Chromium w trybie `--app`. Każda aplikacja działa jako osobny proces, ma własny katalog danych i może być uruchamiana jak normalna aplikacja z menu systemowego.

## Instalacja

# Pobierz skrypt:
```
git clone https://github.com/KamiLulek/webapp-gen
cd webapp-gen
```
# Instalacja:
```
sudo cp webapp-gen /usr/local/bin/
sudo chmod +x /usr/local/bin/webapp-gen
```
# Wymagania:

- Chromium                   (lub przeglądarka oparta o Chromium)
- pkexec                     (polkit) - do zapisu w /usr/local/bin/webapp-list/
- update-desktop-database    (opcjonalnie, dla odświeżenia menu)

# Arch Linux
```
sudo pacman -S chromium polkit
```
# Ubuntu/Debian
```
sudo apt install chromium-browser polkit-utils
```
# Fedora
```
sudo dnf install chromium polkit
```

## Użycie
```
webapp-gen

=== webapp-gen ===
1. Instaluj nową appkę
2. Lista zainstalowanych
3. Edytuj appkę
4. Konfiguracja
5. Usuń appkę
6. Wyjście

Wybierz opcję [1-6]:
```

## Konfiguracja

Przy pierwszym uruchomieniu skrypt zapyta o:

Język (polski/angielski)

Domyślną ścieżkę do ikon - folder, w którym skrypt będzie szukał ikon jeśli podasz tylko nazwę pliku

Możesz zmienić ustawienia w każdej chwili wybierając opcję 4 w menu lub edytując ręcznie plik:
```
~/.config/webapp-gen/config.cfg
```
Przykładowy plik config:

# webapp-gen config
```
LANG_CHOICE="pl"
DEFAULT_ICON_PATH="/home/lula/Obrazy"
```
## Pliki

Plik/Folder	Lokalizacja	Opis
```
Wrapper aplikacji   =   Skrypt uruchamiający aplikację
/usr/local/bin/webapp-list/<nazwa>-app

Konfiguracja aplikacji	- Przechowuje URL, flagi i ścieżkę do ikony
~/.config/webapp-gen/apps/<nazwa>.cfg

Skrót w menu   =   Plik .desktop dla menu systemowego
~/.local/share/applications/<nazwa>.desktop

Ikona   =   Skopiowana ikona aplikacji
~/.local/share/icons/webapp-ico/<nazwa>.*

Dane aplikacji   =   Katalog danych Chromium (profile, cookies)
~/.config/<nazwa>-app/

Konfiguracja skryptu   =   Ustawienia języka i domyślnej ścieżki
~/.config/webapp-gen/config.cfg
```
UWAGA: Pliki w /usr/local/bin/webapp-list/ wymagają uprawnień roota, dlatego skrypt używa pkexec przy instalacji/edycji/usuwaniu.

## Flagi Chromium
Dostępne flagi do wyboru podczas instalacji:

Flaga	Opis	Domyślnie
```
--disable-features=Translate,OptimizationGuide
                                   ✅ Wyłącza tłumacz Google i podpowiedzi
--disable-background-networking
                                   ✅ Wyłącza zbędny ruch sieciowy w tle
--disable-extensions
                                   ❌ Wyłącza wszystkie rozszerzenia	        
--disable-sync
                                   ❌ Wyłącza synchronizację z kontem Google
--disable-gpu
                                   ❌ Wyłącza akcelerację sprzętową GPU
--incognito
                                   ❌ Tryb incognito za każdym razem
--start-maximized
                                   ❌ Startuje okno zmaksymalizowane
```

## Wlasne flagi

mozna dodac wlasne flagi dodatkowo do cfg:
```
~/.config/webapp-gen/apps/<nazwa>.cfg
```

informacje o nich mozna znalesc tu:
```
https://peter.sh/experiments/chromium-command-line-switches/

https://chromium.googlesource.com/chromium/src/+/main/docs/linux/debugging.md

chrome://flags
```


# English
  - [Description](#description)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Configuration](#configuration)
  - [Where files are stored](#Files)
  - [Chromium flags](#chromium-flags)
    
webapp-gen is a bash script that creates separate web applications from selected websites using Chromium in --app mode. Each app runs as a separate process, has its own data directory, and can be launched like a normal application from the system menu.

Download the script:
```
git clone https://github.com/KamiLulek/webapp-gen.git
cd webapp-gen
```
# Installation
```
sudo cp webapp-gen /usr/local/bin/
sudo chmod +x /usr/local/bin/webapp-gen
```
Requirements:

Chromium (or Chromium-based browser)
pkexec (polkit) - for writing to /usr/local/bin/webapp-list/
update-desktop-database (optional, for menu refresh)

# Arch Linux
```
sudo pacman -S chromium polkit
```
# Ubuntu/Debian
```
sudo apt install chromium-browser polkit-utils
```
# Fedora
```
sudo dnf install chromium polkit
```
# Usage
```
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

# Configuration
On first run, the script will ask for:

Language (Polish/English)

Default icon path - folder where the script looks for icons if you provide only filename
You can change settings anytime by selecting option 4 in menu or editing the file manually:
```
~/.config/webapp-gen/config.cfg
```
Example config file:

# webapp-gen config
```
LANG_CHOICE="en"
DEFAULT_ICON_PATH="/home/lula/Pictures"
```
## Files

File/Folder	Location	Description
```
Wrapper   =   Script that launches the app
/usr/local/bin/webapp-list/<name>-app

Config   =   Stores URL, flags, and icon path
~/.config/webapp-gen/apps/<name>.cfg

Menu shortcut   =   .desktop file for system menu
~/.local/share/applications/<name>.desktop

Icon   =   Copied app icon
~/.local/share/icons/webapp-ico/<name>.*

App data   =   Chromium data directory (profiles, cookies)
~/.config/<name>-app/

Script config   =   Language and default icon path settings
~/.config/webapp-gen/config.cfg
```
NOTE: Files in /usr/local/bin/webapp-list/ require root privileges, so the script uses pkexec during install/edit/remove.

## Chromium Flags

Available flags during installation:

Flag	Description	Default
```
--disable-features=Translate,OptimizationGuide
                                   ✅ Disables Google Translate and suggestions
--disable-background-networking
                                   ✅ Disables unnecessary background networking
--disable-extensions
                                   ❌ Disables all extensions
--disable-sync
                                   ❌ Disables Google account sync
--disable-gpu
                                   ❌ Disables GPU hardware acceleration
--incognito
                                   ❌ Always start in incognito mode
--start-maximized
                                   ❌ Start window maximizedd
```

# Custom flags

You can also add your own flags to the cfg:
```
~/.config/webapp-gen/apps/<name>.cfg
```

information about them can be found here:
```
https://peter.sh/experiments/chromium-command-line-switches/

https://chromium.googlesource.com/chromium/src/+/main/docs/linux/debugging.md

chrome://flags
```


License
MIT License - feel free to use and modify!

Contributing
Pull requests and issues welcome! 🚀
