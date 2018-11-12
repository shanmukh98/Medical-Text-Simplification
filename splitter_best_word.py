import splitter

def get_best_word_splitter(words):
	best_word = ''
	maxi = -1
	for word in words:
		a = splitter.split(word)
		print "word",word,len(a),a
		if(len(a)>maxi):
			maxi = len(a)
			best_word = word
	return best_word