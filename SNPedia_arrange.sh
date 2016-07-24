#!/usr/local/bin/

#cat rslist | uniq -d > rslistuniq;

now=$(date +"%Y%m%d");

ls *_vir > vir_list_$now

for k in `cat vir_list*`; do

	echo -----------------------
	echo $k starts. ------------
	for j in `cat *_vir`; do
		python SNPedia_scrape.py $j;

			for i in *out.txt; do
				temp = ${i//out.txt/PMID}
				grep ">PMID"  $i > temp;
				sed -i '' 's/.*PMID/PMID/g' temp;
				sed -i '' "s#</a>] #$(printf '\t')#g" temp;
				sed -i '' "s#</a><a href=\"/index.php/File:OA-icon.png\" class=\"image\"><img alt=\"OA-icon.png\" src=\"https://media.snpedia.com/images/5/5b/OA-icon.png\" width=\"15\" height=\"15\" />#$(printf '\t')#g" temp;
				sed -i '' "s#</a>]#$(printf '\t')#g" temp;
				sed -i -e "s/^/$j$(printf '\t')/" temp;
				rm $i;
				echo $j is good.
			done

		#sed -i '' 's/.*PMID/PMID/g' *PMID*;
		#sed -i '' "s#</a>] #$(printf '\t')#g" *PMID*;
		#sed -i '' "s#</a><a href=\"/index.php/File:OA-icon.png\" class=\"image\"><img alt=\"OA-icon.png\" src=\"https://media.snpedia.com/images/5/5b/OA-icon.png\" width=\"15\" height=\"15\" />#$(printf '\t')#g" *PMID*;
		#sed -i '' "s#</a><a href=\"/index.php/File:OA-icon.png\" class=\"image\"><img alt=\"OA-icon.png\" src=\"https://media.snpedia.com/images/5/5b/OA-icon.png\" width=\"15\" height=\"15\" /> #$(printf '\t')#g" *PMID*;
		#sed -i '' "s#</a>]#$(printf '\t')#g" *PMID*;
		#sed -i -e "s/^/$j$(printf '\t')/" *PMID*;

	done

	cat Rs* >> tempPMIDlist$now;
	sort tempPMIDlist$now > tempPMID$now.sort;
	uniq -d tempPMID$now.sort > tempPMID$now.uniq;
	grep "Rs"  tempPMID$now.uniq > ${k//vir/PMID}_$now.uniq;
	rm temp*;
	rm Rs*;

	echo $k is finished.~~~~~~~~

done

#cat *PMID.combo >> PMIDlist$now;



