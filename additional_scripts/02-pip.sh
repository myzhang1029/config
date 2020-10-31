#!/bin/sh
# Install python packages

python3 -m pip install -U wheel pip pycodestyle autopep8 isort mypy pylint ipython requests numpy toyplot || true
