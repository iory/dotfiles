#!/usr/bin/env python
# -*- coding:utf-8 -*-

import os

if not os.path.exists(os.path.expanduser("~/.ssh")):
    os.makedirs(os.path.expanduser("~/.ssh"))

path_permission = [('~/', '755'),
                   ('~/.ssh', '700'),
                   ('~/.ssh/authorized_keys', '600'),
                   ('~/.ssh/id_rsa', '600'),
                   ('~/.ssh/config', '600'),
]

print('[check ssh server and client settings]')
for path, permission in path_permission:
    if not os.path.exists(os.path.expanduser(path)):
        continue
    current_permission = oct(os.stat(os.path.expanduser(path)).st_mode)[-3:]
    if current_permission == permission:
        print("[OK!] %s's permission" % path)
    else:
        print("\t[ERROR!] %s's permission is %s, not %s" % path,
              current_permission,
              permission)
        print('\tChanging permission of %s' % path)
        os.chmod(os.path.expanduser(path), int(permission, 8))
        current_permission = oct(os.stat(os.path.expanduser(path)).st_mode)[-3:]
        if current_permission == permission:
            print("\t[OK!] Succcessfully changed %s's permission" % path)
