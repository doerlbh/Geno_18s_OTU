#! python3
# SNPedia_scrape
# To download rs information from SNPedia automatically
# by Baihan Lin, July 2016

# read in the list and parse the parameters

from os import system,popen
import string
from sys import argv, stdout, exit
import math, webbrowser, os.path

if len(sys.argv) > 1:
    # Get address from command line.
    address = ' '.join(sys.argv[1:])

# TODO: Get address from clipboard.


path = '/Users/DoerLBH/Dropbox/git/BakerLab_cmd_scripts/pdb_extraction/'

lrawname = argv[1]
lname = lrawname[:-5]
lstr = ".list"
ostr = "_matrixB.out"

f=open(path + lname + lstr,'r')
flist=f.readlines()
flist=list(set(flist))
f.close()

# sample finely around the parameters

clist = []
count = 0

for bb in flist:
    A = bb.split('_')[0]
    B = bb.split('_')[1]
    C = bb.split('_')[2]
    Bran = [x*0.2 for x in range(5*(int(B)-2), 5*(int(B)+2)+1)]
    for Bi in Bran:
    	clist.insert(count, A+' '+str(Bi)+' '+C+'\n')
    	count+=1
    

# set range


# make combinations

  
# remove duplicates

clist = list(set(clist))

#print clist

# write into file
                         
f=open(path + lname + ostr,'w')
f.writelines(clist)
f.close()

raw_input("Press<enter>")

