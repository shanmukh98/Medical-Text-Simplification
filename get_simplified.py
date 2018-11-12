from pymetamap import MetaMap
import re
import string 
from string import punctuation
from readability_score.calculators.fleschkincaid import *
from rouge import Rouge
import sys

from synonyms import get_synonyms
from search_results import get_best_word_search_results
from bleu_score import get_bleuscore
from google_ngrams import get_best_word_google_ngrams
from splitter_best_word import  get_best_word_splitter 


translator = string.maketrans(string.punctuation, ' ' * len(string.punctuation))

synonyms1 = ['wordnet','UMLS','all']

# semantics = []

medical_semantics = ["fndg","patf","antb","clna","clnd","diap","drdd","dsyn","emod","gngm","horm","imft","inpo","medd","mobd","podg","tisu","virs","vita","neop"]

def is_medical(semantics):
	for i in semantics:
		if i in medical_semantics:
			return True
	return False

def get_attributes(texts):
	# semantics
	phrases = set()
	prefered_names = {}
	mm = MetaMap.get_instance('/home/rallaakhil/IRE/project/complete_umls/public_mm/bin/metamap16')
	concepts,error = mm.extract_concepts(texts,list(range(0,len(texts))))
	for concept in concepts:

		# # print concept
		semantic_types = concept.semtypes
		semantic_types = re.sub(r'\[(.*)\]',r'\1',semantic_types)
		semantic_types = list(semantic_types.split(" "))
		score = float(concept.score)
		trigger = concept.trigger
		phrase = trigger.split("-")[3]
		phrase = re.sub('"','',phrase)
		POS = trigger.split("-")[4]
		prefered_name = concept.preferred_name
		prefered_name = prefered_name.split(":")[0]
		prefered_name = prefered_name.lower() 
		# # print type(semantic_types),type(score),type(trigger),type(prefered_name)

		# # print semantic_types, score, phrase, POS, prefered_name
		flag = False
		for i in semantic_types:
			if i in medical_semantics:
				flag = True
				break

		if flag and POS=='noun' and score>0:
			phrases.add(phrase)
			if phrase in prefered_names:
				# # print "helloooooooooo->",phrase,prefered_name
				prefered_names[str(phrase)].append(str(prefered_name))
			else:
				# # print "helloooooooooo->",phrase,prefered_name
				prefered_names[str(phrase)] = []
				prefered_names[str(phrase)].append(str(prefered_name))


		# for i in semantic_types:
			# # print "hello",i
 		# score = conceptMMI

 	# print "phrases-->",phrases
 	# print "preferedname-->",prefered_names
	return phrases,prefered_names
	# 	a = str(concept)
	# 	a = re.sub(r'\((.*)\)',r'\1',a)
	# 	a = re.sub(' ','',a)
	# 	# split = a.split(",")
	# 	concept_id = 0
	# 	symnatic_type = ''
	# 	for i in a.split(","):
	# 		if "index" in i:
	# 			temp_var = i.split("=")[1]
	# 			temp_var = re.sub("'","",temp_var)
	# 			concept_id = int(temp_var)
	# 		if "semtypes" in i:
	# 			x = i.split("=")[1]
	# 			line = re.sub(r'\[(.*)\]',r'\1',x)
	# 			semantic_type = re.sub("'","",line) 
	# 	semantics[concept_id].add(semantic_type)
	# # print "semantics-->",semantics[:1000]

def get_cliner_attributes(line_num):
	f = open("./Cliner_outputs/ex_doc_4.con",'r')
	line = f.readline()
	phrases = set()
	prefered_names = {}
	while(line!=''):
		line = line.split('"')
		num = int((line[2].split(":"))[0])
		# print line_num,num
		if(num==line_num):
			temp_phr = line[1]
			phrases.add(temp_phr)
		line = f.readline()
	return phrases,prefered_names

