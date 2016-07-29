#!/usr/local/bin/

#cat rslist | uniq -d > rslistuniq;

now=$(date +"%Y%m%d");

ls *_vir > vir_list_$now

for k in `cat vir_list*`; do

	echo -----------------------
	echo $k starts. ------------
	for j in `cat $k`; do
		python SNPedia_scrape.py $j;
		#echo $j-out.txt;
		
		grep "Chromosome</td>" $j-out.txt > $j-Chr;
		grep "Position</td>" $j-out.txt > $j-Pos;
		grep "Gene</td>" $j-out.txt > $j-Gene;
		
		#<tr><td width="90">Gene</td><td><a href="/index.php/Special:FormEdit/Gene/LOC102724058?redlink=1" class="new" title="LOC102724058 (page does not exist)">LOC102724058</a>, <a href="/index.php/SCN1A" title="SCN1A">SCN1A</a></td></tr>
		cat $j-Gene | tr "\">" '\n' > $j-Gene-temp
		grep "<\/a" $j-Gene-temp > $j-Gene
		sed -i '' "s#<\/a#$(printf '\t')#g" $j-Gene;

		for l in "cat $j-Gene"; do
			python SNPedia_scrape.py $l
			grep "<strong class=\"selflink\">" $l-out.txt >> $j-Info
			sed -i '' "s#<strong class=\"selflink\">#$(printf '\t')#g" $j-Info;
			sed -i '' "s#<strong class=\"selflink\">#$(printf '\t')#g" $j-Info;
			#<p>Mutations in the <strong class="selflink">SCN1A</strong> gene have been associated with <a href="/index.php/Severe_myoclonic_epilepsy_in_infancy" title="Severe myoclonic epilepsy in infancy">Severe myoclonic epilepsy in infancy</a> (SMEI) and <a href="/index.php?title=Dravet_syndrome&amp;action=edit&amp;redlink=1" class="new" title="Dravet syndrome (page does not exist)">Dravet syndrome</a>, forms of <a href="/index.php/Epilepsy" title="Epilepsy">epilepsy</a>. <a rel="nofollow" class="external text" href="http://www.washingtonpost.com/national/health-science/medical-mysteries-seizures-hit-baby-girl-soon-after-she-had-routine-shots/2011/12/21/gIQAfkbAdQ_story_2.html">Washington Post article</a> <a rel="nofollow" class="external autonumber" href="http://dravet.org/">[1]</a> <a rel="nofollow" class="external text" href="http://www.ncbi.nlm.nih.gov/books/NBK1318/">NCBI Bookshelf</a></p>

echo "<p>Mutations in the <strong class=\"selflink\">SCN1A</strong> gene have been associated with <a href=\"/index.php/Severe_myoclonic_epilepsy_in_infancy\" title=\"Severe myoclonic epilepsy in infancy\">Severe myoclonic epilepsy in infancy</a> (SMEI) and <a href=\"/index.php?title=Dravet_syndrome&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"Dravet syndrome (page does not exist)\">Dravet syndrome</a>, forms of <a href=\"/index.php/Epilepsy\" title=\"Epilepsy\">epilepsy</a>. <a rel=\"nofollow\" class=\"external text\" href=\"http://www.washingtonpost.com/national/health-science/medical-mysteries-seizures-hit-baby-girl-soon-after-she-had-routine-shots/2011/12/21/gIQAfkbAdQ_story_2.html\">Washington Post article</a> <a rel=\"nofollow\" class=\"external autonumber\" href=\"http://dravet.org/\">[1]</a> <a rel=\"nofollow\" class=\"external text\" href=\"http://www.ncbi.nlm.nih.gov/books/NBK1318/\">NCBI Bookshelf</a></p>" | tr "<a" '\n'


			rm $l-out.txt
		done

		cat $j-Gene | tr '\n' "," > $j-Gene-all

    	#<tr><td width="90">Chromosome</td><td>2</td></tr>
		sed -i '' "s#<tr><td width="90">Chromosome</td><td>#$(printf '\t')#g" $j-Chr;
		sed -i '' "s#</td></tr>#$(printf '\t')#g" $j-Chr;

		#<tr><td width="90">Position</td><td>166036278</td></tr>
		sed -i '' "s#<tr><td width="90">Position</td><td>#$(printf '\t')#g" $j-Pos;
		sed -i '' "s#</td></tr>#$(printf '\t')#g" $j-Pos;

		grep ">PMID"  $j-out.txt > $j-PMID;
		sed -i '' 's/.*PMID/PMID/g' $j-PMID;
		sed -i '' "s#</a>] #$(printf '\t')#g" $j-PMID;

		sed -i '' "s#</a><a href=\"/index.php/File:OA-icon.png\" class=\"image\"><img alt=\"OA-icon.png\" src=\"https://media.snpedia.com/images/5/5b/OA-icon.png\" width=\"15\" height=\"15\" />#$(printf '\t')#g" $j-PMID;
		sed -i '' "s#</a>]#$(printf '\t')#g" $j-PMID;

		sed -i -e "s/^/$j$(printf '\t')$(cat $j-Chr)$(cat '\t')$(cat $j-Pos)$(cat '\t')$(cat $j-Gene-all)$(printf '\t')$(cat $j-Info)/" $j-PMID;
		
		sed -i -e "s/$(printf '\t')$(printf '\t')/$(printf '\t')/" $j-PMID;
		
		rm $j-out.txt;
		
	#echo $j is good.
		
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



