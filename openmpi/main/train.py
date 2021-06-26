import sys
import time
from datetime import datetime

print(sys.argv)

with open(sys.argv[1], 'a') as f:
    for i in range(3):
        print(f'[{datetime.now()}] Hello MPI {i}')
        f.write(f'{i}\n')
        time.sleep(1)
