import nltk
import sys

# hypothesis = ['i','think','he', 'has', 'blood', 'cancer']
# reference = ['i','think','he', 'has', 'leukemia', 'level3']
# #there may be several references
# BLEUscore = nltk.translate.bleu_score.sentence_bleu([reference], hypothesis, weights=(0.25, 0.25, 0.25, 0.25))
# print BLEUscore

def get_bleuscore(simple,output):
	hypothesis = output.split(" ")
	reference = simple.split(" ")
	#there may be several references
	BLEUscore = nltk.translate.bleu_score.sentence_bleu([reference], hypothesis, weights=(0.25, 0.25, 0.25, 0.25))
	return abs(BLEUscore)


if __name__=="__main__":
	
	file_input = sys.argv[1]

	f = open(file_input,'r')
	line = f.readline()
	n_lines = 0
	total_score = 0
	while(line!=''):
		line = line.split("\t");
		score = get_bleuscore(line[2],line[3])
		total_score += abs(score)
		n_lines += 1
		line = f.readline()
		print n_lines,score,total_score

	print total_score/n_lines