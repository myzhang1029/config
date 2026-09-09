import importlib
import ipaddress
import json
import os
import sys
from ipaddress import ip_address, ip_network
from math import *
from pathlib import Path

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
    ("sns", "seaborn"),
    ("pd", "pandas"),
    ("plt", "matplotlib.pyplot"),
    ("tf", "tensorflow"),
    ("torch", "torch"),
]

for name, module in optional_imports:
    try:
        setattr(__builtins__, name, importlib.import_module(module))
    except ImportError:
        pass
