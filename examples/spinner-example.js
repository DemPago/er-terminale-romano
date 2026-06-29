/**
 * Er Terminale Romano — examples/spinner-example.js
 *
 * Dimostra come usare spinners.json con la libreria 'ora' in Node.js.
 * Questo file gira autonomamente (con output semplice su console)
 * e mostra anche il codice completo con 'ora' come riferimento.
 *
 * Prerequisiti per l'esempio completo:
 *   npm install ora
 *
 * Uso:
 *   node examples/spinner-example.js
 */

import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join }  from 'path';

// ---------------------------------------------------------------------------
// Carica spinners.json dalla root del repo
// ---------------------------------------------------------------------------
const __filename = fileURLToPath(import.meta.url);
const __dirname  = dirname(__filename);
const spinnersPath = join(__dirname, '..', 'spinners.json');

const spinners = JSON.parse(readFileSync(spinnersPath, 'utf-8'));

// ---------------------------------------------------------------------------
// Funzione helper: seleziona una frase a caso da una categoria
// ---------------------------------------------------------------------------
function pick(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
}

// ---------------------------------------------------------------------------
// Simulazione di un'operazione asincrona
// ---------------------------------------------------------------------------
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// ---------------------------------------------------------------------------
// Helper: pulisce la riga corrente (funziona sia in TTY che fuori)
// ---------------------------------------------------------------------------
function clearCurrentLine() {
  if (typeof process.stdout.clearLine === 'function') {
    process.stdout.clearLine(0);
    process.stdout.cursorTo(0);
  } else {
    process.stdout.write('\r' + ' '.repeat(80) + '\r');
  }
}

// ---------------------------------------------------------------------------
// Demo senza dipendenze esterne (stampa semplice su console)
// ---------------------------------------------------------------------------
async function demoSenzaOra() {
  console.log('\n── Demo senza librerie esterne ──\n');

  process.stdout.write(`⏳ ${pick(spinners.loading)}`);
  await sleep(2000);
  clearCurrentLine();
  console.log(`✅ ${pick(spinners.success)}`);

  await sleep(500);

  process.stdout.write(`⏳ ${pick(spinners.loading)}`);
  await sleep(1500);
  clearCurrentLine();
  console.log(`❌ ${pick(spinners.fail)}`);
}

// ---------------------------------------------------------------------------
// Mostra tutte le frasi disponibili per categoria
// ---------------------------------------------------------------------------
function mostraFrasi() {
  console.log('\n── Tutte le frasi disponibili ──\n');

  for (const [categoria, frasi] of Object.entries(spinners)) {
    console.log(`${categoria.toUpperCase()}:`);
    frasi.forEach((frase, i) => console.log(`  ${i + 1}. ${frase}`));
    console.log('');
  }
}

// ---------------------------------------------------------------------------
// ESEMPIO COMPLETO CON 'ora' (da usare dopo: npm install ora)
// ---------------------------------------------------------------------------
//
// import ora from 'ora';
//
// const spinners = JSON.parse(readFileSync('./spinners.json', 'utf-8'));
// const pick = arr => arr[Math.floor(Math.random() * arr.length)];
//
// const spinner = ora({
//   text:    pick(spinners.loading),
//   color:   'red',         // 🔴 rosso come er gonfalone de Roma
//   spinner: 'dots'
// }).start();
//
// try {
//   await laVostraOperazioneAsincrona();
//   spinner.succeed(pick(spinners.success));
// } catch (err) {
//   spinner.fail(pick(spinners.fail));
//   process.exit(1);
// }

// ---------------------------------------------------------------------------
// MAIN
// ---------------------------------------------------------------------------
console.log('\n═══════════════════════════════════════════');
console.log('   🤌  Er Terminale Romano — Spinner Demo  ');
console.log('═══════════════════════════════════════════');

demoSenzaOra()
  .then(() => mostraFrasi())
  .catch(err => {
    console.error('Errore nella demo:', err);
    process.exit(1);
  });
