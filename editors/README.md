# 🤌 Configurazioni Editor — Er Terminale Romano

Qui trovi i file di impostazioni pronti per i principali editor/IDE.
Ogni sottocartella contiene il file da applicare e le istruzioni specifiche.

---

## Come funziona

Il principio generale è semplice:

1. **A livello di progetto** → usa `opencode.json` nella root (generato da `install.sh`)
2. **A livello globale** → applica le impostazioni specifiche del tuo editor (file in questa cartella)

Le impostazioni globali hanno effetto su tutti i tuoi progetti.
Quelle di progetto (`opencode.json`) hanno la precedenza.

---

## Editor Supportati

| Editor | File di configurazione | Supporto nativo Ollama |
|--------|----------------------|----------------------|
| [VS Code](#-vs-code) | `vscode/settings.json` | Tramite OpenCode CLI |
| [Cursor](#-cursor) | `cursor/settings.json` | Tramite OpenCode CLI |
| [Neovim](#-neovim) | `neovim/opencode.lua` | Tramite OpenCode CLI |
| [Zed](#-zed) | `zed/settings.json` | ✅ Nativo |
| [JetBrains](#-jetbrains) | `jetbrains/opencode-romano.run.xml` | Tramite OpenCode CLI |

> **Installazione automatica**: lancia `./install.sh` e seleziona il tuo editor
> dal menu interattivo — copierà tutto al posto giusto.

---

## 🟦 VS Code

**File**: `editors/vscode/settings.json`

**Dove copiarlo:**
```
macOS  →  ~/Library/Application Support/Code/User/settings.json
Linux  →  ~/.config/Code/User/settings.json
```

**Come applicarlo (senza sovrascrivere il file esistente):**
```bash
# Con jq — merge sicuro
jq -s '.[0] * .[1]' \
  "~/Library/Application Support/Code/User/settings.json" \
  editors/vscode/settings.json \
  > /tmp/vscode-merged.json && \
  mv /tmp/vscode-merged.json \
  "~/Library/Application Support/Code/User/settings.json"
```

Oppure manualmente: apri VS Code → `Cmd+Shift+P` → `Open User Settings (JSON)`
e incolla le chiavi dal file.

**Cosa fa:**
- Imposta `opencode.model` su `ollama/romano`
- Associa `Modelfile` come plaintext con syntax highlight
- Configura il terminale integrato per bash/zsh

---

## 🟫 Cursor

**File**: `editors/cursor/settings.json`

**Dove copiarlo:**
```
macOS  →  ~/Library/Application Support/Cursor/User/settings.json
Linux  →  ~/.config/Cursor/User/settings.json
```

**Come applicarlo:**
Apri Cursor → `Cmd+Shift+P` → `Open User Settings (JSON)` → incolla le chiavi.

**Cosa fa:**
- Stesse impostazioni di VS Code per OpenCode
- Lascia attivo l'AI nativo di Cursor (puoi disabilitarlo opzionalmente)
- Configura il terminale integrato

---

## 🟢 Neovim

**File**: `editors/neovim/opencode.lua`

**Dove copiarlo / come usarlo:**
```bash
# Opzione 1: aggiungi alla fine del tuo init.lua
cat editors/neovim/opencode.lua >> ~/.config/nvim/init.lua

# Opzione 2: crea un file dedicato (consigliato)
cp editors/neovim/opencode.lua ~/.config/nvim/lua/opencode-romano.lua
# poi in init.lua aggiungi: require('opencode-romano')
```

**Keybinding aggiunti:**
| Tasto | Azione |
|-------|--------|
| `<leader>or` | Apre OpenCode romano in split verticale |
| `<leader>oR` | Apre OpenCode romano in split orizzontale |
| `:RomanoSetup` | Crea `opencode.json` nel progetto corrente |

---

## 🟡 Zed

**File**: `editors/zed/settings.json`

Zed supporta Ollama **nativamente** — è l'integrazione più semplice.

**Dove copiarlo:**
```
macOS + Linux  →  ~/.config/zed/settings.json
```

**Come applicarlo:**
```bash
# Merge sicuro con jq
jq -s '.[0] * .[1]' ~/.config/zed/settings.json editors/zed/settings.json \
  > /tmp/zed-merged.json && mv /tmp/zed-merged.json ~/.config/zed/settings.json

# Se ~/.config/zed/settings.json non esiste ancora:
cp editors/zed/settings.json ~/.config/zed/settings.json
```

**Cosa fa:**
- Configura l'assistente AI integrato di Zed per usare Ollama
- Imposta `romano` come modello di default
- Ollama deve essere in esecuzione: `ollama serve`

---

## 🟠 JetBrains

**File**: `editors/jetbrains/opencode-romano.run.xml`

Valido per: IntelliJ IDEA, PyCharm, WebStorm, GoLand, Rider, ecc.

**Dove copiarlo:**
```
<root-del-progetto>/.idea/runConfigurations/opencode-romano.run.xml
```

**Come usarlo:**
1. Copia il file nella cartella `.idea/runConfigurations/` del tuo progetto
2. Riapri il progetto in JetBrains
3. Troverai la configurazione "OpenCode Romano" nel menu Run
4. Clicca ▶ per avviare OpenCode nel terminale integrato

**Alternatively (senza il file XML):**
`Tools` → `External Tools` → `+` → aggiungi:
- Program: `opencode`
- Arguments: `--model ollama/romano`
- Working directory: `$ProjectFileDir$`

---

## Aggiungere un nuovo editor

Vuoi aggiungere il supporto per un altro editor (Sublime Text, Emacs, Helix...)?

1. Crea la cartella `editors/<nome-editor>/`
2. Aggiungi il file di configurazione
3. Aggiorna questo README con le istruzioni
4. Apri una Pull Request!

Leggi [CONTRIBUTING.md](../CONTRIBUTING.md) per il workflow completo.
