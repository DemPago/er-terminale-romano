#!/usr/bin/env bash
# =============================================================================
#  Er Terminale Romano — install.sh
#  Script di installazione automatica per macOS e Linux
#
#  Uso: chmod +x install.sh && ./install.sh
# =============================================================================

set -euo pipefail

# Cambia directory alla root del repo (anche se lo script è chiamato da altrove)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# --- Colori ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC}  $*"; }
log_success() { echo -e "${GREEN}[ OK ]${NC}  $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC}  $*"; }
log_error()   { echo -e "${RED}[ERR ]${NC}  $*" >&2; }
log_roman()   { echo -e "${BOLD}🤌  $*${NC}"; }

# =============================================================================
print_banner() {
  echo ""
  echo -e "${RED}${BOLD}  ╔══════════════════════════════════════════════╗${NC}"
  echo -e "${RED}${BOLD}  ║      🤌  ER TERMINALE ROMANO  🤌             ║${NC}"
  echo -e "${RED}${BOLD}  ║   Daje — installiamo tutto in un colpo!      ║${NC}"
  echo -e "${RED}${BOLD}  ╚══════════════════════════════════════════════╝${NC}"
  echo ""
}

# =============================================================================
check_os() {
  OS="$(uname -s)"
  case "$OS" in
    Darwin)
      log_info "Sistema operativo rilevato: macOS"
      VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
      CURSOR_SETTINGS="$HOME/Library/Application Support/Cursor/User/settings.json"
      ZED_SETTINGS="$HOME/.config/zed/settings.json"
      NVIM_LUA_DIR="$HOME/.config/nvim/lua"
      ;;
    Linux)
      log_info "Sistema operativo rilevato: Linux"
      VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json"
      CURSOR_SETTINGS="$HOME/.config/Cursor/User/settings.json"
      ZED_SETTINGS="$HOME/.config/zed/settings.json"
      NVIM_LUA_DIR="$HOME/.config/nvim/lua"
      ;;
    *)
      log_error "Sistema operativo non supportato: $OS"
      log_error "Questo script funziona su macOS e Linux."
      exit 1
      ;;
  esac
}

# =============================================================================
check_dependencies() {
  log_roman "Sto a controllà le dipendenze..."
  echo ""

  # --- Ollama (obbligatorio) ---
  if ! command -v ollama &>/dev/null; then
    log_error "Ollama non è installato!"
    log_error "Scaricalo da: https://ollama.ai"
    log_error "Poi riavvia questo script."
    exit 1
  fi
  log_success "Ollama trovato."

  # --- Servizio Ollama in esecuzione ---
  if ! ollama list &>/dev/null; then
    log_warn "Er servizio Ollama non risponde. Provo ad avviarlo..."
    # Tenta avvio automatico su Linux con systemd
    if command -v systemctl &>/dev/null; then
      systemctl --user start ollama 2>/dev/null || true
    fi
    sleep 3
    if ! ollama list &>/dev/null; then
      log_error "Ollama non si avvia automaticamente."
      log_error "Avvialo manualmente in un altro terminale: ollama serve"
      log_error "Poi riavvia questo script."
      exit 1
    fi
  fi
  log_success "Ollama è in esecuzione."

  # --- jq (opzionale, utile per modifiche JSON sicure) ---
  if command -v jq &>/dev/null; then
    log_success "jq trovato (modifiche JSON sicure disponibili)."
    JQ_AVAILABLE=true
  else
    log_warn "jq non trovato (opzionale). Procedendo senza."
    JQ_AVAILABLE=false
  fi

  echo ""
}

# =============================================================================
check_modelfile() {
  if [[ ! -f "./Modelfile" ]]; then
    log_error "Modelfile non trovato nella directory corrente."
    log_error "Assicurati di eseguire questo script dalla root del repository."
    exit 1
  fi
  log_success "Modelfile trovato."
}

# =============================================================================
check_spinners() {
  if [[ ! -f "./spinners.json" ]]; then
    log_warn "spinners.json non trovato — solo er modello AI verrà configurato."
  else
    # Valida che sia JSON valido
    if command -v python3 &>/dev/null; then
      if python3 -c "import json; json.load(open('spinners.json'))" 2>/dev/null; then
        log_success "spinners.json trovato e valido."
      else
        log_warn "spinners.json sembra non essere JSON valido — controlla il file."
      fi
    else
      log_success "spinners.json trovato."
    fi
  fi
}

