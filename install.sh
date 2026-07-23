#!/bin/bash
# install.sh — installer / updater dla webapp-gen
# Użycie:
#   curl -fsSL https://raw.githubusercontent.com/KamiLulek/Webapp-gen/main/install.sh | bash
# albo lokalnie po sklonowaniu repo:
#   ./install.sh
set -e

REPO_OWNER="KamiLulek"
REPO_NAME="Webapp-gen"
REPO_BRANCH="main"
RAW_URL="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/${REPO_BRANCH}/webapp-gen"

BIN_DIR="${HOME}/.local/bin"
WRAPPER_DIR="${BIN_DIR}/webapp-list"
TARGET="${BIN_DIR}/webapp-gen"

# ----------------
#  Pomocnicze
# ----------------
err()  { echo " [ERROR] $*" >&2; }
info() { echo " $*"; }

get_ver() {
    # $1 = ścieżka do pliku
    grep -m1 -E '^[[:space:]]*VER=' "$1" 2>/dev/null | sed -E 's/^[[:space:]]*VER="?([^"]*)"?.*/\1/'
}

version_gt() {
    # 0 (true) jeśli $1 > $2
    [[ -z "$1" || -z "$2" ]] && return 1
    [[ "$1" == "$2" ]] && return 1
    [[ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | tail -n1)" == "$1" ]]
}

# ----------------
#  Sprawdzenie zależności
# ----------------
if command -v curl &>/dev/null; then
    DOWNLOAD() { curl -fsSL --max-time 20 "$1" -o "$2"; }
elif command -v wget &>/dev/null; then
    DOWNLOAD() { wget -q --timeout=20 -O "$2" "$1"; }
else
    err "Potrzebny jest 'curl' albo 'wget' żeby to zainstalować."
    exit 1
fi

# ----------------
#  Pobranie skryptu do tmp
# ----------------
TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

info "Pobieram webapp-gen (${REPO_BRANCH})..."
if ! DOWNLOAD "$RAW_URL" "$TMP_FILE"; then
    err "Nie udało się pobrać pliku z: $RAW_URL"
    exit 1
fi

if [[ ! -s "$TMP_FILE" ]] || ! head -n1 "$TMP_FILE" | grep -q '^#!/bin/bash'; then
    err "Pobrany plik wygląda na uszkodzony/niepoprawny."
    exit 1
fi

REMOTE_VER="$(get_ver "$TMP_FILE")"
if [[ -z "$REMOTE_VER" ]]; then
    err "Nie udało się odczytać numeru wersji z pobranego pliku."
    exit 1
fi

# ----------------
#  Instalacja / aktualizacja
# ----------------
mkdir -p "$BIN_DIR" "$WRAPPER_DIR"

if [[ -f "$TARGET" ]]; then
    LOCAL_VER="$(get_ver "$TARGET")"
    if [[ -n "$LOCAL_VER" ]] && ! version_gt "$REMOTE_VER" "$LOCAL_VER"; then
        info "Masz już najnowszą wersję (${LOCAL_VER}). Nic do zrobienia."
        exit 0
    fi
    info "Aktualizuję: ${LOCAL_VER:-?} -> ${REMOTE_VER}"
else
    info "Instaluję webapp-gen ${REMOTE_VER}"
fi

install -m 755 "$TMP_FILE" "$TARGET"
info "Zainstalowano w: $TARGET"

# ----------------
#  PATH w .bashrc / .zshrc (idempotentnie)
# ----------------
PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'
add_path_line() {
    local rc="$1"
    [[ -f "$rc" ]] || touch "$rc"
    if ! grep -qF "$PATH_LINE" "$rc" 2>/dev/null; then
        echo "$PATH_LINE" >> "$rc"
        info "Dodano PATH do: $rc"
    fi
}

case "$SHELL" in
    */zsh)  add_path_line "${HOME}/.zshrc" ;;
    */bash) add_path_line "${HOME}/.bashrc" ;;
    *)
        # nie wiemy jaki shell -> dopisz do obu, jeśli istnieją, bo nie zaszkodzi
        [[ -f "${HOME}/.bashrc" ]] && add_path_line "${HOME}/.bashrc"
        [[ -f "${HOME}/.zshrc" ]]  && add_path_line "${HOME}/.zshrc"
        ;;
esac

echo ""
info "Gotowe. Jeśli 'webapp-gen' nie jest jeszcze widoczne, zrestartuj terminal albo:"
info "  source ~/.bashrc   (lub ~/.zshrc)"
