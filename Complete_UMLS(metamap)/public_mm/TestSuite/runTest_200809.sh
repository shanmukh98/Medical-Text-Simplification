#!/bin/sh

announce() {
   echo $1
   echo $1 >> out
}

METAMAP="metamap.TEST -Z 0809"
rm -f out

echo "Start Time: `date`"
echo ""
echo "MetaMap: $METAMAP"

announce "Allow Overmatches:"
$METAMAP -o file8.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Allow Concept Gaps w/ KS Year:"
$METAMAP -g file10.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Prefer Multiple Concepts:"
$METAMAP -Y file9.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Ignore Word Order:"
$METAMAP -i file12.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Allow Concept Gaps w/ Show All Maps:"
$METAMAP -gb file10.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Allow Concept Gaps w/ Show All Maps + Debug5:"
$METAMAP -gb --debug 5 file10.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Allow Concept Gaps w/ Show All Maps + Number the Candidates:"
$METAMAP -gbn file10.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Allow Concept Gaps w/ Show All Maps + Show CUIs:"
$METAMAP -gbI file10.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Allow Concept Gaps w/ Show All Maps + Syntax:"
$METAMAP -gbx file10.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Show All Maps + Threshold=900:"
$METAMAP -br 900 file2.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Show All Maps:"
$METAMAP -b file2.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Normal Processing - Best Mappings Only:"
$METAMAP file0.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Concept Gap:"
$METAMAP -gb file15.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Normal Processing - All Mappings:"
$METAMAP -b file14.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Truncate Candidates Mappings:"
announce "  MetaMap w/o Truncate:"
$METAMAP -b file17.txt tmp > /dev/null
cat tmp >> out
announce "  MetaMap w/ Truncate:"
$METAMAP -bX file17.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "MetaMap -c option (remove candidates list):"
$METAMAP -c file2.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "MetaMap -s option (remove semantic information):"
announce "  MetaMap w/ Semantic Information:"
$METAMAP file2.txt tmp > /dev/null
cat tmp >> out
announce "  MetaMap w/o Semantic Information:"
$METAMAP -s file2.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "MetaMap -m option (remove final mappings list):"
$METAMAP -m file2.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "MetaMap -q option (machine output):"
$METAMAP -q file2.txt tmp > /dev/null
sed -e "s#$METAMAP#MetaMap#g" tmp >> out
announce "========================================================================"

announce "MetaMap -E option (EOT marker):"
$METAMAP -E file2.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Differences:"
$METAMAP -aq file.txt tmp > /dev/null
sed -e "s#$METAMAP#MetaMap#g" tmp >> out
announce "========================================================================"

announce "DifferencesII:"
$METAMAP file1.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "I) head problems & scoring problems:"
$METAMAP -z file3.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "II) head problems & scoring problems:"
$METAMAP -zi file4.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "-qI option (machine output with CUIs displayed):"
$METAMAP -qI file5.txt tmp > /dev/null
sed -e "s#$METAMAP#MetaMap#g" tmp >> out
announce "========================================================================"

announce "-5zb option:"
$METAMAP -zb --debug 5 file6.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "XML with Formatting:"
$METAMAP -% format file5.txt tmp > /dev/null
sed -e "s#$METAMAP#MetaMap#g" tmp >> out
announce "========================================================================"

announce "XML No Formatting:"
$METAMAP -% noformat file5.txt tmp > /dev/null
sed -e "s#$METAMAP#MetaMap#g" tmp >> out
announce "========================================================================"

announce "Non-standard PMID:"
$METAMAP -% noformat file18.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "MMI Fielded Output:"
$METAMAP -N file5.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Quick Composite Phrases:"
$METAMAP -Q file6.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Fielded MMI Output with ignore_word_order:"
$METAMAP -Ni file3.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Exclude Sources:"
$METAMAP -e MSH file3.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

announce "Restrict to Sources and XML:"
$METAMAP -R MSH -% format file3.txt tmp > /dev/null
cat tmp >> out
announce "========================================================================"

echo "Checking for differences between generated and gold standard results"

Gold_DIFF_CNT=`diff out gold.200809 | wc -l`

if [ $Gold_DIFF_CNT -eq '0' ] ; then
  echo "Files are the same"
else
  echo "Files differ"
fi

echo "========================================================================"

echo "End Time: `date`"