# =============================================================================
create_ollama_model() {
  log_roman "Sto a creà er modello 'romano' su Ollama..."
  log_info "Prima volta? Ci vorrà qualche minuto per scaricare er modello base (llama3)."
  echo ""

  # Avvisa se il modello esiste già
  if ollama list 2>/dev/null | grep -q "romano"; then
    log_warn "Er modello 'romano' esiste già — lo sovrascrivo con la versione aggiornata."
  fi

  if ollama create romano -f ./Modelfile; then
    echo ""
    log_success "Modello 'romano' creato con successo!"
  else
    echo ""
    log_error "Creazione del modello fallita."
    log_error "Controlla i messaggi sopra e assicurati di avere llama3 disponibile:"
    log_error "  ollama pull llama3"
    exit 1
  fi

  echo ""
}

# =============================================================================
configure_opencode() {
  log_roman "Configuro OpenCode per il progetto corrente..."

  local config_file="./opencode.json"

  # Backup se esiste già una configurazione
  if [[ -f "$config_file" ]]; then
    local backup="${config_file}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$config_file" "$backup"
    log_warn "Trovato opencode.json esistente — backup salvato in: $backup"
  fi

  # Scrivi la configurazione OpenCode
  cat > "$config_file" << 'OPENCODE_CONFIG'
{
  "$schema": "https://opencode.ai/config.json",
  "model": "ollama/romano",
  "instructions": "Rispondi sempre in dialetto romanesco verace come un programmatore senior romano. Vai dritto al punto, usa espressioni tipiche romane ma mantieni sempre la precisione tecnica. Non fa' er coatto: codice pulito e risposte dirette."
}
OPENCODE_CONFIG

  log_success "opencode.json generato nel progetto corrente."
  log_info "OpenCode userà er modello romano in questa directory."
  echo ""
}

# =============================================================================
# Merge sicuro di un file JSON nelle impostazioni di un editor.
# Se jq è disponibile fa un merge profondo; altrimenti stampa le istruzioni manuali.
# Usage: merge_json_settings <source_file> <destination_file> <editor_name>
# =============================================================================
merge_json_settings() {
  local source="$1"
  local dest="$2"
  local editor_name="${3:-editor}"
  local dest_dir
  dest_dir="$(dirname "$dest")"

  mkdir -p "$dest_dir"

  # Destinazione assente → copia diretta
  if [[ ! -f "$dest" ]]; then
    cp "$source" "$dest"
    log_success "Configurazione $editor_name creata: $dest"
    return
  fi

  # Backup del file esistente
  local backup="${dest}.backup.$(date +%Y%m%d_%H%M%S)"
  cp "$dest" "$backup"
  log_warn "Backup salvato: $backup"

  if [[ "${JQ_AVAILABLE:-false}" == "true" ]]; then
    # Merge profondo: le chiavi del source sovrascrivono quelle del dest
    jq -s '.[0] * .[1]' "$dest" "$source" > /tmp/romano-merged-settings.json && \
      mv /tmp/romano-merged-settings.json "$dest"
    log_success "Merge completato per $editor_name."
  else
    log_warn "jq non disponibile — aggiungi manualmente queste chiavi in:"
    log_warn "  $dest"
    echo ""
    grep -v '^\s*//' "$source" | grep -v '^[[:space:]]*$' || cat "$source"
    echo ""
    log_info "Installa jq per il merge automatico: brew install jq  (macOS)"
  fi
}

# =============================================================================
configure_vscode() {
  log_roman "Configuro VS Code..."
  local src="./editors/vscode/settings.json"
  [[ -f "$src" ]] || { log_error "File mancante: $src"; return 1; }
  merge_json_settings "$src" "$VSCODE_SETTINGS" "VS Code"
}

# =============================================================================
configure_cursor() {
  log_roman "Configuro Cursor..."
  local src="./editors/cursor/settings.json"
  [[ -f "$src" ]] || { log_error "File mancante: $src"; return 1; }
  merge_json_settings "$src" "$CURSOR_SETTINGS" "Cursor"
}

# =============================================================================
configure_zed() {
  log_roman "Configuro Zed..."
  local src="./editors/zed/settings.json"
  [[ -f "$src" ]] || { log_error "File mancante: $src"; return 1; }
  merge_json_settings "$src" "$ZED_SETTINGS" "Zed"
  log_info "Assicurati che Ollama sia in esecuzione quando usi Zed: ollama serve"
}

# =============================================================================
configure_neovim() {
  log_roman "Configuro Neovim..."
  local src="./editors/neovim/opencode.lua"
  [[ -f "$src" ]] || { log_error "File mancante: $src"; return 1; }

  local dest="${NVIM_LUA_DIR}/opencode-romano.lua"
  mkdir -p "$NVIM_LUA_DIR"

  if [[ -f "$dest" ]]; then
    cp "$dest" "${dest}.backup.$(date +%Y%m%d_%H%M%S)"
    log_warn "Backup del file Neovim esistente creato."
  fi

  cp "$src" "$dest"
  log_success "File copiato: $dest"
  echo ""
  log_info "Aggiungi questa riga al tuo init.lua:"
  echo -e "    ${GREEN}require('opencode-romano')${NC}"
}

