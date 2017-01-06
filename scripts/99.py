#! /usr/bin/env python

import sys

import numpy as np


while True:
    a = np.random.randint(low=10, high=100)
    b = np.random.randint(low=10, high=100)
    while True:
        print("{} * {} =".format(a, b), end=' ')
        ans = input()
        if ans in ['quit', 'exit', 'q']:
            sys.exit()
        ans = int(ans)
        if ans != a * b:
            print("incorrect")
        else:
            break
    print("correct!")
