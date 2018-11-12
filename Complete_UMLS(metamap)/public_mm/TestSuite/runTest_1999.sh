#!/bin/sh

#BASEDIR=/home/wrogers/Projects/public_mm_dist/test/linux/public_mm
#BASEDIR=/nfsvol/nls
BASEDIR=/home/wrogers
METAMAP="$BASEDIR/bin/metamap99"
rm -f out

echo "Start Time: `date`"
echo ""
echo "MetaMap: $METAMAP"

echo "Allow Overmatches:"
echo "Allow Overmatches:" >> out
$METAMAP -o file8.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ KS Year:"
echo "Allow Concept Gaps w/ KS Year:" >> out
$METAMAP -g file10.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Prefer Multiple Concepts:"
echo "Prefer Multiple Concepts:" >> out
$METAMAP -Y file9.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Ignore Word Order:"
echo "Ignore Word Order:" >> out
$METAMAP -i file12.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps:"
echo "Allow Concept Gaps w/ Show All Maps:" >> out
$METAMAP -gb file10.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps + Debug5:"
echo "Allow Concept Gaps w/ Show All Maps + Debug5:" >> out
$METAMAP -gb5 file10.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps + Number the Candidates:"
echo "Allow Concept Gaps w/ Show All Maps + Number the Candidates:" >> out
$METAMAP -gbn file10.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps + Show CUIs:"
echo "Allow Concept Gaps w/ Show All Maps + Show CUIs:" >> out
$METAMAP -gbI file10.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Allow Concept Gaps w/ Show All Maps + Syntax:"
echo "Allow Concept Gaps w/ Show All Maps + Syntax:" >> out
$METAMAP -gbx file10.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Show All Maps + Threshold=900:"
echo "Show All Maps + Threshold=900:" >> out
$METAMAP -br 900 file2.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Show All Maps:"
echo "Show All Maps:" >> out
$METAMAP -b file2.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Normal Processing - Best Mappings Only:"
echo "Normal Processing - Best Mappings Only:" >> out
$METAMAP file0.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Concept Gap:"
echo "Concept Gap:" >> out
$METAMAP -gb file15.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Normal Processing - All Mappings:"
echo "Normal Processing - All Mappings:" >> out
$METAMAP -b file14.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Truncate Candidates Mappings:"
echo "Truncate Candidates Mappings:" >> out
echo "  MetaMap w/o Truncate:"
echo "  MetaMap w/o Truncate:" >> out
$METAMAP -b file17.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "  MetaMap w/ Truncate:"
echo "  MetaMap w/ Truncate:" >> out
$METAMAP -bX file17.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "MetaMap -c option (remove candidates list):"
echo "MetaMap -c option (remove candidates list):" >> out
$METAMAP -c file2.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "MetaMap -s option (remove semantic information):"
echo "MetaMap -s option (remove semantic information):" >> out
echo "  MetaMap w/ Semantic Information:"
echo "  MetaMap w/ Semantic Information:" >> out
$METAMAP file2.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "  MetaMap w/o Semantic Information:"
echo "  MetaMap w/o Semantic Information:" >> out
$METAMAP -s file2.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "MetaMap -m option (remove final mappings list):"
echo "MetaMap -m option (remove final mappings list):" >> out
$METAMAP -m file2.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "MetaMap -q option (machine output):"
echo "MetaMap -q option (machine output):" >> out
$METAMAP -q file2.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "MetaMap -E option (EOT marker):"
echo "MetaMap -E option (EOT marker):" >> out
$METAMAP -E file2.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "Differences:"
echo "Differences:" >> out
$METAMAP -aq file.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "DifferencesII:"
echo "DifferencesII:" >> out
$METAMAP file1.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "I) head problems & scoring problems:"
echo "I) head problems & scoring problems:" >> out
$METAMAP -z file3.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "II) head problems & scoring problems:"
echo "II) head problems & scoring problems:" >> out
$METAMAP -zi file4.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "-qI option (machine output with CUIs displayed):"
echo "-qI option (machine output with CUIs displayed):" >> out
$METAMAP -qI file5.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"

echo "--debug 5 -zb option:"
echo "--debug 5 -zb option:" >> out
$METAMAP --debug 5 -zb file6.txt tmp > /dev/null
cat tmp >> out
rm tmp
echo "========================================================================"
echo "Checking for differences between generated and gold standard results"

Gold_DIFF_CNT=`diff out gold | wc -l`

if [ $Gold_DIFF_CNT -eq '0' ] ; then
  echo "Files are the same"
else
  echo "Files differ"
fi

echo "========================================================================"

echo "End Time: `date`"
