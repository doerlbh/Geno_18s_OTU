#!/usr/local/bin/


now=$(date +"%Y%m%d");

for i in *out.txt; do
	grep ">PMID"  > ${i//out.txt/PMID} ;

done

cat *PMID > rslist$now;

sed -i 's/*PMID/PMID/g' rslist$now

