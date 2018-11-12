import re
import os
import string 
from string import punctuation
translator = string.maketrans(string.punctuation, ' ' * len(string.punctuation))

from get_simplified import simplify

synonyms = ['wordnet','UMLS','all']


f = open('simple-normal.txt','r')
line = f.readline()
cnt = 0
while(line!=''):
	# try:
	line = line.strip()
	line = re.sub(r'[^\x00-\x7F]','',line)
	line = line.lower()
	line = line.translate(translator)
	line = line.split("\t")
	# command = "python2.7 get_simplified.py '"+ line[1] + "'  '"+line[0]+"' "+i+" "+str(j)
	simplify(line[1], line[0], 1, 2, cnt)
	# except:
	# 	pass
	cnt += 1
	print "linenumber-->",cnt
	if(cnt>1001):
		break
	line = f.readline()

# for i in synonyms:
# 	for j in range(2,4,1):
# 		f = open('simple-normal.txt','r')
# 		fout = open("output_normal_simple_simplified_"+i+"_"+str(j)+".txt","w+")
# 		line = f.readline()
# 		cnt = 0
# 		while(line!=''):
# 			try:
# 				line = line.strip()
# 				line = re.sub(r'[^\x00-\x7F]','',line)
# 				line = line.lower()
# 				line = line.translate(translator)
# 				line = line.split("\t")
# 				# command = "python2.7 get_simplified.py '"+ line[1] + "'  '"+line[0]+"' "+i+" "+str(j)
# 				normal, simple, simplified = simplify(line[1], line[0], i, str(j), cnt)
# 				if(normal==0 and simple==0 and simplified==0):
# 					print "------------------------------*****************************-----------------------------"
# 					print "not a medical sentence"
# 				else:
# 					print "------------------------------*****************************-----------------------------"
# 					print "normal------>",normal
# 					print "simple------>",simple
# 					print "simplified-->",simplified
# 					fout.write(str(cnt)+"\t"+normal+"\t"+simple+"\t"+simplified+"\n")
# 				# print command
# 			except:
# 				pass 
# 			cnt += 1
# 			print "linenumber-->",cnt
# 			if(cnt>3):
# 				break
# 			if(cnt%500==0):
# 				print cnt
# 			line = f.readline()
# 		fout.close()