# -*- coding: utf-8 -*-
#! python3
# csv_transpose
# To transpose csv files
# by Baihan Lin, July 2016

import webbrowser, sys, pyperclip, requests
#import subprocess

if len(sys.argv) > 1:
    # Get address from command line.
    input = ' '.join(sys.argv[1:])
else:
    # Get address from clipboard.
    input = pyperclip.paste()

import csv

from itertools import izip

a = izip(*csv.reader(open(input, "rb")))
csv.writer(open("T-" + input, "wb")).writerows(a)

#webbrowser.open('http://www.snpedia.com/index.php/' + rs)

resmsg = requests.get('http://www.snpedia.com/index.php/' + rs)
resmsg.raise_for_status()

outfname1 = rs + '-out.txt'
#outfname2 = rs + '-PMID.txt'


outFile = open(outfname1, 'wb')
for chunk in resmsg.iter_content(10000000):
        outFile.write(chunk)
outFile.close()

#bash = "grep \">PMID\" " + outfname1 + " > " + outfname2 + "; rm " + outfname1
#subprocess.Popen(bash)


import openpyxl

