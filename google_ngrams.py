#!/usr/bin/env python

# from __future__ import print_function
import phrasefinder as pf

def google_ngrams(query=""):
    """
    Performs a simple request and prints out the result.
    """

    # Set up your query.
    # query = 'blood cancer'

    # Optional: set the maximum number of phrases to return.
    options = pf.SearchOptions()
    options.topk = 10

    # Send the request.
    try:
        result = pf.search(pf.Corpus.AMERICAN_ENGLISH, query, options)



        if result.error_message:
            print('Request was not successful: {}'.format(result.error_message))
            return
        score = 0
        # Print phrases line by line.
        for phrase in result.phrases:
            score += phrase.match_count
            # print(phrase.match_count,phrase.volume_count, end="")

            # for token in phrase.tokens:
            #     print(" {}".format(token.text), end="")
            # print()
        return score

    except Exception as error:
        print('Fatal error: {}'.format(error))


def get_best_word_google_ngrams(words):
    best_word = ''
    maxi = -1
    for word in words:
        score = google_ngrams(word)
        print "word",word,score
        if(maxi < score):
            best_word = word
            maxi = score
    return best_word
# print (google_ngrams("water"))