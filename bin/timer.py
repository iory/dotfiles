#!/usr/bin/env python

import time
import sys
import subprocess
import os
import argparse
import datetime
import requests


def send_line_notify(token, msg):
    msg = "{}\n{}".format(datetime.datetime.now().strftime('%H:%M'),
                        msg)
    line_notify_token = args.access_token
    line_notify_api = 'https://notify-api.line.me/api/notify'
    headers = {'Authorization': 'Bearer ' + line_notify_token}
    payload = {'message': msg}
    line_notify = requests.post(line_notify_api,
                                data=payload,
                                headers=headers)


parser = argparse.ArgumentParser()
parser.add_argument('--message', '-m', type=str, default='')
parser.add_argument('--access-token', type=str,
                    required=True)
parser.add_argument('time', metavar='TIME', type=str, nargs="*")
args = parser.parse_args()

if len(args.time) == 2:
    h = int(args.time[0])
    m = int(args.time[1])
    start_time = datetime.time(h, m)
elif len(args.time) == 1:
    if ':' in args.time[0]:
        h, m = map(int, args.time[0].split(':'))
        start_time = datetime.time(h, m)
    else:
        if 'h' in args.time[0]:
            h = int(args.time[0].replace('h', ''))
            start_time = (datetime.datetime.now() +
                          datetime.timedelta(0, h * 3600))
        else:
            m = int(args.time[0].replace('m', ''))
            start_time = (datetime.datetime.now() +
                          datetime.timedelta(0, m * 60))
else:
    print("[Error] args.time {} is invalid".format(args.time))
    sys.exit()

start_str = start_time.strftime("%H:%M")

while True:
    now_time = datetime.datetime.now()
    if start_str == now_time.strftime("%H:%M"):
        break
    time.sleep(1)  # [sec]

send_line_notify(args.access_token, args.message)
