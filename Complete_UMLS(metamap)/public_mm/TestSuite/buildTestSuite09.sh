#!/bin/sh

RESULTFILE="gold"
METAMAP="/nfsvol/nls/bin/metamap0809"
rm -f $RESULTFILE

echo "Start Time: `date`"
echo ""
echo "MetaMap: $METAMAP"

echo "Allow Overmatches:"
echo "Allow Overmatches:" >> $RESULTFILE
$METAMAP -o file8.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ KS Year:"
echo "Allow Concept Gaps w/ KS Year:" >> $RESULTFILE
$METAMAP -g file10.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Prefer Multiple Concepts:"
echo "Prefer Multiple Concepts:" >> $RESULTFILE
$METAMAP -Y file9.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Ignore Word Order:"
echo "Ignore Word Order:" >> $RESULTFILE
$METAMAP -i file12.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps:"
echo "Allow Concept Gaps w/ Show All Maps:" >> $RESULTFILE
$METAMAP -gb file10.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps + Debug5:"
echo "Allow Concept Gaps w/ Show All Maps + Debug5:" >> $RESULTFILE
$METAMAP -gb --debug 5 file10.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps + Number the Candidates:"
echo "Allow Concept Gaps w/ Show All Maps + Number the Candidates:" >> $RESULTFILE
$METAMAP -gbn file10.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps + Show CUIs:"
echo "Allow Concept Gaps w/ Show All Maps + Show CUIs:" >> $RESULTFILE
$METAMAP -gbI file10.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps + Syntax:"
echo "Allow Concept Gaps w/ Show All Maps + Syntax:" >> $RESULTFILE
$METAMAP -gbx file10.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Show All Maps + Threshold=900:"
echo "Show All Maps + Threshold=900:" >> $RESULTFILE
$METAMAP -br 900 file2.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Show All Maps:"
echo "Show All Maps:" >> $RESULTFILE
$METAMAP -b file2.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Normal Processing - Best Mappings Only:"
echo "Normal Processing - Best Mappings Only:" >> $RESULTFILE
$METAMAP file0.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Concept Gap:"
echo "Concept Gap:" >> $RESULTFILE
$METAMAP -gb file15.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Normal Processing - All Mappings:"
echo "Normal Processing - All Mappings:" >> $RESULTFILE
$METAMAP -b file14.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Truncate Candidates Mappings:"
echo "Truncate Candidates Mappings:" >> $RESULTFILE
echo "  MetaMap w/o Truncate:"
echo "  MetaMap w/o Truncate:" >> $RESULTFILE
$METAMAP -b file17.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "  MetaMap w/ Truncate:"
echo "  MetaMap w/ Truncate:" >> $RESULTFILE
$METAMAP -bX file17.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "MetaMap -c option (remove candidates list):"
echo "MetaMap -c option (remove candidates list):" >> $RESULTFILE
$METAMAP -c file2.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "MetaMap -s option (remove semantic information):"
echo "MetaMap -s option (remove semantic information):" >> $RESULTFILE
echo "  MetaMap w/ Semantic Information:"
echo "  MetaMap w/ Semantic Information:" >> $RESULTFILE
$METAMAP file2.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "  MetaMap w/o Semantic Information:"
echo "  MetaMap w/o Semantic Information:" >> $RESULTFILE
$METAMAP -s file2.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "MetaMap -m option (remove final mappings list):"
echo "MetaMap -m option (remove final mappings list):" >> $RESULTFILE
$METAMAP -m file2.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "MetaMap -q option (machine output):"
echo "MetaMap -q option (machine output):" >> $RESULTFILE
$METAMAP -q file2.txt tmp > /dev/null
cat tmp | sed -e "s#$METAMAP#MetaMap#g" >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "MetaMap -E option (EOT marker):"
echo "MetaMap -E option (EOT marker):" >> $RESULTFILE
$METAMAP -E file2.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Differences:"
echo "Differences:" >> $RESULTFILE
$METAMAP -aq file.txt tmp > /dev/null
cat tmp | sed -e "s#$METAMAP#MetaMap#g" >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "DifferencesII:"
echo "DifferencesII:" >> $RESULTFILE
$METAMAP file1.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "I) head problems & scoring problems:"
echo "I) head problems & scoring problems:" >> $RESULTFILE
$METAMAP -z file3.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "II) head problems & scoring problems:"
echo "II) head problems & scoring problems:" >> $RESULTFILE
$METAMAP -zi file4.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "-qI option (machine output with CUIs displayed):"
echo "-qI option (machine output with CUIs displayed):" >> $RESULTFILE
$METAMAP -qI file5.txt tmp > /dev/null
cat tmp | sed -e "s#$METAMAP#MetaMap#g" >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "-5zb option:"
echo "-5zb option:" >> $RESULTFILE
$METAMAP -zb --debug 5 file6.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "XML with Formatting:"
echo "XML with Formatting:" >> $RESULTFILE
$METAMAP -% format file5.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "XML No Formatting:"
echo "XML No Formatting:" >> $RESULTFILE
$METAMAP -% noformat file5.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "Non-standard PMID:"
echo "Non-standard PMID:" >> $RESULTFILE
$METAMAP -% noformat file18.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "MMI Fielded Output:"
echo "MMI Fielded Output:" >> $RESULTFILE
$METAMAP -N file5.txt tmp > /dev/null
cat tmp >> $RESULTFILE
rm tmp
echo "========================================================================"

echo "End Time: `date`"
