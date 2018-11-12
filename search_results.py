import requests
import time
import random
 
from bs4 import BeautifulSoup
#sudo apt-get install python-bs4   ---> installation command
 
#if you are getting some error in bs4 module use following commands
# pip install --upgrade beautifulsoup4
# pip install --upgrade html5lib
 
#if still not working try this
# sudo   pip install --upgrade html5lib==1.0b8
 
 
import argparse
 
# parser = argparse.ArgumentParser(description='Get Google Count.')
# parser.add_argument('word', help='word to count')
# args = parser.parse_args()
 
# r = requests.get('http://www.google.com/search',
#                  params={'q':'"'+args.word+'"',
#                          "tbs":"li:1"}
#                 )
 
# soup = BeautifulSoup(r.text,'html.parser')
# print (soup.find('div',{'id':'resultStats'}).text)

def get_best_word_search_results(words):
	maxi = 0
	bestword = list(words)[0]
	for word in words:
		time.sleep(random.randint(1,100)/200.0)
		# print "word",word, 
		r = requests.get('http://www.google.com/search',
		                 params={'q':'"'+word+'"',
		                         "tbs":"li:1"}
		                )
		soup = BeautifulSoup(r.text,'html.parser')
		try:
			output = soup.find('div',{'id':'resultStats'}).text 
		# soup = BeautifulSoup(r.text,'html.parser')
		# output = soup.find('div',{'id':'resultStats'}).text
			# print "output",output
		# if output=="None":
		# 	continue
		# else:
		# 	output = output.text
			count = output.split(" ")[1]
			split = count.split(",")
			count = "".join(split)
			count = int(count)
			if count>maxi:
				maxi = count
				bestword = word
			print (word,count)

		except:
			pass
	return bestword
	