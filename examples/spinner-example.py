"""
Er Terminale Romano — examples/spinner-example.py

Dimostra come usare spinners.json con la libreria 'halo' in Python.
Questo file gira autonomamente (con output semplice su console)
e mostra anche il codice completo con 'halo' come riferimento.

Prerequisiti per l'esempio completo:
    pip install halo

Uso:
    python3 examples/spinner-example.py
"""

import json
import os
import random
import sys
import time

# ---------------------------------------------------------------------------
# Carica spinners.json dalla root del repo
# ---------------------------------------------------------------------------
script_dir   = os.path.dirname(os.path.abspath(__file__))
spinners_path = os.path.join(script_dir, '..', 'spinners.json')

with open(spinners_path, 'r', encoding='utf-8') as f:
    spinners = json.load(f)


# ---------------------------------------------------------------------------
# Funzione helper: seleziona una frase a caso da una categoria
# ---------------------------------------------------------------------------
def pick(arr: list) -> str:
    return random.choice(arr)


# ---------------------------------------------------------------------------
# Demo senza dipendenze esterne (stampa semplice su console)
# ---------------------------------------------------------------------------
def demo_senza_halo() -> None:
    print('\n── Demo senza librerie esterne ──\n')

    # Simula caricamento con successo
    sys.stdout.write(f'⏳ {pick(spinners["loading"])}')
    sys.stdout.flush()
    time.sleep(2)
    sys.stdout.write('\r' + ' ' * 70 + '\r')
    print(f'✅ {pick(spinners["success"])}')

    time.sleep(0.5)

    # Simula caricamento con errore
    sys.stdout.write(f'⏳ {pick(spinners["loading"])}')
    sys.stdout.flush()
    time.sleep(1.5)
    sys.stdout.write('\r' + ' ' * 70 + '\r')
    print(f'❌ {pick(spinners["fail"])}')


# ---------------------------------------------------------------------------
# Mostra tutte le frasi disponibili per categoria
# ---------------------------------------------------------------------------
def mostra_frasi() -> None:
    print('\n── Tutte le frasi disponibili ──\n')
    for categoria, frasi in spinners.items():
        print(f'{categoria.upper()}:')
        for i, frase in enumerate(frasi, 1):
            print(f'  {i}. {frase}')
        print()


# ---------------------------------------------------------------------------
# ESEMPIO COMPLETO CON 'halo' (da usare dopo: pip install halo)
# ---------------------------------------------------------------------------
#
# from halo import Halo
# import json, random
#
# spinners = json.load(open('spinners.json'))
# pick = lambda arr: random.choice(arr)
#
# with Halo(text=pick(spinners['loading']), spinner='dots', color='red') as sp:
#     try:
#         la_vostra_operazione()
#         sp.succeed(pick(spinners['success']))
#     except Exception as e:
#         sp.fail(pick(spinners['fail']))
#         raise

# ---------------------------------------------------------------------------
# MAIN
# ---------------------------------------------------------------------------
if __name__ == '__main__':
    print()
    print('═══════════════════════════════════════════')
    print('   🤌  Er Terminale Romano — Spinner Demo  ')
    print('═══════════════════════════════════════════')

    demo_senza_halo()
    mostra_frasi()

    print('Ahò, er demo è finito. Daje! 🤌\n')
