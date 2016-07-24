#! python3
# SNPedia_scrape
# To download rs information from SNPedia automatically
# Input from system command line or clipboard
# by Baihan Lin, July 2016

# read in the list and parse the parameters

import webbrowser, sys, pyperclip, requests
if len(sys.argv) > 1:
    # Get address from command line.
    rs = ' '.join(sys.argv[1:])
else:
    # Get address from clipboard.
    rs = pyperclip.paste()

webbrowser.open('http://www.snpedia.com/index.php/' + rs)

resmsg = requests.get('http://www.snpedia.com/index.php/' + rs)
resmsg.raise_for_status()
outFile = open(rs + '-out.txt', 'wb')
for chunk in res.iter_content(1000000):
        outFile.write(chunk)
outFile.close()


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

