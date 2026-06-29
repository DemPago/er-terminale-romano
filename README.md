<div align="center">

# 🤌 Er Terminale Romano

**_"Ahò, nun solo er caffè — mo' pure er terminale te parla romano!"_**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](./CONTRIBUTING.md)
[![Romanesco](https://img.shields.io/badge/dialetto-romanesco_verace-CC0000.svg)]()
[![Made with love in Roma](https://img.shields.io/badge/Made%20with%20%E2%9D%A4%EF%B8%8F%20in-Roma-CC0000.svg)]()

_Vuoi l'italiano, il romano o il tuo dialetto nel terminale e nell'AI — senza token extra._

[Spinner nel tuo progetto](#-spinner-nel-tuo-progetto) · [AI Romano](#-ai-romano-con-ollama--opencode) · [Temi](#-temi-disponibili) · [Contribuisci](#-contribuisci)

</div>

---

## 🏛️ Che stamo a fa'? _(What's this about?)_

Due cose distinte, usabili insieme o separatamente:

| | Cosa | Come |
|-|------|------|
| 🌀 | **Spinner in dialetto** nel tuo script Node.js o Python | `npm install github:DemPago/er-terminale-romano` |
| 🤖 | **AI che risponde in romano** (OpenCode + Ollama) | `./install.sh` |

---

## 🎭 La Filosofia

> _"Er dialetto nun è 'na cosa de bassa cultura — è identità, è calore, è precisione emotiva."_

Quante volte hai letto "_Loading..._", "_Done._", "_Error._" senza sentirci niente?

Con **Er Terminale Romano**, ogni stato del tuo terminale diventa una frase vera, vissuta, de Roma.
E il tuo AI smette di essere un robot freddo e diventa un collega romano: competente, ironico,
diretto — con quella simpatica arroganza bonaria che tutti conoscono.

---

## 📦 Spinner nel tuo Progetto

### Installazione

```bash
npm install github:DemPago/er-terminale-romano
```

### Uso con `ora` (Node.js)

```javascript
import { pick, romanesco } from 'er-terminale-romano';
import ora from 'ora';

const spinner = ora(pick(romanesco.loading)).start();

try {
  await laVostraOperazione();
  spinner.succeed(pick(romanesco.success));
} catch (err) {
  spinner.fail(pick(romanesco.fail));
  process.exit(1);
}
```

### Uso con `halo` (Python)

```bash
pip install git+https://github.com/DemPago/er-terminale-romano.git halo
```

```python
from er_terminale_romano import pick, romanesco
from halo import Halo

with Halo(text=pick(romanesco['loading']), spinner='dots', color='red') as sp:
    try:
        la_vostra_operazione()
        sp.succeed(pick(romanesco['success']))
    except Exception:
        sp.fail(pick(romanesco['fail']))
        raise
```

> Vedi esempi completi in [`examples/`](./examples/)

---

## 🎨 Temi Disponibili

| Import | File | Atmosfera |
|--------|------|-----------|
| `romanesco` | [`spinners.json`](./spinners.json) | Trastevere quotidiano — caldo, ironico |
| `romanzo_criminale` | [`spinners-romanzo-criminale.json`](./spinners-romanzo-criminale.json) | Banda della Magliana — freddo, diretto |

### Categorie disponibili

| Chiave | Quando usarla |
|--------|---------------|
| `loading` | Operazione generica in corso |
| `success` | Completamento con successo |
| `fail` | Errore o fallimento |
| `installing` | Installazione di dipendenze/pacchetti |
| `building` | Compilazione o build |
| `connecting` | Connessione a server, DB, rete |
| `saving` | Scrittura su disco o persistenza |
| `warning` | Avviso non bloccante |
| `retrying` | Nuovo tentativo dopo un fallimento |

```javascript
import { pick, romanesco, romanzo_criminale } from 'er-terminale-romano';

pick(romanesco.loading)           // "Sto a girà come una trottola..."
pick(romanesco.installing)        // "Le librerie stanno a arrivà, un attimo..."
pick(romanesco.retrying)          // "Insisto, ché so' romano e nun me arrendo."
pick(romanzo_criminale.loading)   // "Er Freddo sta a pensà — daje piano."
pick(romanzo_criminale.warning)   // "C'è qualcosa de storto qua."
```

> Vuoi aggiungere un tema (Sordi, Totti, napoletano...)? Apri una PR — la struttura è fatta per crescere.

---

## 🤖 AI Romano con Ollama + OpenCode

Per far parlare romano anche il tuo assistente AI in locale, senza pagare token:

```bash
git clone https://github.com/DemPago/er-terminale-romano.git
cd er-terminale-romano
chmod +x install.sh
./install.sh
```

Lo script configura in automatico:
1. ✅ Controlla che Ollama sia installato e in esecuzione
2. 🏗️ Crea il modello `romano` — `ollama create romano -f ./Modelfile`
3. ⚙️ Genera `opencode.json` nel progetto corrente
4. 🖥️ Menu interattivo per configurare il tuo editor (VS Code, Cursor, Neovim, Zed, JetBrains)

**Test rapido:**

```bash
ollama run romano
# > Ahò, dimme tutto — che devo fa'?
```

**Modelli supportati:** `llama3`, `llama3.1`, `llama3.2`, `mistral`, `codellama`

> Configurazioni editor in [`editors/`](./editors/) — vedi [`editors/README.md`](./editors/README.md)

---

## 🤝 Contribuisci _(Contributing)_

> _"Chi non contribuisce nun ha diritto de lamentasse."_ — Saggezza Trasteverina

Vuoi aggiungere frasi in romanesco? Un nuovo tema? Migliorare er System Prompt?

Leggi **[CONTRIBUTING.md](./CONTRIBUTING.md)** — passo dopo passo, promesso.

```bash
git clone https://github.com/DemPago/er-terminale-romano.git
git checkout -b feat/nuovo-tema-totti
# modifica spinners.json o aggiungi spinners-totti.json
# apri la PR — er template compare automaticamente
```

---

## 📄 Licenza

[MIT](./LICENSE) — Fai quello che ti pare, purché mantieni i credits.
Come direbbe un romano: _"Usa pure, ma nun fa' er furbo."_

---

<div align="center">

---

### 🌍 English Section — For International Contributors

**Er Terminale Romano** is an open-source toolkit with two independent features:

1. **Spinner verbs in Roman dialect** — install as an npm package and use in any Node.js or Python project. No accounts, no API keys, no cloud costs.
2. **AI assistant in Roman dialect** — configure a local Ollama LLM to respond like a Roman senior developer via OpenCode.

**Install the spinner package:**
```bash
npm install github:DemPago/er-terminale-romano
```

**Available themes:** `romanesco` (everyday Trastevere style) · `romanzo_criminale` (Banda della Magliana-inspired)

**Available categories:** `loading` · `success` · `fail` · `installing` · `building` · `connecting` · `saving` · `warning` · `retrying`

**Pull requests are very welcome!** You don't need to speak Italian.
Adding a new spinner theme, improving the Modelfile prompt, or fixing a typo
are all equally valuable contributions. See [CONTRIBUTING.md](./CONTRIBUTING.md).

---

</div>
