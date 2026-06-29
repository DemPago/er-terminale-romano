## 🤌 Che hai combinato? _(What did you do?)_

> _Descrivi brevemente le modifiche in italiano, romanesco o inglese — fa' lo stesso._

<!-- Esempio: "Ho aggiunto 4 nuove frasi di caricamento in romanesco trasteverino" -->



---

## ✅ Checklist Pre-PR

Prima de mandà sta roba, metti un segno su tutto:

- [ ] Ho eseguito `./install.sh` (o almeno la parte che ho modificato) sulla mia macchina
- [ ] Niente errori in console, niente crash, tutto funziona
- [ ] Ho letto [`CONTRIBUTING.md`](../CONTRIBUTING.md) e so quello che sto a fa'
- [ ] La mia PR riguarda **una sola cosa** (niente modifiche miscellanee)
- [ ] Il `spinners.json` è JSON valido (testato con `node -e "JSON.parse(...)"` o `jq .`)
- [ ] Ho aggiornato la documentazione se necessario

---

## 🌀 Nuovi Spinner Aggiunti

_Se hai modificato `spinners.json`, elenca qui le frasi nuove:_

**Loading (caricamento):**
- 

**Success (successo):**
- 

**Fail (errore):**
- 

_Se non hai toccato `spinners.json`, cancella questa sezione._

---

## 🤖 Modifiche al Modelfile

_Se hai modificato er `Modelfile`, rispondi a queste domande:_

- **Cosa hai cambiato nel System Prompt?**
  <!-- Descrivi la modifica -->

- **Hai testato il modello?**
  <!-- Sì/No — con quale comando: ollama create romano-test -f ./Modelfile && ollama run romano-test -->

- **Le risposte sono migliorate? In che modo?**
  <!-- Mostra un esempio prima/dopo se puoi -->

_Se non hai toccato il `Modelfile`, cancella questa sezione._

---

## 🖥️ Ambiente di Test

| Campo | Valore |
|-------|--------|
| OS | <!-- macOS 14.x / Ubuntu 22.04 / etc. --> |
| Ollama version | <!-- output di: ollama --version --> |
| Modello base usato | <!-- llama3 / mistral / llama3.2 / etc. --> |

---

## 📝 Note per il Reviewer

_Qualsiasi altra cosa che chi revisiona dovrebbe sapere._



---

> _"Er codice buono parla da solo, ma una buona descrizione aiuta pure er migliore dei reviewer."_ 🤌
