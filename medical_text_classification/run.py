import os
import subprocess
import re

def get_symantics(text):
	print "entered",text
	proc = subprocess.Popen(["./complete_umls/public_mm/bin/testapi.sh "+text], stdout=subprocess.PIPE, shell=True)
	(umlsoutput, err) = proc.communicate()
	# print "---------------program output:---------------\n", umlsoutput
	# umlsoutput = os.system("./complete_umls/public_mm/bin/testapi.sh "+text)
	output = []
	for line in umlsoutput.split("\n"):
		if "Semantic Types" in line:
			# print line
			line = line.strip()
			line = line.split(":")
			# print line[1]
			line = re.sub(r'\[(.*)\]',r'\1',line[1])
			line = re.sub(' ','',line)
			# print line
			output.append(line)
	print "----------output----------------"
	print output
	return output


if __name__=="__main__":
	
	text = "akhil ralla  a disease symptom natio football hello"
	symantics = get_symantics(text);
	# print symantics