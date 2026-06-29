#!/usr/bin/env node
/**
 * Er Terminale Romano — spinner-example.js
 *
 * Uso:
 *   npm install          (solo la prima volta)
 *   npm run demo         (romanesco standard)
 *   npm run demo:rc      (tema Romanzo Criminale)
 *
 *   oppure direttamente:
 *   node examples/spinner-example.js
 *   node examples/spinner-example.js --rc
 */

import ora  from 'ora';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join }  from 'path';

const __dirname = dirname(fileURLToPath(import.meta.url));
const isRC      = process.argv.includes('--rc');

// Carica il file di frasi giusto in base al flag
const spinnersFile = isRC
  ? '../spinners-romanzo-criminale.json'
  : '../spinners.json';

const spinners = JSON.parse(
  readFileSync(join(__dirname, spinnersFile), 'utf-8')
);

const pick  = arr => arr[Math.floor(Math.random() * arr.length)];
const sleep = ms  => new Promise(r => setTimeout(r, ms));

// ---------------------------------------------------------------------------
async function demo() {
  const theme = isRC ? '🎬 Romanzo Criminale' : '🤌 Romanesco Verace';
  console.log(`\n  Er Terminale Romano — ${theme}\n`);

  // Operazione 1: successo
  const sp1 = ora({ text: pick(spinners.loading), color: 'red' }).start();
  await sleep(2500);
  sp1.succeed(pick(spinners.success));

  await sleep(700);

  // Operazione 2: errore
  const sp2 = ora({ text: pick(spinners.loading), color: 'red' }).start();
  await sleep(2000);
  sp2.fail(pick(spinners.fail));

  console.log();
}

demo().catch(err => { console.error(err); process.exit(1); });
