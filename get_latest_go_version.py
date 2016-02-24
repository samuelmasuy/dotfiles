import os
import requests
import xml.etree.ElementTree as ET
from datetime import datetime, timedelta
import tarfile


def make_tree(url):
    response = requests.get(url, verify=True).text
    tree = ET.fromstring(response)
    return tree


def get_latest_go(tree, search='linux-amd64.tar.gz'):
    current = datetime.now() - timedelta(days=600)
    for c in tree.findall('{http://doc.s3.amazonaws.com/2006-03-01}Contents'):
        date = c.find('{http://doc.s3.amazonaws.com/2006-03-01}LastModified').text
        new_date = datetime.strptime(date, "%Y-%m-%dT%H:%M:%S.%fZ")
        if new_date > current:
            current = new_date
            current_key = c.find('{http://doc.s3.amazonaws.com/2006-03-01}Key').text
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


if __name__ == '__main__':
    # root_url = 'https://storage.googleapis.com/golang/'
    # tree = make_tree(root_url)
    # key = get_latest_go(tree)
    # filename = download_file(root_url + key)
    # extract_file(filename, '.')
    os.remove('go1.6.linux-amd64.tar.gz')
# sudo mv go /usr/local
