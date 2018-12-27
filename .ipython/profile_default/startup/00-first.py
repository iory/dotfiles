import platform

try:
    import matplotlib
    if platform.system() == 'Darwin':
        matplotlib.use('TkAgg')
    elif platform.system() == 'Linux':
        matplotlib.use('Agg')
    import matplotlib.pyplot as plt  # NOQA
except ImportError:
    pass

import collections  # NOQA
import itertools  # NOQA
import os  # NOQA
import os.path as osp  # NOQA
import sys  # NOQA
import datetime  # NOQA

# check ROS
if sys.executable != '/usr/bin/python':
    # ignore ros_distro's python path
    ros_distro = os.getenv("ROS_DISTRO")
    if '/opt/ros/{}/lib/python2.7/dist-packages'.\
       format(ros_distro) in sys.path:
        sys.path.remove('/opt/ros/{}/lib/python2.7/dist-packages'.format(
            ros_distro))

try:
    import numpy  # NOQA
    import numpy as np  # NOQA
except ImportError:
    pass

try:
    import torch  # NOQA
    from torch.autograd import Variable  # NOQA
    import torch.nn as nn  # NOQA
except ImportError:
    pass


def mem(obj):
    """Return memory address"""
    return hex(id(obj))
