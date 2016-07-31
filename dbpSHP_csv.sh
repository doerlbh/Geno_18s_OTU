#!/usr/local/bin/
# Baihan Lin
# July 2016

for i in *csv; do
	cp $i new-$i
	sed -e '' "s/)/)\",\"/g" new-$i;
	sed -e '' "s/\"ss.*-HAPMAP\",//g" new-$i;
	sed -e '' "s/,\".*ShowHide.*\"//g" new-$i;
	sed -e '' "s/\",\"\",\"/\",\"/g" new-$i;
	sed -e '' "s/\"ssID\",\"Submitter\",//g" new-$i;
	sed -e '' "s/(count)\",\"/(count)\",\"\",\"/g" new-$i;
	sed -e '' "s/\"Genotype detail\"/\"\",\"Genotype detail\"/g" new-$i;
	python /Users/DoerLBH/Dropbox/git/Geno_SNP_18s_OTU/csv_transpose.py new-$i
done




