#!/bin/sh

METAMAP="/nfsvol/nls/bin/metamap08"
rm -f gold

echo "Start Time: `date`"
echo ""
echo "MetaMap: $METAMAP"

echo "Allow Overmatches:"
echo "Allow Overmatches:" >> gold
$METAMAP -o file8.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ KS Year:"
echo "Allow Concept Gaps w/ KS Year:" >> gold
$METAMAP -g file10.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Prefer Multiple Concepts:"
echo "Prefer Multiple Concepts:" >> gold
$METAMAP -Y file9.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Ignore Word Order:"
echo "Ignore Word Order:" >> gold
$METAMAP -i file12.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps:"
echo "Allow Concept Gaps w/ Show All Maps:" >> gold
$METAMAP -gb file10.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps + Debug5:"
echo "Allow Concept Gaps w/ Show All Maps + Debug5:" >> gold
$METAMAP -gb5 file10.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps + Number the Candidates:"
echo "Allow Concept Gaps w/ Show All Maps + Number the Candidates:" >> gold
$METAMAP -gbn file10.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps + Show CUIs:"
echo "Allow Concept Gaps w/ Show All Maps + Show CUIs:" >> gold
$METAMAP -gbI file10.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps + Syntax:"
echo "Allow Concept Gaps w/ Show All Maps + Syntax:" >> gold
$METAMAP -gbx file10.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Show All Maps + Threshold=900:"
echo "Show All Maps + Threshold=900:" >> gold
$METAMAP -br 900 file2.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Show All Maps:"
echo "Show All Maps:" >> gold
$METAMAP -b file2.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Normal Processing - Best Mappings Only:"
echo "Normal Processing - Best Mappings Only:" >> gold
$METAMAP file0.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Concept Gap:"
echo "Concept Gap:" >> gold
$METAMAP -gb file15.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Normal Processing - All Mappings:"
echo "Normal Processing - All Mappings:" >> gold
$METAMAP -b file14.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Truncate Candidates Mappings:"
echo "Truncate Candidates Mappings:" >> gold
echo "  MetaMap w/o Truncate:"
echo "  MetaMap w/o Truncate:" >> gold
$METAMAP -b file17.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "  MetaMap w/ Truncate:"
echo "  MetaMap w/ Truncate:" >> gold
$METAMAP -bX file17.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "MetaMap -c option (remove candidates list):"
echo "MetaMap -c option (remove candidates list):" >> gold
$METAMAP -c file2.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "MetaMap -s option (remove semantic information):"
echo "MetaMap -s option (remove semantic information):" >> gold
echo "  MetaMap w/ Semantic Information:"
echo "  MetaMap w/ Semantic Information:" >> gold
$METAMAP file2.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "  MetaMap w/o Semantic Information:"
echo "  MetaMap w/o Semantic Information:" >> gold
$METAMAP -s file2.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "MetaMap -m option (remove final mappings list):"
echo "MetaMap -m option (remove final mappings list):" >> gold
$METAMAP -m file2.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "MetaMap -q option (machine output):"
echo "MetaMap -q option (machine output):" >> gold
$METAMAP -q file2.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "MetaMap -E option (EOT marker):"
echo "MetaMap -E option (EOT marker):" >> gold
$METAMAP -E file2.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "Differences:"
echo "Differences:" >> gold
$METAMAP -aq file.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "DifferencesII:"
echo "DifferencesII:" >> gold
$METAMAP file1.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "I) head problems & scoring problems:"
echo "I) head problems & scoring problems:" >> gold
$METAMAP -z file3.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "II) head problems & scoring problems:"
echo "II) head problems & scoring problems:" >> gold
$METAMAP -zi file4.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "-qI option (machine output with CUIs displayed):"
echo "-qI option (machine output with CUIs displayed):" >> gold
$METAMAP -qI file5.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "-5zb option:"
echo "-5zb option:" >> gold
$METAMAP -5zb file6.txt tmp > /dev/null
cat tmp >> gold
rm tmp
echo "========================================================================"

echo "End Time: `date`"
