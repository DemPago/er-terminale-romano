# 🤌 Come se Contribuisce a Er Terminale Romano

> _"Chi non contribuisce nun ha diritto de lamentasse."_ — Saggezza Trasteverina

Benvenuto/a! Qui trovi tutto er necessario per mandare la tua prima Pull Request.
Non serve essere dei geni — basta avere voglia de fa' 'na cosa utile e bella.

---

## 📜 Er Codice de Condotta

Prima de tutto, le regole. Non sono tante, ma so' ferree:

1. **Non fa' er coatto con codice scritto male** — Se mandi roba sporca, te la rimandiamo
   indietro. Con affetto, ma te la rimandiamo.
2. **Mantieni er codice pulito anche se er commento è romano** — Il dialetto è nei
   contenuti (`spinners.json`, `Modelfile`), non nella logica del codice.
3. **Rispetta chi contribuisce** — Ognuno parte da zero. Critica costruttiva sì, sfotto no.
4. **Testa prima de aprì la PR** — _"Funzionava sul mio PC"_ non è una giustificazione.
5. **Una PR = una cosa** — Non mischiare fix diversi nello stesso pull request.
6. **In dubbio, apri un'Issue** — Meglio chiedere prima che mandare roba sbagliata.

---

## 🔄 Er Workflow de Contribuzione

### 1. Fork del Repo

Clicca su **Fork** in alto a destra su GitHub. Ti crea una copia nel tuo profilo.

```bash
git clone https://github.com/TUO_USERNAME/er-terminale-romano.git
cd er-terminale-romano
git remote add upstream https://github.com/OWNER/er-terminale-romano.git
```

### 2. Crea un Branch

**Mai** lavorare direttamente su `main`. Crea sempre un branch descrittivo:

```bash
git checkout -b feat/nuovi-spinner-caricamento
# oppure
git checkout -b fix/typo-nel-modelfile
# oppure
git checkout -b feat/spinner-varianti-testaccio
```

**Convenzioni per i nomi di branch:**

| Prefisso | Quando usarlo |
|----------|--------------|
| `feat/`  | Nuova funzionalità o nuovi contenuti |
| `fix/`   | Correzione di bug o typo |
| `docs/`  | Modifiche alla documentazione |
| `chore/` | Manutenzione, aggiornamento dipendenze |

### 3. Modifica i File

#### Aggiungere Frasi a `spinners.json`

Apri `spinners.json` e aggiungi le tue frasi nelle categorie giuste:

```json
{
  "loading": [
    "Sto a fatica', spetta n'attimo...",
    "LA TUA NUOVA FRASE QUI"
  ],
  "success": [
    "Fatto, capo! Tutto dritto.",
    "LA TUA NUOVA FRASE QUI"
  ],
  "fail": [
    "Inciampai... s'è sfasciato tutto.",
    "LA TUA NUOVA FRASE QUI"
  ]
}
```

**Linee guida per le frasi:**

- Devono essere in romanesco autentico (non pseudo-romano inventato)
- Devono avere senso nel contesto (caricamento, successo, errore)
- Massimo ~65 caratteri (per compatibilità con tutti i terminali)
- Evita parolacce pesanti — un "porco boia" ci può stare, niente di peggio
- Non duplicare frasi già esistenti

#### Migliorare er `Modelfile`

Se hai idee per migliorare il System Prompt del modello AI:

- Aggiungi esempi di risposta tipica romana nella sezione `ESEMPI DE RISPOSTA`
- Migliora le istruzioni per casi specifici (es. domande su database, DevOps)
- Affina i parametri (`temperature`, `top_p`) se hai trovato valori migliori
- Documenta le modifiche nel commento all'inizio del file

### 4. Valida il JSON (importante!)

Prima di committare `spinners.json`, verifica che sia JSON valido:

```bash
# Con Node.js
node -e "JSON.parse(require('fs').readFileSync('./spinners.json','utf8')); console.log('JSON valido!')"

# Con Python
python3 -c "import json; json.load(open('spinners.json')); print('JSON valido!')"

# Con jq (se disponibile)
jq . spinners.json > /dev/null && echo "JSON valido!"
```

