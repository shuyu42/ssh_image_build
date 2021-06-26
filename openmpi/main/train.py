import sys
import time

print(sys.argv)

with open(sys.argv[1], 'a') as f:
    for i in range(3):
        print(f'Hello World {i}')
        f.write(f'{i}\n')
        time.sleep(1)
