"""
er-terminale-romano — pacchetto Python

Spinner verbs in Romanesco dialect for your terminal scripts.

Usage:
    from er_terminale_romano import pick, romanesco, romanzo_criminale
    from halo import Halo

    with Halo(text=pick(romanesco['loading']), spinner='dots', color='red') as sp:
        try:
            do_something()
            sp.succeed(pick(romanesco['success']))
        except Exception:
            sp.fail(pick(romanesco['fail']))
            raise
"""

import json
import random
from pathlib import Path

_DATA_DIR = Path(__file__).parent


def pick(arr: list) -> str:
    """Seleziona una frase a caso dall'array dato."""
    return random.choice(arr)


def _load(filename: str) -> dict:
    return json.loads((_DATA_DIR / filename).read_text(encoding="utf-8"))


# Tema standard — Trastevere quotidiano
romanesco: dict = _load("spinners.json")

# Tema Romanzo Criminale — ispirato alla Banda della Magliana
romanzo_criminale: dict = _load("spinners-romanzo-criminale.json")

__all__ = ["pick", "romanesco", "romanzo_criminale"]
__version__ = "1.0.0"