### 5. Testa in Locale

**Obbligatorio** prima di aprire la PR:

```bash
# Testa er modello Ollama (crea una versione temporanea)
ollama create romano-test -f ./Modelfile
ollama run romano-test "Spiega cos'è un array in JavaScript"
ollama rm romano-test   # pulisci dopo

# Testa gli spinner con Node.js
node examples/spinner-example.js

# Testa gli spinner con Python
python3 examples/spinner-example.py
```

### 6. Commit e Push

```bash
git add spinners.json   # o qualunque file hai modificato
git commit -m "feat(spinners): aggiungi 3 varianti caricamento stile Trastevere"
git push origin feat/nuovi-spinner-caricamento
```

**Convenzioni per i messaggi di commit** (stile Conventional Commits):

```
feat(spinners): aggiungi variante caricamento "Daje piano che arrivo..."
fix(modelfile): correggi temperatura parametro a 0.75
docs(readme): aggiungi sezione troubleshooting
chore: aggiorna .gitignore
```

### 7. Apri la Pull Request

1. Vai sulla tua fork su GitHub
2. Clicca **"Compare & pull request"**
3. Compila er template PR (compare automaticamente da `.github/PULL_REQUEST_TEMPLATE.md`)
4. Assegna le label appropriate (`spinner`, `modelfile`, `docs`, `bug`)
5. Manda!

---

## 📁 Struttura del Repo

```
er-terminale-romano/
├── README.md                        # Documentazione principale
├── CONTRIBUTING.md                  # Questo file
├── spinners.json                    # ← Frasi in romanesco per gli spinner
├── Modelfile                        # ← Config Ollama per er modello romano
├── install.sh                       # Script di installazione automatica
├── LICENSE                          # Licenza MIT
├── .gitignore
├── examples/
│   ├── spinner-example.js           # Esempio Node.js con ora
│   └── spinner-example.py           # Esempio Python con halo
└── .github/
    └── PULL_REQUEST_TEMPLATE.md     # Template automatico per le PR
```

I file chiave su cui lavoreranno la maggior parte dei contributor sono
`spinners.json` e `Modelfile`. Il resto è infrastruttura.

---

## 💡 Idee per Contribuire

Non sai da dove cominciare? Ecco alcune idee:

- 🗣️ **Aggiungi frasi** — Pensa a un'espressione romana che useresti tu davvero
- 🔧 **Migliora er Modelfile** — Affina il prompt, aggiungi esempi, testa nuovi parametri
- 📦 **Aggiungi un esempio** — `examples/spinner-example.sh` in Bash? Perché no!
- 🐛 **Segnala bug** — Apri un'Issue se qualcosa non funziona
- 📖 **Migliora la docs** — README, CONTRIBUTING, commenti nel codice
- 🌍 **Traduci** — Aggiungi istruzioni in inglese più dettagliate

---

## ❓ FAQ del Contributor

**D: Devo parlare romanesco per contribuire?**
R: No! Puoi scrivere in italiano o inglese. Le PR per il codice o la documentazione
   sono benvenute in qualsiasi lingua.

**D: Come testo se la mia frase "suona" giusta in romanesco?**
R: Leggila ad alta voce. Se un romano de Roma la direbbe senza fare una faccia strana,
   probabilmente è ok. In dubbio, aprila comunque e chiedi feedback nella PR.

**D: Posso aggiungere nuove categorie in `spinners.json` (es. "downloading")?**
R: Assolutamente! Proponi la struttura nella PR e discutiamone.

**D: Posso cambiare il modello base nel Modelfile da `llama3` ad altro?**
R: Il Modelfile usa `llama3` come default. Se vuoi testare con altri modelli,
   fallo localmente. Per modifiche al default, apri prima un'Issue per discuterne.

---

Grazie per contribuire! _Daje — er terminale romano ha bisogno de te._ 🤌
