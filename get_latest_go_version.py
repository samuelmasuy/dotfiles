import argparse
import os
import shutil
import xml.etree.ElementTree as ET
from datetime import datetime, timedelta
import tarfile
from sys import platform as _platform

import requests


root_url = 'https://storage.googleapis.com/golang/'
options = ['linux-amd64', 'linux-386', 'linux-armv6l', 'darwin-amd64', 'freebsd-amd64', 'src']
target_install_path = '/usr/local/'


def make_tree(url):
    response = requests.get(url, verify=True).text
    tree = ET.fromstring(response)
    print tree
    return tree


def get_namespace(root):
    return '{' + root.tag.split('}')[0].strip('{') + '}'


def get_latest_go(tree, namespace, search='linux-amd64.tar.gz'):
    key = ""
    current = datetime.now() - timedelta(days=600)
    for c in tree.findall(namespace + 'Contents'):
        date = c.find(namespace + 'LastModified').text
        new_date = datetime.strptime(date, "%Y-%m-%dT%H:%M:%S.%fZ")
        if new_date > current:
            current = new_date
            current_key = c.find(namespace + 'Key').text
            if search in current_key:
                key = current_key
    return key


def download_file(url):
    local_filename = url.split('/')[-1]
    r = requests.get(url, stream=True)
    with open(local_filename, 'wb') as f:
        for chunk in r.iter_content(chunk_size=1024):
            if chunk:
                f.write(chunk)
    return local_filename


def extract_file(filename, target_folder):
    with tarfile.open(filename) as tar:
        tar.extractall(target_folder)


def install_go():
    if os.path.exists('/usr/local/go'):
        shutil.rmtree('/usr/local/go')
    shutil.move('./go', target_install_path)


def get_flags(options):
    parser = argparse.ArgumentParser(description='Get latest version of Go')
    parser.add_argument('-t', '--type', dest='type', default='',
                        help='Type (OS): [' + ', '.join(options) + ']')
    parser.add_argument('-i', '--install', dest='install', action='store_true',
                        help='Install Go under ' + target_install_path + ', must be runned as ROOT. (Only linux is supported)')
    parser.set_defaults(install=False)
    return parser.parse_args()


def dialog_types(options):
    chosen = ""
    while chosen == "":
        print "Here is a list of the go version you can get, please select the one you want:"
        for item in enumerate(options, 1):
            print "[%d] %s" % item

        try:
            idx = int(raw_input("Enter the file's number: "))
        except ValueError:
                print "You fail at typing numbers."

        try:
            chosen = options[idx - 1]
        except IndexError:
            print "Try a number in range next time."
    return chosen


if __name__ == '__main__':

    args = get_flags(options)
    if args.install:
        if (_platform == "linux" or _platform == "linux2"):
            if os.geteuid() != 0:
                exit("You need to have root privileges to install go.\nPlease try again, this time using 'sudo'. Exiting.")
        else:
            exit("You don't run under linux.\nExiting.")
    if args.type == '':
        type = dialog_types(options)
    else:
        type = args.type

    # get list of all go versions
    tree = make_tree(root_url)

    # find latest version for the target os
    key = get_latest_go(tree, get_namespace(tree), type + '.tar.gz')
    if key == "":
        exit("The type you selected is not found in the go repo.\nPlease try again, using one of the following type: [linux-amd64, linux-386, linux-armv6l, darwin-amd64, src].")
    else:
        print "Latest version of go is", key

    # print "Downloading the latest version of go"
    # filename = download_file(root_url + key)

    # extract_file(filename, '.')
    # print "Extracted go, removed tar archive"

    # os.remove(filename)

    # if args.install:
    #     print "Installing go"
    #     install_go()
    # print "Done!"