# =============================================================================
configure_jetbrains() {
  log_roman "Configuro JetBrains..."
  local src="./editors/jetbrains/opencode-romano.run.xml"
  [[ -f "$src" ]] || { log_error "File mancante: $src"; return 1; }

  local idea_dir="./.idea/runConfigurations"

  if [[ ! -d "./.idea" ]]; then
    log_warn "Cartella .idea non trovata in questa directory."
    log_warn "Apri prima il progetto con JetBrains, poi riesegui questo step."
    log_info "Oppure copia manualmente:"
    log_info "  mkdir -p .idea/runConfigurations"
    log_info "  cp $src .idea/runConfigurations/"
    return
  fi

  mkdir -p "$idea_dir"
  cp "$src" "$idea_dir/"
  log_success "Run configuration copiata in: $idea_dir/"
  log_info "Riapri er progetto in JetBrains — cercа 'OpenCode Romano' nel menu Run."
}

# =============================================================================
configure_editor() {
  echo ""
  echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  log_roman "Quale editor vuoi configurare?"
  echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo ""
  echo "  1)  VS Code"
  echo "  2)  Cursor"
  echo "  3)  Neovim"
  echo "  4)  Zed"
  echo "  5)  JetBrains  (IntelliJ, PyCharm, WebStorm...)"
  echo "  6)  Tutti"
  echo "  7)  Salta      (configura manualmente — editors/README.md)"
  echo ""
  read -r -p "  Scelta [1-7]: " editor_choice
  echo ""

  case "$editor_choice" in
    1) configure_vscode ;;
    2) configure_cursor ;;
    3) configure_neovim ;;
    4) configure_zed ;;
    5) configure_jetbrains ;;
    6)
      configure_vscode    || log_warn "VS Code saltato."
      configure_cursor    || log_warn "Cursor saltato."
      configure_zed       || log_warn "Zed saltato."
      configure_neovim    || log_warn "Neovim saltato."
      configure_jetbrains || log_warn "JetBrains saltato."
      ;;
    7)
      log_info "Configurazione editor saltata."
      log_info "Istruzioni manuali: editors/README.md"
      ;;
    *)
      log_warn "Scelta non valida — configurazione editor saltata."
      log_info "Istruzioni manuali: editors/README.md"
      ;;
  esac
  echo ""
}

# =============================================================================
verify_model() {
  log_roman "Verifico che er modello sia registrato in Ollama..."

  if ollama list 2>/dev/null | grep -q "romano"; then
    log_success "Modello 'romano' presente e pronto all'uso."
    log_info "Test rapido: ollama run romano"
  else
    log_warn "Modello non trovato in 'ollama list' — potrebbe esserci un ritardo."
    log_warn "Riprova tra qualche secondo: ollama list"
  fi

  echo ""
}

# =============================================================================
print_summary() {
  echo ""
  echo -e "${GREEN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${GREEN}${BOLD}  ✅  TUTTO FATTO — DAJE FORTE!  🤌${NC}"
  echo -e "${GREEN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo ""
  echo "  Ecco cosa hai mo':"
  echo "  • 🤖  Modello Ollama 'romano'    →  ollama run romano"
  echo "  • ⚙️   OpenCode configurato       →  opencode.json nel progetto"
  echo "  • 🌀  Spinner pronti all'uso     →  spinners.json"
  echo "  • 📦  Esempi pronti             →  examples/"
  echo "  • 🖥️   Config editor             →  editors/"
  echo ""
  echo "  Prossimi passi:"
  echo "  1. Testa er modello:  ollama run romano"
  echo "  2. Apri er progetto con OpenCode — parlerà romano automaticamente"
  echo "  3. Usa li spinner nei tuoi script  →  vedi examples/"
  echo "  4. Configurazioni altri editor     →  vedi editors/README.md"
  echo "  5. Contribuisci al repo!           →  vedi CONTRIBUTING.md"
  echo ""
  echo -e "  ${BOLD}Er terminale romano è vivo. Anvedi che roba.${NC} 🤌"
  echo ""
}

# =============================================================================
# MAIN
# =============================================================================
main() {
  print_banner
  check_os
  check_dependencies
  check_modelfile
  check_spinners
  create_ollama_model
  configure_opencode
  configure_editor
  verify_model
  print_summary
}

main "$@"
