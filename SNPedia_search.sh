#!/usr/local/bin/

cat $1 | perl -e '$i=0;while(< >){if(/^@/&&$i==0){s/^@/>/;print;}elsif($i==1){print;$i=-3}$i++;}' > $2
