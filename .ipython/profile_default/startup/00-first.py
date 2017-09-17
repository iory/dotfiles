try:
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
except ImportError:
    pass

import collections
import itertools
import os
import os.path as osp
import sys
import datetime

try:
    import numpy
    import numpy as np
except ImportError:
    pass


def mem(obj):
    """Return memory address"""
    return hex(id(obj))
