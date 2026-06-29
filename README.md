<div align="center">

# 🤌 Er Terminale Romano

**_"Ahò, nun solo er caffè — mo' pure er terminale te parla romano!"_**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](./CONTRIBUTING.md)
[![Romanesco](https://img.shields.io/badge/dialetto-romanesco_verace-CC0000.svg)]()
[![Made with love in Roma](https://img.shields.io/badge/Made%20with%20%E2%9D%A4%EF%B8%8F%20in-Roma-CC0000.svg)]()

_Un toolkit open-source che fa parlare il tuo terminale e il tuo AI come un vero Romano de Trastevere._

[Installazione](#-installazione-in-un-colpo-solo) · [Spinner Guide](#-istruzioni-per-lo-spinner-in-romano) · [AI Romano](#-usare-er-modello-romano-con-opencode) · [Contributing](#-contribuisci)

</div>

---

## 🏛️ Che stamo a fa'? _(What's this about?)_

**Er Terminale Romano** è un toolkit open-source che trasforma l'esperienza di sviluppo in qualcosa de più... _autentico_.

| Componente | Cosa fa |
|------------|---------|
| 🌀 **`spinners.json`** | Frasi di caricamento in Romanesco: _"Sto a fatica', spetta n'attimo..."_ |
| 🤖 **`Modelfile`** | Configura un LLM locale (Ollama) che risponde come un senior dev romano |
| 🚀 **`install.sh`** | Script automatico che configura tutto in un colpo |
| 📖 **`examples/`** | Esempi pronti per Node.js (`ora`) e Python (`halo`) |

---

## 🎭 La Filosofia

> _"Er dialetto nun è 'na cosa de bassa cultura — è identità, è calore, è precisione emotiva."_

Quante volte hai letto "_Loading..._", "_Done._", "_Error._" senza sentirci niente?

Con **Er Terminale Romano**, ogni stato del tuo terminale diventa una frase vera, vissuta, de Roma.
E il tuo AI smette di essere un robot freddo e diventa un collega romano che ti spiega le cose
dritto al punto — con quella simpatica arroganza bonaria romana che tutti conoscono.

---

## 📋 Prerequisiti

| Tool | Versione min. | Link | Serve per |
|------|--------------|------|-----------|
| [Ollama](https://ollama.ai) | >= 0.1.0 | https://ollama.ai | Girare i modelli LLM in locale |
| [OpenCode](https://opencode.ai) | qualsiasi | https://opencode.ai | Assistente AI in CLI / VS Code |
| Node.js _(opzionale)_ | >= 18 | https://nodejs.org | Spinner in JavaScript |
| Python _(opzionale)_ | >= 3.8 | https://python.org | Spinner in Python |

> **Nota:** Hai bisogno di almeno un modello Ollama scaricato (es. `llama3`).
> Se non ce l'hai: `ollama pull llama3`

---

## 📦 Usarlo nel tuo Progetto

```bash
npm install er-terminale-romano
```

```javascript
import { pick, romanesco, romanzo_criminale } from 'er-terminale-romano';
import ora from 'ora';

// Tema standard — Trastevere quotidiano
const spinner = ora(pick(romanesco.loading)).start();
await laVostraOperazione();
spinner.succeed(pick(romanesco.success));

// Tema Romanzo Criminale
const spinner2 = ora(pick(romanzo_criminale.loading)).start();
spinner2.fail(pick(romanzo_criminale.fail));
```

---

## 🚀 Installare il Toolkit Completo (Ollama + OpenCode)

```bash
git clone https://github.com/TUO_USERNAME/er-terminale-romano.git
cd er-terminale-romano
chmod +x install.sh
./install.sh
```

**Lo script fa in automatico:**

1. ✅ Controlla che Ollama sia installato e in esecuzione
2. 🏗️ Crea il modello `romano` con `ollama create romano -f ./Modelfile`
3. ⚙️ Genera `opencode.json` nel progetto con la configurazione romana
4. 📋 Stampa le istruzioni per la configurazione globale di VS Code

---

## 🌀 Istruzioni per lo Spinner in Romano

### File disponibili

| File | Stile | Atmosfera |
|------|-------|-----------|
| [`spinners.json`](./spinners.json) | Romanesco quotidiano | Caldo, ironico, da Trastevere |
| [`spinners-romanzo-criminale.json`](./spinners-romanzo-criminale.json) | Romanesco gangster | Freddo, diretto, anni '70 |

> La struttura è pensata per crescere via Pull Request: aggiungi il tuo tema
> (Sordi, Totti, Sora Cesira...) e apri una PR!

Il file base [`spinners.json`](./spinners.json) contiene tre categorie, ognuna con varianti
randomizzabili:

```json
{
  "loading": ["Sto a fatica', spetta n'attimo...", "..."],
  "success": ["Fatto, capo! Tutto dritto.", "..."],
  "fail":    ["Inciampai... s'è sfasciato tutto.", "..."]
}
```

### Personalizzare il proprio Spinner Verb

Puoi selezionare un verbo/frase a caso dalla categoria che preferisci e usarla come
testo dello spinner. In questo modo ogni esecuzione del tuo script sarà leggermente
diversa — e tutta romana.

```javascript
const spinners = require('./spinners.json');
const pick = arr => arr[Math.floor(Math.random() * arr.length)];

// Selezione randomica per categoria
const loadingMsg = pick(spinners.loading); // "Sto a girà come una trottola..."
const successMsg = pick(spinners.success); // "Spaccato! Funziona tutto."
const failMsg    = pick(spinners.fail);    // "Me so' inceppato come n'roscio."
```

### Node.js con `ora`

```bash
npm install ora
```

```javascript
import ora from 'ora';
import { readFileSync } from 'fs';

const spinners = JSON.parse(readFileSync('./spinners.json', 'utf-8'));
const pick = arr => arr[Math.floor(Math.random() * arr.length)];

const spinner = ora({
  text:    pick(spinners.loading),
  color:   'red',      // 🔴 rosso come er gonfalone de Roma
  spinner: 'dots'
}).start();

try {
  await laVostraOperazione();
  spinner.succeed(pick(spinners.success));
} catch (err) {
  spinner.fail(pick(spinners.fail));
  process.exit(1);
}
```

> Vedi l'esempio completo in [`examples/spinner-example.js`](./examples/spinner-example.js)

### Python con `halo`

```bash
pip install halo
```

```python
import json, random
from halo import Halo

spinners = json.load(open('spinners.json'))
pick = lambda arr: random.choice(arr)

with Halo(text=pick(spinners['loading']), spinner='dots', color='red') as sp:
    try:
        la_vostra_operazione()
        sp.succeed(pick(spinners['success']))
    except Exception:
        sp.fail(pick(spinners['fail']))
        raise
```

> Vedi l'esempio completo in [`examples/spinner-example.py`](./examples/spinner-example.py)

---

## 🤖 Usare er Modello Romano con OpenCode

Dopo `./install.sh`, OpenCode userà automaticamente er modello romano nel progetto corrente
grazie al file `opencode.json` generato nella root.

**Testa er modello direttamente:**

```bash
ollama run romano
# > Ahò, dimme tutto — che devo fa'?
```

**Override manuale da CLI:**

```bash
opencode --model ollama/romano
```

**Configurazione manuale `opencode.json` (progetto locale):**

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "ollama/romano",
  "instructions": "Rispondi sempre in dialetto romanesco verace."
}
```

---

## ⚙️ Configurazione Manuale (senza script)

### 1. Crea er Modello Ollama

```bash
ollama create romano -f ./Modelfile
ollama run romano        # verifica che funzioni
```

### 2. Cambia il Modello Base (opzionale)

Il `Modelfile` usa `llama3` di default. Per cambiare:

```bash
# Esempio con Mistral
sed -i 's/FROM llama3/FROM mistral/' Modelfile
ollama create romano -f ./Modelfile
```

Modelli testati: `llama3`, `llama3.1`, `llama3.2`, `mistral`, `codellama`

---

## 🤝 Contribuisci _(Contributing)_

> _"Chi non contribuisce nun ha diritto de lamentasse."_ — Saggezza Trasteverina

Vuoi aggiungere verbi in romano? Migliorare er System Prompt? Tradurre i docs?

Leggi **[CONTRIBUTING.md](./CONTRIBUTING.md)** — passo dopo passo, promesso.

**Quick start:**

```bash
# 1. Forka er repo e clonalo
git clone https://github.com/TUO_USERNAME/er-terminale-romano.git

# 2. Crea un branch
git checkout -b feat/nuovi-spinner-caricamento

# 3. Modifica spinners.json o Modelfile

# 4. Apri la PR — er template compare automaticamente!
```

---

## 📄 Licenza

[MIT](./LICENSE) — Fai quello che ti pare, purché mantieni i credits.
Come direbbe un romano: _"Usa pure, ma nun fa' er furbo."_

---

<div align="center">

---

### 🌍 English Section — For International Contributors

**Er Terminale Romano** is an open-source toolkit that makes your terminal and AI assistant
speak **Romanesco** — the authentic Roman dialect from Rome, Italy. Think of it as
localization, but make it _cultural_.

**What's included:**

- `spinners.json` — Loading/success/fail phrases in Roman dialect, compatible with `ora`
  (Node.js) and `halo` (Python). Pick a random "spinner verb" each run for variety.
- `Modelfile` — Ollama config to run a local LLM that responds like a Roman senior
  developer: technically precise, direct, and ironically warm.
- `install.sh` — Automated setup script for macOS and Linux.
- Full contribution guidelines in both Italian and English.

**Pull requests are very welcome!** You don't need to speak Italian fluently.
Adding one new loading phrase, fixing a typo, or improving the Modelfile prompt
are all equally valuable contributions.

See [CONTRIBUTING.md](./CONTRIBUTING.md) for the full workflow.

---

</div>
