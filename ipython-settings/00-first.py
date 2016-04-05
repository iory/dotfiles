import array
import bisect
import collections
import decimal
from decimal import Decimal as D
import fractions
import heapq
import itertools
import math
import os
import operator as op
import pprint
import pyperclip
import random
import re
import string
import sys

#import reduce
from functools import reduce

from see import see

import numpy
import numpy as np
import cv2
import scipy
import scipy as sp
import pandas as pd
import mahotas as mh
import matplotlib.pyplot as plt
import mahotas as mh

def pbcopy(text):
    if not isinstance(str, text):
        text = str(text)
    pyperclip.copy(text)

print("type()    -> analyze type of objects.")
print("see()     -> extend dir().")
