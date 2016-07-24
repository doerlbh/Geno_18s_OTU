#!/usr/local/bin/

#cat rslist | uniq -d > rslistuniq;

now=$(date +"%Y%m%d");

for j in `cat rslist`; do
	python SNPedia_scrape.py $j;

	for i in *out.txt; do
		grep ">PMID"  $i > ${i//out.txt/PMID};
		rm *out.txt;
		echo anotherone;
	done

	sed -i '' 's/.*PMID/PMID/g' *PMID*;
	sed -i '' "s#</a>] #$(printf '\t')#g" *PMID*;
	sed -i -e "s/^/$j$(printf '\t')/" *PMID*;
done

for k in *e; do
	cat $k ${k//-e/} > ${k//-e/.combo};
	rm $k;
done

cat *PMID.combo >> PMIDlist$now;
#rm Rs*;


