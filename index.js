/**
 * er-terminale-romano
 *
 * Spinner verbs in Romanesco dialect for your terminal scripts.
 *
 * Usage:
 *   import { pick, romanesco } from 'er-terminale-romano';
 *   import ora from 'ora';
 *
 *   const spinner = ora(pick(romanesco.loading)).start();
 *   await doSomething();
 *   spinner.succeed(pick(romanesco.success));
 */

import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join }  from 'path';

const __dirname = dirname(fileURLToPath(import.meta.url));
const load = f  => JSON.parse(readFileSync(join(__dirname, f), 'utf-8'));

// ---------------------------------------------------------------------------
// pick(arr) — seleziona una frase a caso da un array
// ---------------------------------------------------------------------------
export const pick = arr => arr[Math.floor(Math.random() * arr.length)];

// ---------------------------------------------------------------------------
// romanesco — tema standard (Trastevere quotidiano)
// ---------------------------------------------------------------------------
export const romanesco = load('spinners.json');

// ---------------------------------------------------------------------------
// romanzo_criminale — tema ispirato alla Banda della Magliana
// ---------------------------------------------------------------------------
export const romanzo_criminale = load('spinners-romanzo-criminale.json');

// ---------------------------------------------------------------------------
// Default export: romanesco standard
// ---------------------------------------------------------------------------
export default romanesco;
