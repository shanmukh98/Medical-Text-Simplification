from readability_score.calculators.fleschkincaid import *
import sys

def get_kincaidscore(complex, simple_gt, simplified):
	readability_simplified = FleschKincaid(simplified, locale='nl_NL')
	readability_simple_gt = FleschKincaid(simple_gt, locale='nl_NL')
	readability_complex = FleschKincaid(complex, locale='nl_NL')
	# print type()
	# return 0
	return readability_complex.min_age,readability_simple_gt.min_age,readability_simplified.min_age

	# return abs(readability_simplified.min_age - readability_simple_gt.min_age)

if __name__=="__main__":
	
	file_input = sys.argv[1]

	f = open(file_input,'r')
	line = f.readline()
	n_lines = 0
	# total_score = 0
	total_complex = 0
	total_simple = 0
	total_simplified = 0

	while(line!=''):
		line = line.split("\t");
		complex, simple, simplified = get_kincaidscore(line[1],line[2],line[3])
		# total_score += abs(score)
		total_complex += complex
		total_simple += simple
		total_simplified += simplified
		n_lines += 1
		line = f.readline()
		print n_lines,complex,simple,simplified

	print "Complex",total_complex*1.0/n_lines
	print "Simple_gt",total_simple*1.0/n_lines
	print "simplified",total_simplified*1.0/n_lines