from rouge import Rouge
import sys

def get_rougescore(simple_gt, simplified):
	rouge = Rouge()
	ans = rouge.get_scores(simplified,simple_gt)
	# print ans[0]
	# return ans
	return ans[0]['rouge-l']['p'], ans[0]['rouge-l']['r'], ans[0]['rouge-l']['f']


if __name__=="__main__":
	
	file_input = sys.argv[1]

	f = open(file_input,'r')
	line = f.readline()
	n_lines = 0
	total_precision = 0
	total_recall = 0
	total_f_score = 0
	while(line!=''):
		line = line.split("\t");
		precision, recall, fscore = get_rougescore(line[2],line[3])
		total_precision += precision
		total_recall += recall
		total_f_score += fscore
		# total_score += abs(score)
		n_lines += 1
		line = f.readline()
		print n_lines,precision,recall,total_precision,total_recall

	print "precision:",total_precision/n_lines
	print "recall:",total_recall/n_lines
	print "F-score:",total_f_score/n_lines