#!/usr/bin/env python
import collections
import subprocess
import sys

key_map = {}
ShortCut = collections.namedtuple("ShortCut", ['cmd', 'keys'])

key_map['emacs'] = ShortCut('emacs', '<Ctrl><Alt>e')
key_map['screenshot'] = ShortCut('gnome-screenshot', '<Alt><Ctrl>3')
key_map['screenshot-area'] = ShortCut('gnome-screenshot --area', '<Alt><Ctrl>4')
key_map['screenshot-window'] = ShortCut('gnome-screenshot --window', '<Alt><Ctrl>5')
key_map['screenshot-with-clip'] = ShortCut('gnome-screenshot -c', '<Alt><Ctrl><Ctrl>3')
key_map['screenshot-area-with-clip'] = ShortCut('gnome-screenshot --area -c', '<Alt><Ctrl><Ctrl>4')
key_map['screenshot-window-with-clip'] = ShortCut('gnome-screenshot --window -c', '<Alt><Ctrl><Ctrl>5')


for name, shortcut in key_map.iteritems():
    # print(name, shortcut.cmd, shortcut.keys)
    subprocess.call(['python', 'set_customshortcut.py', name, shortcut.cmd, shortcut.keys])
