import json
import os
import sys
from importlib import import_module as _import
from math import *

def dsin(x):
    """Return the sine of x (measured in degrees)."""
    return sin(x * pi / 180)

def dcos(x):
    """Return the cosine of x (measured in degrees)."""
    return cos(x * pi / 180)

def dtan(x):
    """Return the tangent of x (measured in degrees)."""
    return tan(x * pi / 180)

def dasin(x):
    """Return the arc sine (measured in degrees) of x.

    The result is between -90 and 90."""
    return asin(x) * 180 / pi

def dacos(x):
    """Return the arc cosine (measured in degrees) of x.

    The result is between 0 and 180."""
    return acos(x) * 180 / pi

def datan(d):
    """Return the arc tangent (measured in degrees) of x.

    The result is between -90 and 90."""
    return atan(d) * 180 / pi

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

del _import
