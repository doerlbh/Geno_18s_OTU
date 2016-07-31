#!/usr/local/bin/
# Baihan Lin
# July 2016

now=$(date +"%Y%m%d");

for i in *csv; do
	cp $i new-$i
	sed -i '' "s/)/)\",\"/g" new-$i;
	sed -i '' "s/\"ss.*-HAPMAP\",//g" new-$i;
	sed -i '' "s/,\"      ShowHide          \"//g" new-$i;
	sed -i '' "s/\",\"\",\"/\",\"/g" new-$i;
	sed -i '' "s/\"ssID\",\"Submitter\",//g" new-$i;
	sed -i '' "s/(count)\",\"/(count)\",\"\",\"/g" new-$i;
	sed -i '' "s/\"Genotype detail\"/\"\",\"Genotype detail\"/g" new-$i;
done

#for k in *e; do
#	cat $k ${k//-e/} > ${k//-e/.combo};
#	rm $k;
#done

cat Rs* >> PMIDlist$now;
sort PMIDlist$now > PMID$now.sort;
uniq -d PMID$now.sort > PMID$now.uniq;

grep "Rs"  PMID$now.uniq > PMIDRs$now.uniq

#cat *PMID.combo >> PMIDlist$now;
rm Rs*;


