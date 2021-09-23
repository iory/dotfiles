import platform
import sys

# For IPython.embed
from traitlets.config import get_config
ipython_config = get_config()

if platform.system() == 'Linux':
    ipython_config.InteractiveShellEmbed.colors = "Linux"

try:
    import matplotlib
    if platform.system() == 'Darwin':
        matplotlib.use('TkAgg')
    elif platform.system() == 'Linux':
        matplotlib.use('TkAgg')
    import matplotlib.pyplot as plt  # NOQA
except ImportError:
    pass

if sys.version_info.major == 3:
    import pathlib  # NOQA
    from pathlib import Path  # NOQA

import collections  # NOQA
import itertools  # NOQA
import os  # NOQA
import os.path as osp  # NOQA
import sys  # NOQA
import datetime  # NOQA
import subprocess  # NOQA

# check python and ipython path
p = subprocess.Popen(
    'which python', shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE)
python_path, _ = p.communicate()
p = subprocess.Popen(
    'which ipython', shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE)
ipython_path, _ = p.communicate()
if os.path.dirname(python_path) != os.path.dirname(ipython_path):
    print('\033[91m' +  # red
          "[WARNING] python path and ipython path are not same!\n"
          '\33[32m'  # green
          "In [0]: python:  {}"
          "In [0]: ipython: {}".format(
              python_path.decode('utf-8'), ipython_path.decode('utf-8'))
          + '\033[0m')

try:
    import numpy  # NOQA
    import numpy as np  # NOQA
except ImportError:
    pass


def mem(obj):
    """Return memory address"""
    return hex(id(obj))