# if __name__=="__main__":
def simplify(input_text, simple_text, synonym_finder, best_synonym_finder, cnt):
	
	# input_text = "i think he has leukemia syndrome city"
	# simple_text = "I think he has blood cancer city"
	# input_text = sys.argv[1]
	# simple_text = sys.argv[2]
	# print "input_text",input_text
	# print "simple_text",simple_text
	# input_text = raw_input("Give normal sring input:")
	# simple_text = raw_input("Give simple sring input:")
	final_text = input_text
	text = final_text
	text = text.strip()
	text = re.sub(r'[^\x00-\x7F]',' ',text)
	text = text.lower()
	text = text.translate(translator)

	temp1 = []
	temp1.append(text)

	# phrases, prefered_names = get_attributes(temp1)
	phrases, prefered_names = get_cliner_attributes(cnt+1)
	print "line number",cnt+1
	# print "input_text",input_text
	print "phrases",phrases

	if(len(phrases)==0):
		print "not a medical sentence"
		return
		# exit(0)
		# return 0,0,0

		# MAIN
	# for phrase in phrases:
	# 	if (phrase not in final_text):
	# 		continue
	# 	synonyms = get_synonyms(phrase,[synonym_finder])
	# 	if phrase in prefered_names:
	# 		synonyms.extend(prefered_names[phrase])
	# 	synonyms = set(synonyms)
	# 	synonyms.add(phrase)
	# 	# print "phrase-->",phrase
	# 	# print "synonyms-->",synonyms
	# 	best_synonym = ''
	# 	if(best_synonym_finder=='1'):
	# 		best_synonym =  get_best_word_search_results(synonyms)
	# 	elif(best_synonym_finder=='2'):
	# 		best_synonym =  get_best_word_google_ngrams(synonyms)
	# 	elif(best_synonym_finder=='3'):
	# 		best_synonym =  get_best_word_splitter(synonyms)
	# 	# print "phrase-->",phrase
	# 	# print "best_synonym",best_synonym
	# 	final_text = re.sub(phrase,best_synonym,final_text)

	for i in synonyms1:
		for j in range(2,4,1):
			fout = open("output_cliner_normal_simple_simplified_"+i+"_"+str(j)+".txt","a+")
			final_text = input_text
			for phrase in phrases:
				if (phrase not in final_text):
					continue
				synonyms = get_synonyms(phrase,[i])
				if phrase in prefered_names:
					synonyms.extend(prefered_names[phrase])
				synonyms = set(synonyms)
				synonyms.add(phrase)
				print "phrase-->",phrase
				print "synonyms-->",synonyms
				best_synonym = ''
				if(j==1):
					best_synonym =  get_best_word_search_results(synonyms)
				elif(j==2):
					best_synonym =  get_best_word_google_ngrams(synonyms)
				elif(j==3):
					best_synonym =  get_best_word_splitter(synonyms)
				print "phrase-->",phrase
				print "best_synonym",best_synonym
				final_text = re.sub(phrase,best_synonym,final_text)
			# print "-----------------------------------------**********************************---------------------------"
			print "synonym,ranking--->",i,j
			print "normal------>",input_text
			print "simple------>",simple_text
			print "simplified-->",final_text
			fout.write(str(cnt)+"\t"+input_text+"\t"+simple_text+"\t"+final_text+"\n")
			fout.close()



	# readability_output = FleschKincaid(final_text, locale='nl_NL')
	# readability_simple = FleschKincaid(simple_text, locale='nl_NL')
	# readability_normal = FleschKincaid(input_text, locale='nl_NL')
	# rouge = Rouge()
	# # print "normal------------->",input_text
	# # print "simple------------->",simple_text
	# # print "output------------->",final_text
	# return input_text, simple_text, final_text
	# # print "-------Metrics-------"
	# # print "bleuscore-->",get_bleuscore(simple_text,final_text)
	# # print "readability Score(Age)--> normal",readability_normal.min_age," simple",readability_simple.min_age," simplified ",readability_output.min_age
	# # print "Rouge_L-->",rouge.get_scores(final_text,simple_text)
	# get_semantics(temp2)

	
	# cunt = 0

	# for i in range(len(semantics)):
	# 	temp_semantics = list(semantics[i])
	# 	# print i,temp_semantics
	# 	foutsym1.write(inp1[i].strip()+"\t"+str(temp_semantics)+"\n")
	# 	foutsym2.write(inp2[i].strip()+"\t"+str(temp_semantics)+"\n")
	# 	test_bool = is_medical(temp_semantics)
	# 	if(test_bool):
	# 		# print "yes--->",inp1[i].strip()
	# 		fout1.write(inp1[i])
	# 		fout2.write(inp2[i])
	# 	else:
	# 		# print "noo--->",inp1[i].strip()
	# 	# cunt += 1
	# 	# if(cunt>10):
	# 	# 	break



