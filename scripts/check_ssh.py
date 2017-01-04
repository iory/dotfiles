#!/usr/bin/env python
# -*- coding:utf-8 -*-

import os
import sys

try:
    from colorama import Fore, Style
except:
    print("Please install colorama by pip install colorama")
    sys.exit(1)

if not os.path.exists(os.path.expanduser("~/.ssh")):
    os.makedirs(os.path.expanduser("~/.ssh"))

path_permission = [('~/', '755'),
                   ('~/.ssh', '700'),
                   ('~/.ssh/authorized_keys', '600'),
                   ('~/.ssh/id_rsa', '600'),
                   ('~/.ssh/config', '600'),
]

print(Fore.CYAN, '[check ssh server and client settings]')
for path, permission in path_permission:
    if not os.path.exists(os.path.expanduser(path)):
        continue
    current_permission = oct(os.stat(os.path.expanduser(path)).st_mode)[-3:]
    if current_permission == permission:
        print(Fore.GREEN, "[OK!] {}'s permission".format(path))
    else:
        print(Fore.RED, "\t[ERROR!] {}'s permission is {}, not {}".format(path,
                                                                        current_permission,
                                                                        permission))
        print(Fore.YELLOW, '\tChanging permission of {}'.format(path))
        os.chmod(os.path.expanduser(path), int(permission, 8))
        current_permission = oct(os.stat(os.path.expanduser(path)).st_mode)[-3:]
        if current_permission == permission:
            print(Fore.GREEN, "\t[OK!] Succcessfully changed {}'s permission".format(path))
