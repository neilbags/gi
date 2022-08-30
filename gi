#!/usr/bin/python3

import sys
import argparse
import os
import requests

# where do you want things installed?
dir = '/opt/'


def sysi(cmd):
    # helper to step through interactively
    if args.i:
        print(f'> {cmd}')
        reply = str(input('Proceed? (y/n): ')).lower().strip()
        if (reply[0] == 'y'):
            return os.system(cmd)
        else:
            return 0
    else:
        return os.system(cmd)


# Handle the arguments
parser = argparse.ArgumentParser(
    description="'I'm Feeling Lucky' tool for git repositories.")
parser.add_argument('-i', action="store_true",
                    help="ask for confirmation before running commands")
parser.add_argument("query", nargs="+")
args = parser.parse_args()
if args.i:
    confirm = True
query = ' '.join(args.query)

# Query the github search api
req = requests.get("https://api.github.com/search/repositories",
                   params={'per_page': '1', 'q': query})
res = req.json()
name = res['items'][0]['name']
url = res['items'][0]['clone_url']
print(f'Found repository {name} at {url}')

# Check the output dir
print(f'Installing to {dir+name}')
if dir[-1] != '/':
    dir += '/'
if (os.access(dir, os.W_OK)):
    pass
else:
    print('Cannot write to output directory')
    sys.exit(1)

if (os.path.exists(dir+name)):
    print('Output folder already exist. Updating...')
    sysi(f'git -C {dir+name} pull')
else:
    sysi(f'git -C {dir} clone {url}')

if (os.path.exists(dir+name+'/requirements.txt')):
    sysi(f"pip3 install -r {dir+name+'/requirements.txt'}")

if (os.path.exists(dir+name+'/go.mod')):
    sysi(f'cd {dir+name}; go build')

print(f'\n{dir+name}:')
os.system(f'ls --color=tty {dir+name}')
