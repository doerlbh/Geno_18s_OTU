#!/usr/local/bin/
# Baihan Lin
# July 2016


for k in new_vir_list_*; do
	echo -----------------------
	echo $k starts. -----------
	echo virus ${k:13}

	sort $k > $k.sort;
	uniq -d $k.sort > $k.uniq;

	for j in `cat $k.uniq`; do
		python SNPedia_scrape.py $j;
		#echo $j-out.txt;
		
		grep "Chromosome</td>" $j-out.txt > $j-Chr;
		grep "Position</td>" $j-out.txt > $j-Pos;
		grep "Gene</td>" $j-out.txt > $j-Gene;
		
		#<tr><td width="90">Gene</td><td><a href="/index.php/Special:FormEdit/Gene/LOC102724058?redlink=1" class="new" title="LOC102724058 (page does not exist)">LOC102724058</a>, <a href="/index.php/SCN1A" title="SCN1A">SCN1A</a></td></tr>
		cat $j-Gene | tr "\">" '\n' > $j-Gene-temp
		grep "<\/a" $j-Gene-temp > $j-Gene
		sed -i '' "s#<\/a##g" $j-Gene;

		for l in `cat $j-Gene`; do
			echo gene info > $j-Info
			python SNPedia_scrape.py $l || echo no further info on $l

			grep "<strong class=\"selflink\">" $l-out.txt >> $j-Info
			sed -i '' "s#<strong class=\"selflink\">##g" $j-Info;
			sed -i '' "s#</strong>##g" $j-Info;
			sed -i '' "s#<p>##g" $j-Info;
			sed -i '' "s#</p>##g" $j-Info;

			#<p>Mutations in the <strong class="selflink">SCN1A</strong> gene have been associated with <a href="/index.php/Severe_myoclonic_epilepsy_in_infancy" title="Severe myoclonic epilepsy in infancy">Severe myoclonic epilepsy in infancy</a> (SMEI) and <a href="/index.php?title=Dravet_syndrome&amp;action=edit&amp;redlink=1" class="new" title="Dravet syndrome (page does not exist)">Dravet syndrome</a>, forms of <a href="/index.php/Epilepsy" title="Epilepsy">epilepsy</a>. <a rel="nofollow" class="external text" href="http://www.washingtonpost.com/national/health-science/medical-mysteries-seizures-hit-baby-girl-soon-after-she-had-routine-shots/2011/12/21/gIQAfkbAdQ_story_2.html">Washington Post article</a> <a rel="nofollow" class="external autonumber" href="http://dravet.org/">[1]</a> <a rel="nofollow" class="external text" href="http://www.ncbi.nlm.nih.gov/books/NBK1318/">NCBI Bookshelf</a></p>

			#echo "Mutations in the SCN1A< gene have been associated with <a href=\"/index.php/Severe_myoclonic_epilepsy_in_infancy\" title=\"Severe myoclonic epilepsy in infancy\">Severe myoclonic epilepsy in infancy</a> (SMEI) and <a href=\"/index.php?title=Dravet_syndrome&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"Dravet syndrome (page does not exist)\">Dravet syndrome</a>, forms of <a href=\"/index.php/Epilepsy\" title=\"Epilepsy\">epilepsy</a>. <a rel=\"nofollow\" class=\"external text\" href=\"http://www.washingtonpost.com/national/health-science/medical-mysteries-seizures-hit-baby-girl-soon-after-she-had-routine-shots/2011/12/21/gIQAfkbAdQ_story_2.html\">Washington Post article</a> <a rel=\"nofollow\" class=\"external autonumber\" href=\"http://dravet.org/\">[1]</a> <a rel=\"nofollow\" class=\"external text\" href=\"http://www.ncbi.nlm.nih.gov/books/NBK1318/\">NCBI Bookshelf</a>" | tr -s '<\a href' '\n'

			rm $l-out.txt
		done

		cat $j-Gene | tr '\n' "," > $j-Gene-all
		sed -i '' "s/$(printf '\t')//g" $j-Gene-all;

    	#<tr><td width="90">Chromosome</td><td>2</td></tr>
		sed -i '' "s#<tr><td width=\"90\">Chromosome</td><td>#$(printf '\t')#g" $j-Chr;
		sed -i '' "s#</td></tr>##g" $j-Chr;

		#<tr><td width="90">Position</td><td>166036278</td></tr>
		sed -i '' "s#<tr><td width=\"90\">Position</td><td>#$(printf '\t')#g" $j-Pos;
		sed -i '' "s#</td></tr>##g" $j-Pos;

		grep ">PMID"  $j-out.txt > $j-PMID;
		sed -i '' 's/.*PMID/PMID/g' $j-PMID;
		sed -i '' "s#</a>] #$(printf '\t')#g" $j-PMID;

		sed -i '' "s#</a><a href=\"/index.php/File:OA-icon.png\" class=\"image\"><img alt=\"OA-icon.png\" src=\"https://media.snpedia.com/images/5/5b/OA-icon.png\" width=\"15\" height=\"15\" />#$(printf '\t')#g" $j-PMID;
		sed -i '' "s#</a>]#$(printf '\t')#g" $j-PMID;

		#sed -i -e "s/^/$j$(printf '\t')$(printf ${k:13})$(printf '\t')$(cat $j-Chr)$(printf '\t')$(cat $j-Pos)$(printf '\t')$(cat $j-Gene-all)$(printf '\t')$(cat $j-Info)/" $j-PMID;
		sed -i '' -e "s/^/$j$(printf '\t')${k:13}$(printf '\t')$(cat $j-Chr)$(printf '\t')$(cat $j-Pos)$(printf '\t')$(cat $j-Gene-all)$(printf '\t')$(cat $j-Info)$(printf '\t')/" $j-PMID;
		
		sed -i '' "s/$(printf '\t')$(printf '\t')/$(printf '\t')/g" $j-PMID;
		
		sed -i '' "s/$(printf '\t')$(printf '\t')/$(printf '\t')/g" $j-PMID;

		rm $j-out.txt;
		
	#echo $j is good.
		
	done

	cat rs*PMID >> tempPMIDlist;
	cat Rs*PMID >> tempPMIDlist;
	sort tempPMIDlist > tempPMID.sort;
	uniq -d tempPMID.sort > tempPMID.uniq;
	grep "Rs"  tempPMID.uniq > ${k//new_vir_list/all_info}.list;
	grep "rs"  tempPMID.uniq >> ${k//new_vir_list/all_info}.list;
	rm *temp*;
	rm rs*;
	rm Rs*;
	rm *sort
	rm *uniq
	rm *out.txt

	echo $k is finished.~~~~~~~~

done

#cat *PMID.combo >> PMIDlist$now;



