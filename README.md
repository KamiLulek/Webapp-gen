# webapp-gen

Generator aplikacji webowych dla Chromium - twórz osobne aplikacje z wybranych stron www.

## Spis treści / Table of Contents
- [Polski](#polski)
- [English](#english)

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

### Cechy
- ✅ Tworzenie aplikacji webowych z dowolnej strony
- ✅ Wybór flag Chromium podczas instalacji
- ✅ Własny katalog danych dla każdej aplikacji
- ✅ Skróty w menu systemowym (pliki .desktop)
- ✅ Obsługa własnych ikon
- ✅ Edycja istniejących aplikacji
- ✅ Usuwanie aplikacji
- ✅ Wsparcie dla języków polski/angielski
- ✅ Działanie w konsoli (bez zenity)

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
/usr/local/bin/webapp-list/<nazwa>/<nazwa>-app

Konfiguracja aplikacji	- Przechowuje URL, flagi i ścieżkę do ikony
/usr/local/bin/webapp-list/<nazwa>/<nazwa>.cfg

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


# English
  - [Description](#description)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Configuration](#configuration)
  - [Where files are stored](#where-files-are-stored)
  - [Chromium flags](#chromium-flags)
  - 
webapp-gen is a bash script that creates separate web applications from selected websites using Chromium in --app mode. Each app runs as a separate process, has its own data directory, and can be launched like a normal application from the system menu.

Features
✅ Create web apps from any website

✅ Select Chromium flags during installation

✅ Dedicated data directory for each app

✅ System menu shortcuts (.desktop files)

✅ Custom icon support

✅ Edit existing apps

✅ Remove apps

✅ Polish/English language support

✅ Console-based (no zenity)

Installation
Download the script:


git clone https://github.com/KamiLulek/webapp-gen.git
cd webapp-gen
Install:


sudo cp webapp-gen /usr/local/bin/
sudo chmod +x /usr/local/bin/webapp-gen

Requirements:

Chromium (or Chromium-based browser)

pkexec (polkit) - for writing to /usr/local/bin/webapp-list/

update-desktop-database (optional, for menu refresh)


# Arch Linux
sudo pacman -S chromium polkit

# Ubuntu/Debian
sudo apt install chromium-browser polkit-utils

# Fedora
sudo dnf install chromium polkit
Usage
After installation, run:


webapp-gen

Main menu appears:

text
=== webapp-gen ===
1. Install new app
2. List installed
3. Edit app
4. Configuration
5. Remove app
6. Exit

Choose option [1-6]:
Install new app
Select option 1

Enter name (no spaces, e.g., gmail, youtube)

Enter URL (e.g., https://mail.google.com/)

Select Chromium flags (type Y or N):

Default enabled: disable translator and background networking

Others optional

Enter path to icon or just filename (script will check in default folder)

List installed apps
Select option 2 - displays all apps with their URLs and flags.

Edit app
Select option 3 - you can change URL, flags, and icon.

Remove app
Select option 5 - choose app from list to remove.

Configuration
On first run, the script will ask for:

Language (Polish/English)

Default icon path - folder where the script looks for icons if you provide only filename

You can change settings anytime by selecting option 4 in menu or editing the file manually:


~/.config/webapp-gen/config.cfg
Example config file:

bash
# webapp-gen config
LANG_CHOICE="en"
DEFAULT_ICON_PATH="/home/lula/Pictures"

Where files are stored
File/Folder	Location	Description
Wrapper	 	               /usr/local/bin/webapp-list/<name>/<name>-app	          Script that launches the app
Config	 	               /usr/local/bin/webapp-list/<name>/<name>.cfg          	Stores URL, flags, and icon path
Menu shortcut 	         ~/.local/share/applications/<name>.desktop	            .desktop file for system menu
Icon	 	                 ~/.local/share/icons/webapp-ico/<name>.*	              Copied app icon
App data	 	             ~/.config/<name>-app/	                                Chromium data directory (profiles, cookies)
Script config	 	         ~/.config/webapp-gen/config.cfg	                      Language and default icon path settings

NOTE: Files in /usr/local/bin/webapp-list/ require root privileges, so the script uses pkexec during install/edit/remove.

Chromium Flags

Available flags during installation:

Flag	Description	Default
--disable-features=Translate,OptimizationGuide	Disables Google Translate and suggestions	✅ Enabled
--disable-background-networking	Disables unnecessary background networking	✅ Enabled
--disable-extensions	Disables all extensions	❌ Disabled
--disable-sync	Disables Google account sync	❌ Disabled
--disable-gpu	Disables GPU hardware acceleration	❌ Disabled
--incognito	Always start in incognito mode	❌ Disabled
--start-maximized	Start window maximized	❌ Disabled


License
MIT License - feel free to use and modify!

Contributing
Pull requests and issues welcome! 🚀
