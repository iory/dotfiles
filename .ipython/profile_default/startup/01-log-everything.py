#!/usr/bin/env python
# -*- coding:utf-8 -*-

from time import strftime
import os.path
import contextlib
try:
    from cStringIO import StringIO
except:
    try:
        from StringIO import StringIO
    except:
        from io import StringIO
import sys

# create a context which we can use for any block which we can use for any
# block which we do not want to print stdout
# -- taken from http://stackoverflow.com/a/2829036/217652


@contextlib.contextmanager
def nostdout():
    save_stdout = sys.stdout
    sys.stdout = StringIO()
    yield
    sys.stdout = save_stdout


ip = get_ipython()

ldir = ip.profile_dir.log_dir
fname = strftime('%Y-%m-%d-%H-%M-%S') + ".py"
filename = os.path.join(ldir, fname)


# stdout is now muted
with nostdout():
    ip.run_line_magic('logstart', '-o %s append' % filename)
