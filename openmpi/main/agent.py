import sys
import subprocess
from datetime import datetime

print(f'[{datetime.now()}]----Entering Agent----')
print(f'argv len: {len(sys.argv)}')
print(sys.argv)

host = sys.argv[1]
port = None
offset = 2
if sys.argv[2] == '-p':
    port = sys.argv[3]
    offset = 4

cmd = ['ssh', host]
if port:
    cmd.extend(['-p', port])
cmd.extend(sys.argv[offset:])

print(f'\n-----------------\ncalling: {cmd}')
with open(f'/tmp/stdout_{host}', 'w+') as stdout:
    subprocess.run(cmd, shell=False, stdout=stdout)

print(f'[{datetime.now()}]----Exiting Agent----')