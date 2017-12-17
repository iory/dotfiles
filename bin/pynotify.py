import os
import subprocess
from cached_property import cached_property
import warnings


LOW = 1
NORMAL = 2
CRITICAL = 3

output = subprocess.check_output(['which', 'notify-send'])
if len(output) == 0:
    _available = True
else:
    _available = False


@cached_property
def _check_available():
    if not _available:
        warnings.warn('matplotlib is not installed on your environment, '
                      'so nothing will be plotted at this time. '
                      'Please install matplotlib to plot figures.\n\n'
                      '  $ pip install matplotlib\n')
    return _available


def notify_send(title, msg, icon_path=None, ulevel=NORMAL, expiratnion_time=1,
                name='notify-send'):
    if not _check_available:
        return

    def valid_img(i):
        return True if i.endswith('.png') or \
            i.endswith('.jpg') or \
            i.endswith('.jpeg') else False

    def valid_code(code):
        return True if code in (LOW, NORMAL, CRITICAL) else False

    def code_as_str(code):
        if code == LOW:
            return 'low'
        elif code == NORMAL:
            return 'normal'
        elif code == CRITICAL:
            return 'critical'
        return ''

    if len(title) == 0 and len(msg) == 0:
        raise RuntimeError('No summary specified.')

    if not isinstance(title, str) or not isinstance(msg, str):
        raise RuntimeError('Messages should be python strings.')

    cmd = ['notify-send', '-t', str(expiratnion_time), '-a', name]

    if valid_code(ulevel):
        cmd += ['-u', code_as_str(ulevel)]

    if icon_path is not None and \
       os.path.exists(icon_path) and \
       valid_img(icon_path):
        cmd += ['-i', icon_path]

    if len(title) > 0:
        cmd += [title]

    if len(msg) > 0:
        cmd += [msg]

    subprocess.call(cmd)
