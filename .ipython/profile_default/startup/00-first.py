from decimal import Decimal as D
import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt
import array
import bisect
import collections
import decimal
import fractions
import heapq
import itertools
import math
import operator as op
import os
import os.path as osp
import pprint
import random
import re
import string
import sys
import time

#import reduce
from functools import reduce

from see import see

import numpy
import numpy as np
import cv2
import scipy
import scipy as sp
import pandas as pd
import seaborn as sns

import chainer
import chainer.functions as F
import chainer.links as L


def mem(obj):
    return hex(id(obj))


def cvshow(img):
    if img.ndim == 2:  # gray image
        img = cv2.cvtColor(img, cv2.COLOR_GRAY2BGR)
    plt.imshow(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
    plt.show()


def imshow(img):
    plt.imshow(img)
    plt.show()


print("type()    -> analyze type of objects.")
print("see()     -> extend dir().")
