import json
import os
import sys
from importlib import import_module as _import
from math import *

optional_imports = [
    ("np", "numpy"),
    ("pd", "pandas"),
    ("plt", "matplotlib.pyplot"),
    ("tf", "tensorflow")
]

for name, module in optional_imports:
    try:
        setattr(__builtins__, name, _import(module))
    except ImportError:
        pass
